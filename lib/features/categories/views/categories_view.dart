import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_state_manager/internet_state_manager.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/navigation_helper.dart';
import 'package:mousa_store/core/widgets/app_error_state.dart';
import 'package:mousa_store/core/widgets/custom_loading_indicator.dart';
import 'package:mousa_store/features/categories/viewmodels/category_cubit.dart';
import 'package:mousa_store/features/categories/viewmodels/category_state.dart';
import 'package:mousa_store/features/categories/views/widgets/category_list_item.dart';
import 'package:mousa_store/features/category_items/services/category_items_service.dart';
import 'package:mousa_store/features/category_items/views/category_items_view.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  @override
  void initState() {
    unawaited(context.read<CategoryCubit>().getCategories());
    super.initState();
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
          unawaited(context.read<CategoryCubit>().getCategories());
        },
        child: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            if (state.status == RequestStatus.loading) {
              return const Center(child: CustomLoadingIndicator());
            }

            if (state.status == RequestStatus.failure) {
              return AppErrorState(
                message:
                    state.errorMessage ?? context.l10n.error_while_loading_text,
                onRetry: () => context.read<CategoryCubit>().getCategories(),
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
