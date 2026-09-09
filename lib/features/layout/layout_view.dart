import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/di/locator.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/features/cart/viewmodels/cart_cubit.dart';
import 'package:mousa_store/features/cart/views/products_cart.dart';
import 'package:mousa_store/features/favorites/views/favorites_view.dart';
import 'package:mousa_store/features/home/viewmodels/home_cubit.dart';
import 'package:mousa_store/features/home/views/home_view.dart';
import 'package:mousa_store/features/profile/profile_view.dart';
import 'package:mousa_store/features/setting_profile/view_model/language_cubit/language_cubit.dart';
import 'package:mousa_store/features/wholesale_or_retail/view_model/price_mode_cubit.dart';

enum LayoutTab {
  home,
  cart,
  favorites,
  profile;

  static LayoutTab fromIndex(int index) => LayoutTab.values[index];

  IconData get icon {
    switch (this) {
      case LayoutTab.home:
        return Icons.home_outlined;
      case LayoutTab.cart:
        return Icons.shopping_bag_outlined;
      case LayoutTab.favorites:
        return Icons.favorite_border_rounded;
      case LayoutTab.profile:
        return Icons.person_outline_rounded;
    }
  }

  IconData get activeIcon {
    switch (this) {
      case LayoutTab.home:
        return Icons.home_rounded;
      case LayoutTab.cart:
        return Icons.shopping_bag_rounded;
      case LayoutTab.favorites:
        return Icons.favorite_rounded;
      case LayoutTab.profile:
        return Icons.person_rounded;
    }
  }

  String label(BuildContext context) {
    switch (this) {
      case LayoutTab.home:
        return context.l10n.home_tab;
      case LayoutTab.cart:
        return context.l10n.cart_tab;
      case LayoutTab.favorites:
        return context.l10n.favorites_tab;
      case LayoutTab.profile:
        return context.l10n.profile_tab;
    }
  }
}

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  final ValueNotifier<LayoutTab> _currentTabNotifier = ValueNotifier<LayoutTab>(
    LayoutTab.home,
  );
  final ValueNotifier<int> _rebuildNotifier = ValueNotifier<int>(0);
  DateTime? _lastBackPressTime;

  late final List<Widget?> _screens;

  @override
  void initState() {
    super.initState();
    _screens = List.filled(LayoutTab.values.length, null);
  }

  @override
  void dispose() {
    _currentTabNotifier.dispose();
    _rebuildNotifier.dispose();
    super.dispose();
  }

  Widget _getScreen(LayoutTab tab) {
    final index = tab.index;
    if (_screens[index] != null) return _screens[index]!;

    switch (tab) {
      case LayoutTab.home:
        _screens[index] = BlocProvider(
          create: (context) => getIt<HomeCubit>(),
          child: const HomeView(key: PageStorageKey('home')),
        );
      case LayoutTab.cart:
        _screens[index] = BlocProvider.value(
          value: getIt<CartCubit>(),
          child: ProductsCart(
            key: const PageStorageKey('cart'),
            gnToHome: () => _currentTabNotifier.value = LayoutTab.home,
          ),
        );
      case LayoutTab.favorites:
        _screens[index] = const FavoritesView(key: PageStorageKey('favorites'));
      case LayoutTab.profile:
        _screens[index] = ProfileView(
          key: const PageStorageKey('profile'),
          goToFavourte: () => _currentTabNotifier.value = LayoutTab.favorites,
        );
    }
    return _screens[index]!;
  }

  void showToast(String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Center(
        child: Material(
          color: context.colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            decoration: BoxDecoration(
              color: context.colors.textPrimary,
              borderRadius: context.radius.smBorder,
            ),
            child: Text(
              message,
              style: context.typography.body.copyWith(
                color: context.colors.surface,
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    unawaited(
      Future.delayed(const Duration(seconds: 2), () {
        if (overlayEntry.mounted) {
          overlayEntry.remove();
        }
      }),
    );
  }

  void _clearCache() {
    _screens.fillRange(0, _screens.length, null);
    _rebuildNotifier.value++;
  }

  @override
  Widget build(BuildContext context) => MultiBlocListener(
    listeners: [
      BlocListener<PriceModeCubit, PriceModeState>(
        listener: (context, state) {
          _clearCache();
        },
      ),
      BlocListener<LanguageCubit, LanguageState>(
        listener: (context, state) {
          _clearCache();
        },
      ),
    ],
    child: ValueListenableBuilder<int>(
      valueListenable: _rebuildNotifier,
      builder: (context, _, _) => ValueListenableBuilder<LayoutTab>(
        valueListenable: _currentTabNotifier,
        builder: (context, currentTab, _) => PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) return;

            if (currentTab != LayoutTab.home) {
              _currentTabNotifier.value = LayoutTab.home;
              return;
            }

            final now = DateTime.now();
            if (_lastBackPressTime == null ||
                now.difference(_lastBackPressTime!) >
                    const Duration(seconds: 2)) {
              _lastBackPressTime = now;
              showToast(context.l10n.press_again_to_exit_text);
              return;
            }
            unawaited(SystemNavigator.pop());
          },
          child: Scaffold(
            body: Stack(
              children: LayoutTab.values.map((tab) {
                final isCurrent = currentTab == tab;
                final index = tab.index;
                if (!isCurrent && _screens[index] == null) {
                  return const SizedBox.shrink();
                }

                return Offstage(
                  offstage: !isCurrent,
                  child: TickerMode(
                    enabled: isCurrent,
                    child: KeyedSubtree(
                      key: ValueKey(tab),
                      child: _getScreen(tab),
                    ),
                  ),
                );
              }).toList(),
            ),
            bottomNavigationBar: Builder(
              builder: (context) => DecoratedBox(
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  border: Border(top: BorderSide(color: context.colors.border)),
                ),
                child: SafeArea(
                  top: false,
                  child: Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: LayoutTab.values.map((tab) {
                        final isSelected = currentTab == tab;
                        final activeColor = context.colors.textPrimary;
                        final inactiveColor = context.colors.textSecondary;

                        return Expanded(
                          child: InkWell(
                            onTap: () => _currentTabNotifier.value = tab,
                            splashColor: context.colors.transparent,
                            highlightColor: context.colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  isSelected ? tab.activeIcon : tab.icon,
                                  color: isSelected
                                      ? activeColor
                                      : inactiveColor,
                                  size: 22,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  tab.label(context),
                                  style: context.typography.caption.copyWith(
                                    color: isSelected
                                        ? activeColor
                                        : inactiveColor,
                                    fontSize: 10,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
