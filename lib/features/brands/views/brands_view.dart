import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_state_manager/internet_state_manager.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/widgets/app_error_state.dart';
import 'package:mousa_store/core/widgets/custom_loading_indicator.dart';
import 'package:mousa_store/features/brands/viewmodels/brand_cubit.dart';
import 'package:mousa_store/features/brands/viewmodels/brand_state.dart';
import 'package:mousa_store/features/brands/views/widgets/brand_card.dart';

class BrandsView extends StatefulWidget {
  const BrandsView({super.key});

  @override
  State<BrandsView> createState() => _BrandsViewState();
}

class _BrandsViewState extends State<BrandsView> {
  @override
  void initState() {
    super.initState();
    unawaited(context.read<BrandCubit>().getBrands());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(context.l10n.all_brands_text.toUpperCase()),
      backgroundColor: context.colors.background,
    ),
    body: SafeArea(
      child: InternetStateManager(
        onRestoreInternetConnection: () {
          unawaited(context.read<BrandCubit>().getBrands());
        },
        child: BlocBuilder<BrandCubit, BrandState>(
          builder: (context, state) {
            if (state.status == RequestStatus.loading) {
              return const Center(child: CustomLoadingIndicator());
            }

            if (state.status == RequestStatus.failure) {
              return AppErrorState(
                message:
                    state.errorMessage ?? context.l10n.error_while_loading_text,
                onRetry: () => context.read<BrandCubit>().getBrands(),
              );
            }

            if (state.brands.isEmpty) {
              return Center(
                child: Text(
                  context.l10n.no_data_text,
                  style: context.typography.body.copyWith(
                    color: context.colors.textSecondary,
                  ),
                ),
              );
            }

            return GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
                childAspectRatio: 1.1,
              ),
              itemCount: state.brands.length,
              itemBuilder: (context, index) {
                final brand = state.brands[index];
                return BrandCard(brand: brand);
              },
            );
          },
        ),
      ),
    ),
  );
}
