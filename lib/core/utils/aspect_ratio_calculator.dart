import 'package:flutter/widgets.dart';

double aspectRatioCalculator(
  BoxConstraints constraints, {
  int crossAxisCount = 2,
}) {
  const spacing = 10.0;
  final width =
      (constraints.maxWidth - (crossAxisCount - 1) * spacing) / crossAxisCount;

  const imageHeight = 100.0;
  const titleHeight = 18.0;
  const descriptionHeight = 30.0;
  const verticalPadding = 8.0 * 6;

  const height =
      imageHeight + titleHeight + descriptionHeight + verticalPadding;
  final childAspectRatio = width / height;
  return childAspectRatio;
}

double itemHeightCalculator(
  BoxConstraints constraints, {
  int crossAxisCount = 2,
}) {
  const imageHeight = 200.0;

  return imageHeight;
}
