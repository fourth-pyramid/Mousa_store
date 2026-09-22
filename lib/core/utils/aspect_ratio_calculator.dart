import 'package:flutter/widgets.dart';
import 'package:mousa_store/core/utils/screen_utils.dart';

double aspectRatioCalculator(
  BoxConstraints constraints, {
  int crossAxisCount = 2,
}) {
  final spacing = 10.w;
  final width =
      (constraints.maxWidth - (crossAxisCount - 1) * spacing) / crossAxisCount;

  final imageHeight = 100.h;
  final titleHeight = 18.h;
  final descriptionHeight = 30.h;
  final verticalPadding = 8.h * 6;

  final height =
      imageHeight + titleHeight + descriptionHeight + verticalPadding;
  final childAspectRatio = width / height;
  return childAspectRatio;
}

double itemHeightCalculator(
  BoxConstraints constraints, {
  int crossAxisCount = 2,
}) {
  final imageHeight = 200.h;

  final height = imageHeight;

  return height;
}
