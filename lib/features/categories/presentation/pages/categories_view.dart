import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_state_manager/internet_state_manager.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/navigation_helper.dart';
import 'package:mousa_store/core/widgets/app_error_state.dart';
import 'package:mousa_store/core/widgets/custom_loading_indicator.dart';
import 'package:mousa_store/features/categories/presentation/bloc/category_bloc.dart';
import 'package:mousa_store/features/categories/presentation/widgets/category_list_item.dart';
import 'package:mousa_store/features/category_items/domain/entities/item_fetch_type.dart';
import 'package:mousa_store/features/category_items/presentation/pages/category_items_view.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(const CategoryFetchStarted());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(context.l10n.sections_text.toUpperCase()),
      backgroundColor: context.colors.background,
    ),
    body: SafeArea(
      child: InternetStateManager(
        onRestoreInternetConnection: () {
          context.read<CategoryBloc>().add(const CategoryRefreshRequested());
        },
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state.status == CategoryStatus.loading &&
                state.categories.isEmpty) {
              return const Center(child: CustomLoadingIndicator());
            }

            if (state.status == CategoryStatus.failure &&
                state.categories.isEmpty) {
              return AppErrorState(
                message:
                    state.errorMessage ?? context.l10n.error_while_loading_text,
                onRetry: () => context.read<CategoryBloc>().add(
                  const CategoryFetchStarted(),
                ),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.only(top: 12.h, bottom: 24.h),
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                final category = state.categories[index];
                return CategoryListItem(
                  image: category.imagePath ?? '',
                  title: category.name,
                  onTap: () {
                    unawaited(
                      navigateWithTransition<void>(
                        context,
                        CategoryItemsView(
                          fetchType: ItemFetchType.category,
                          categoryName: category.name,
                          categoryId: category.id,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    ),
  );
}
