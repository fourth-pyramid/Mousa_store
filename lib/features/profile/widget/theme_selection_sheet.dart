import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/features/setting_profile/view_model/theme_cubit/theme_cubit.dart';

class ThemeSelectionSheet extends StatelessWidget {
  const ThemeSelectionSheet({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<ThemeCubit, ThemeState>(
    builder: (context, state) {
      final currentTheme = state.themeMode;
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ThemeOptionTile(
            title: context.l10n.light_mode_text,
            value: ThemeMode.light,
            groupValue: currentTheme,
            icon: Icons.light_mode_outlined,
          ),
          _ThemeOptionTile(
            title: context.l10n.dark_mode_text,
            value: ThemeMode.dark,
            groupValue: currentTheme,
            icon: Icons.dark_mode_outlined,
          ),
          _ThemeOptionTile(
            title: context.l10n.system_mode_text,
            value: ThemeMode.system,
            groupValue: currentTheme,
            icon: Icons.phone_android_outlined,
          ),
        ],
      );
    },
  );
}

class _ThemeOptionTile extends StatelessWidget {
  const _ThemeOptionTile({
    required this.title,
    required this.value,
    required this.groupValue,
    required this.icon,
  });

  final String title;
  final ThemeMode value;
  final ThemeMode groupValue;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    final activeColor = context.colors.textPrimary;
    final inactiveColor = context.colors.textSecondary;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Material(
        color: isSelected
            ? context.colors.surfaceStrong
            : context.colors.transparent,
        borderRadius: context.radius.smBorder,
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          onTap: () {
            if (isSelected) {
              Navigator.pop(context);
              return;
            }

            unawaited(context.read<ThemeCubit>().setThemeMode(value));
            Navigator.pop(context);
          },
          leading: Icon(icon, color: isSelected ? activeColor : inactiveColor),
          title: Text(
            title,
            style: context.typography.bodyLarge.copyWith(
              color: isSelected ? activeColor : inactiveColor,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          trailing: isSelected
              ? Icon(Icons.check_circle, color: activeColor)
              : null,
        ),
      ),
    );
  }
}
