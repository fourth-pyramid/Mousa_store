import 'package:flutter/material.dart';
import 'package:mousa_store/features/product/view/widgets/attribute_picker.dart';

class ProductAttributeSection extends StatelessWidget {
  const ProductAttributeSection({
    required this.values,
    required this.selectedValue,
    required this.onValueSelected,
    this.availableValues = const [],
    super.key,
  });

  final List<String> values;
  final List<String> availableValues;
  final String? selectedValue;
  final ValueChanged<String> onValueSelected;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AttributePicker(
        values: values,
        selectedValue: selectedValue,
        onValueSelected: onValueSelected,
        availableValues: availableValues,
      ),
    ],
  );
}
