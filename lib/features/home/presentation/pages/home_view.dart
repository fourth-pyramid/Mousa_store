import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_state_manager/internet_state_manager.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/features/home/presentation/bloc/home_bloc.dart';
import 'package:mousa_store/features/home/presentation/bloc/home_event.dart';
import 'package:mousa_store/features/home/presentation/widgets/home_all_products_section.dart';
import 'package:mousa_store/features/home/presentation/widgets/home_banner_slider_section.dart';
import 'package:mousa_store/features/home/presentation/widgets/home_brands_section.dart';
import 'package:mousa_store/features/home/presentation/widgets/home_categories_section.dart';
import 'package:mousa_store/features/home/presentation/widgets/home_offers_section.dart';
import 'package:mousa_store/features/home/presentation/widgets/home_recently_added_section.dart';
import 'package:mousa_store/features/home/presentation/widgets/home_services_banner_section.dart';
import 'package:mousa_store/features/search/presentation/widgets/search_text_field.dart';

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
    context.read<HomeBloc>().add(const HomeAllDataRequested());
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
      context.read<HomeBloc>().add(const HomeLoadMoreProductsRequested());
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
          onRefresh: () async =>
              context.read<HomeBloc>().add(const HomeAllDataRequested()),
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              const SliverToBoxAdapter(
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
              const HomeAllProductsSection(),
              SliverToBoxAdapter(child: SizedBox(height: 100.h)),
            ],
          ),
        ),
      ),
    ),
    floatingActionButton: _showBackToTopButton
        ? Padding(
            padding: EdgeInsets.only(bottom: 75.h),
            child: FloatingActionButton(
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
            ),
          )
        : null,
    floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
  );
}
