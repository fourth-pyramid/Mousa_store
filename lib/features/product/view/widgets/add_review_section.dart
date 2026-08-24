import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mousa_store/core/di/locator.dart';
import 'package:mousa_store/core/service/auth_service.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/utils/custom_snack_bar.dart';
import 'package:mousa_store/core/utils/show_login_dialog.dart';
import 'package:mousa_store/core/widgets/custom_button.dart';
import 'package:mousa_store/core/widgets/custom_form_field.dart';
import 'package:mousa_store/features/product/view_model/reviews_cubit/review_cubit.dart';
import 'package:mousa_store/features/product/view_model/reviews_cubit/review_state.dart';

class AddReviewSection extends StatefulWidget {
  const AddReviewSection({required this.productId, super.key});

  final int productId;

  @override
  State<AddReviewSection> createState() => _AddReviewSectionState();
}

class _AddReviewSectionState extends State<AddReviewSection> {
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _commentFocusNode = FocusNode();
  final ValueNotifier<double> _rateNotifier = ValueNotifier<double>(0);

  @override
  void dispose() {
    _commentController.dispose();
    _commentFocusNode.dispose();
    _rateNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.all(16.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.add_your_review_text,
          style: context.typography.titleMedium.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.h),

        ValueListenableBuilder<double>(
          valueListenable: _rateNotifier,
          builder: (context, rate, _) => _StarsInput(
            initialRate: rate,
            onRateChanged: (newRate) {
              _rateNotifier.value = newRate;
            },
          ),
        ),
        SizedBox(height: 8.h),

        Row(
          children: [
            Expanded(
              child: CustomFormField(
                controller: _commentController,
                focusNode: _commentFocusNode,
                hint: context.l10n.write_comment_hint_text,
              ),
            ),
            SizedBox(width: 8.w),

            BlocBuilder<ReviewCubit, ReviewState>(
              builder: (context, state) {
                final isLoading = state.status == ReviewStatus.loading;
                return AppButton(
                  width: 52.w,
                  height: 52.h,
                  isFullWidth: false,
                  variant: AppButtonVariant.accent,
                  onPressed: isLoading
                      ? null
                      : () {
                          if (getIt<AuthService>().isLoggedIn) {
                            if (_rateNotifier.value == 0) {
                              CustomSnackBar.show(context, context.l10n.please_select_rating_text);
                              return;
                            }
                            unawaited(
                              context.read<ReviewCubit>().addReview(
                                productId: widget.productId,
                                rate: _rateNotifier.value,
                                comment: _commentController.text.trim(),
                              ),
                            );
                            _commentController.clear();
                            _commentFocusNode.unfocus();
                            _rateNotifier.value = 0;
                          } else {
                            showLoginDialog(context);
                          }
                        },
                  isLoading: isLoading,
                  text: '',
                  icon: const Icon(Icons.send),
                );
              },
            ),
          ],
        ),
      ],
    ),
  );
}

class _StarsInput extends StatelessWidget {
  const _StarsInput({required this.initialRate, required this.onRateChanged});

  final double initialRate;
  final void Function(double) onRateChanged;

  @override
  Widget build(BuildContext context) => Row(
    children: List.generate(5, (index) {
      final filled = index < initialRate;
      return IconButton(
        onPressed: () => onRateChanged(index + 1.0),
        icon: Icon(
          filled ? Icons.star : Icons.star_border,
          color: context.colors.secondary,
        ),
      );
    }),
  );
}
