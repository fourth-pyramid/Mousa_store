import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/features/product/model/product_details_response.dart';
import 'package:mousa_store/features/product/view/widgets/review_summary_card.dart';
import 'package:mousa_store/features/product/view/widgets/stars_widget.dart';

class ProductReviewsSection extends StatelessWidget {
  const ProductReviewsSection({required this.product, super.key});

  final ProductDetail product;

  @override
  Widget build(BuildContext context) {
    final reviews = product.reviews ?? [];

    if (reviews.isEmpty) {
      return Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.no_reviews_yet_text,
              style: context.typography.body.copyWith(
                color: context.colors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReviewSummaryCard(
          averageRating: product.averageRating,
          distribution: product.ratingDistribution,
          totalReviews: product.reviewsCount,
        ),
      ],
    );
  }
}

class _ReviewItem extends StatelessWidget {
  const _ReviewItem({required this.review});

  final ProductReview review;

  String formatDate(String date) {
    final parsedDate = DateTime.parse(date);
    return '${parsedDate.day.toString().padLeft(2, '0')}/'
        '${parsedDate.month.toString().padLeft(2, '0')}/'
        '${parsedDate.year}';
  }

  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.only(bottom: 12.h),
    padding: EdgeInsets.all(12.w),
    decoration: BoxDecoration(
      color: context.colors.surface,
      borderRadius: context.radius.smBorder,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if ((review.user?.firstName.isNotEmpty ?? false) ||
                (review.user?.lastName.isNotEmpty ?? false))
              Text(
                '${review.user?.firstName ?? ''} ${review.user?.lastName ?? ''}'
                    .trim(),
                style: context.typography.titleSmall.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            const Spacer(),
            StarsWidget(rate: review.rate),
          ],
        ),
        SizedBox(height: 8.h),
        if (review.comment.isNotEmpty)
          Text(review.comment, style: context.typography.body),
        if (review.createdAt != null)
          Text(
            formatDate(review.createdAt!),
            style: context.typography.bodySmall.copyWith(
              color: context.colors.textSecondary,
            ),
          ),
      ],
    ),
  );
}

class AllReviewsSheet extends StatelessWidget {
  const AllReviewsSheet({required this.product, super.key});

  final ProductDetail product;

  @override
  Widget build(BuildContext context) {
    final sortedReviews = List<ProductReview>.from(product.reviews ?? [])
      ..sort((a, b) {
        if (a.createdAt == null) return 1;
        if (b.createdAt == null) return -1;
        return b.createdAt!.compareTo(a.createdAt!);
      });

    final reviewsTitle = context.l10n.product_reviews_text;

    return Container(
      padding: EdgeInsets.all(16.w),
      height: 0.8.sh,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$reviewsTitle (${product.reviewsCount})',
                style: context.typography.titleLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: ListView.builder(
              itemCount: sortedReviews.length,
              itemBuilder: (context, index) =>
                  _ReviewItem(review: sortedReviews[index]),
            ),
          ),
        ],
      ),
    );
  }
}
