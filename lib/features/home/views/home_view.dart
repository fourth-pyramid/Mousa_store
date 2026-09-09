import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_state_manager/internet_state_manager.dart';
import 'package:mousa_store/core/design_system/design_system.dart';
import 'package:mousa_store/features/home/viewmodels/home_cubit.dart';
import 'package:mousa_store/features/home/views/widgets/home_all_products_section.dart';
import 'package:mousa_store/features/home/views/widgets/home_banner_slider_section.dart';
import 'package:mousa_store/features/home/views/widgets/home_brands_section.dart';
import 'package:mousa_store/features/home/views/widgets/home_categories_section.dart';
import 'package:mousa_store/features/home/views/widgets/home_offers_section.dart';
import 'package:mousa_store/features/home/views/widgets/home_recently_added_section.dart';
import 'package:mousa_store/features/home/views/widgets/home_services_banner_section.dart';
import 'package:mousa_store/features/search/view/widgets/search_text_field.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final ScrollController _scrollController;
  bool _showBackToTopButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _initData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _initData() {
    unawaited(context.read<HomeCubit>().fetchAllData());
  }

  void _onScroll() {
    if (_scrollController.offset > 500 && !_showBackToTopButton) {
      setState(() {
        _showBackToTopButton = true;
      });
    } else if (_scrollController.offset <= 500 && _showBackToTopButton) {
      setState(() {
        _showBackToTopButton = false;
      });
    }
    if (_isBottom) {
      unawaited(context.read<HomeCubit>().loadMoreProducts());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      titleSpacing: 16,
      title: const SearchTextField(),
      backgroundColor: context.colors.background,
      elevation: 0,
    ),
    body: SafeArea(
      child: InternetStateManager(
        onRestoreInternetConnection: _initData,
        child: RefreshIndicator(
          color: context.colors.primary,
          onRefresh: () async => context.read<HomeCubit>().fetchAllData(),
          child: CustomScrollView(
            controller: _scrollController,
            slivers: const [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeBannerSliderSection(),
                    HomeBrandsSection(),
                    HomeOffersSection(),
                    HomeCategoriesSection(),
                    HomeRecentlyAddedSection(),
                    HomeServicesBannerSection(),
                  ],
                ),
              ),
              HomeAllProductsSection(),
              SliverToBoxAdapter(child: SizedBox(height: 20)),
            ],
          ),
        ),
      ),
    ),
    floatingActionButton: _showBackToTopButton
        ? FloatingActionButton(
            mini: true,
            onPressed: () {
              unawaited(
                _scrollController.animateTo(
                  0,
                  duration: context.durations.pageTransition,
                  curve: Curves.easeInOut,
                ),
              );
            },
            child: const Icon(Icons.arrow_upward, size: 18),
          )
        : null,
    floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
  );
}
