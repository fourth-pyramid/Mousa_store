import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/di/service_locator.dart';
import 'package:mousa_store/core/service/internet_connection_service.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/widgets/app_error_state.dart';
import 'package:mousa_store/core/widgets/custom_loading_indicator.dart';
import 'package:mousa_store/features/brands/presentation/bloc/brand_bloc.dart';
import 'package:mousa_store/features/brands/presentation/widgets/brand_card.dart';

class BrandsView extends StatefulWidget {
  const BrandsView({super.key});

  @override
  State<BrandsView> createState() => _BrandsViewState();
}

class _BrandsViewState extends State<BrandsView> {
  StreamSubscription<void>? _networkRestoreSubscription;

  @override
  void initState() {
    super.initState();
    context.read<BrandBloc>().add(const BrandFetchStarted());
    _networkRestoreSubscription = getIt<InternetConnectionService>()
        .connectivityRestoredStream
        .listen((_) {
          if (mounted) {
            context.read<BrandBloc>().add(const BrandRefreshRequested());
          }
        });
  }

  @override
  void dispose() {
    unawaited(_networkRestoreSubscription?.cancel());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(context.l10n.all_brands_text.toUpperCase()),
      backgroundColor: context.colors.background,
    ),
    body: SafeArea(
      child: BlocBuilder<BrandBloc, BrandState>(
        builder: (context, state) {
          if (state.status == BrandStatus.loading && state.brands.isEmpty) {
            return const Center(child: CustomLoadingIndicator());
          }

          if (state.status == BrandStatus.failure && state.brands.isEmpty) {
            return AppErrorState(
              message:
                  state.errorMessage ?? context.l10n.error_while_loading_text,
              onRetry: () =>
                  context.read<BrandBloc>().add(const BrandFetchStarted()),
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

          return LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = (constraints.maxWidth / 160).floor().clamp(
                2,
                4,
              );

              return GridView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.1,
                ),
                itemCount: state.brands.length,
                itemBuilder: (context, index) {
                  final brand = state.brands[index];
                  return BrandCard(brand: brand);
                },
              );
            },
          );
        },
      ),
    ),
  );
}
