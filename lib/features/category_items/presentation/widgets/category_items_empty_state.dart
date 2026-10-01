import 'package:flutter/material.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/widgets/app_empty_state.dart';

class CategoryItemsEmptyState extends StatelessWidget {
  const CategoryItemsEmptyState({super.key});

  @override
  Widget build(BuildContext context) => AppEmptyState(
    title: context.l10n.empty_category_items_title,
    description: context.l10n.empty_category_items_message,
    icon: Icons.inventory_2_outlined,
  );
}
