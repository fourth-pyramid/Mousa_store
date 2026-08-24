import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/features/setting_profile/view_model/language_cubit/language_cubit.dart';

class LanguageSelectionSheet extends StatelessWidget {
  const LanguageSelectionSheet({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<LanguageCubit, LanguageState>(
    builder: (context, state) {
      final currentLocale = state.locale;
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildLanguageOption(
            context,
            title: context.l10n.english_text,
            value: const Locale('en'),
            groupValue: currentLocale,
            flagText: '🇺🇸',
          ),
          _buildLanguageOption(
            context,
            title: context.l10n.arabic_text,
            value: const Locale('ar'),
            groupValue: currentLocale,
            flagText: '🇪🇬',
          ),
        ],
      );
    },
  );

  Widget _buildLanguageOption(
    BuildContext context, {
    required String title,
    required Locale value,
    required Locale groupValue,
    required String flagText,
  }) {
    final isSelected = value.languageCode == groupValue.languageCode;
    final activeColor = context.colors.textPrimary;
    final inactiveColor = context.colors.textSecondary;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        color: isSelected ? context.colors.surfaceStrong : context.colors.transparent,
        borderRadius: context.radius.smBorder,
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          onTap: () {
            if (isSelected) {
              Navigator.pop(context);
              return;
            }

            unawaited(context.read<LanguageCubit>().changeLanguage(value));
            Navigator.pop(context);
          },
          leading: Text(flagText, style: const TextStyle(fontSize: 24)),
          title: Text(
            title,
            style: context.typography.bodyLarge.copyWith(
              color: isSelected ? activeColor : inactiveColor,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          trailing: isSelected ? Icon(Icons.check_circle, color: activeColor) : null,
        ),
      ),
    );
  }
}
