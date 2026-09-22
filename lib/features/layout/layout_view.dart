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
          color: Colors.transparent,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: context.colors.textPrimary,
              borderRadius: context.radius.smBorder,
              boxShadow: AppShadows.float,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
              child: Text(
                message,
                style: context.typography.body.copyWith(
                  color: context.colors.surface,
                ),
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
              children: [
                ...LayoutTab.values.map((tab) {
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
                }),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: _FloatingBottomNav(
                    currentTab: currentTab,
                    onTabSelected: (tab) => _currentTabNotifier.value = tab,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

/// Premium floating pill bottom navigation bar
class _FloatingBottomNav extends StatelessWidget {
  const _FloatingBottomNav({
    required this.currentTab,
    required this.onTabSelected,
  });

  final LayoutTab currentTab;
  final ValueChanged<LayoutTab> onTabSelected;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 10.h),
        child: Container(
          height: context.sizes.navBarHeight,
          decoration: BoxDecoration(
            color: isDark ? context.colors.surface : context.colors.background,
            borderRadius: BorderRadius.circular(32.r),
            boxShadow: AppShadows.nav,
            border: Border.all(
              color: context.colors.border.withValues(alpha: 0.5),
              width: 0.8,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: LayoutTab.values
                  .map(
                    (tab) => _NavItem(
                      tab: tab,
                      isSelected: currentTab == tab,
                      onTap: () => onTabSelected(tab),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.tab,
    required this.isSelected,
    required this.onTap,
  });

  final LayoutTab tab;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final activeColor = context.colors.accent;
    final inactiveColor = context.colors.textMuted;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: context.durations.fast,
          curve: Curves.easeInOut,
          child: tab == LayoutTab.cart
              ? _CartNavItem(
                  tab: tab,
                  isSelected: isSelected,
                  activeColor: activeColor,
                  inactiveColor: inactiveColor,
                )
              : _SimpleNavItem(
                  tab: tab,
                  isSelected: isSelected,
                  activeColor: activeColor,
                  inactiveColor: inactiveColor,
                ),
        ),
      ),
    );
  }
}

class _SimpleNavItem extends StatelessWidget {
  const _SimpleNavItem({
    required this.tab,
    required this.isSelected,
    required this.activeColor,
    required this.inactiveColor,
  });

  final LayoutTab tab;
  final bool isSelected;
  final Color activeColor;
  final Color inactiveColor;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      AnimatedSwitcher(
        duration: context.durations.fast,
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: animation,
          child: FadeTransition(opacity: animation, child: child),
        ),
        child: Icon(
          isSelected ? tab.activeIcon : tab.icon,
          key: ValueKey(isSelected),
          color: isSelected ? activeColor : inactiveColor,
          size: context.sizes.navIconSize,
        ),
      ),
      SizedBox(height: 3.h),
      AnimatedDefaultTextStyle(
        duration: context.durations.fast,
        style: context.typography.caption.copyWith(
          color: isSelected ? activeColor : inactiveColor,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
          fontSize: 10.sp,
        ),
        child: Text(tab.label(context)),
      ),
      SizedBox(height: 3.h),
      AnimatedContainer(
        duration: context.durations.fast,
        width: isSelected ? 18.w : 0,
        height: 2.5.h,
        decoration: BoxDecoration(
          color: activeColor,
          borderRadius: BorderRadius.circular(2.r),
        ),
      ),
    ],
  );
}

class _CartNavItem extends StatelessWidget {
  const _CartNavItem({
    required this.tab,
    required this.isSelected,
    required this.activeColor,
    required this.inactiveColor,
  });

  final LayoutTab tab;
  final bool isSelected;
  final Color activeColor;
  final Color inactiveColor;

  @override
  Widget build(BuildContext context) => BlocBuilder<CartCubit, CartState>(
    bloc: getIt<CartCubit>(),
    buildWhen: (prev, curr) => prev.cartCount != curr.cartCount,
    builder: (context, state) {
      final count = state.cartCount;
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              AnimatedSwitcher(
                duration: context.durations.fast,
                transitionBuilder: (child, animation) => ScaleTransition(
                  scale: animation,
                  child: FadeTransition(opacity: animation, child: child),
                ),
                child: Icon(
                  isSelected ? tab.activeIcon : tab.icon,
                  key: ValueKey(isSelected),
                  color: isSelected ? activeColor : inactiveColor,
                  size: context.sizes.navIconSize,
                ),
              ),
              if (count > 0)
                Positioned(
                  top: -4.h,
                  right: -8.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                      vertical: 1.h,
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16.r,
                      minHeight: 16.r,
                    ),
                    decoration: BoxDecoration(
                      color: context.colors.accent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: context.colors.surface,
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      count > 99 ? '99+' : count.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w800,
                        height: 1.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 3.h),
          AnimatedDefaultTextStyle(
            duration: context.durations.fast,
            style: context.typography.caption.copyWith(
              color: isSelected ? activeColor : inactiveColor,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
              fontSize: 10.sp,
            ),
            child: Text(tab.label(context)),
          ),
          SizedBox(height: 3.h),
          AnimatedContainer(
            duration: context.durations.fast,
            width: isSelected ? 18.w : 0,
            height: 2.5.h,
            decoration: BoxDecoration(
              color: activeColor,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
        ],
      );
    },
  );
}
