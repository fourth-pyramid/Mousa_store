import 'package:flutter/material.dart';
import 'package:mousa_store/l10n/app_localizations.dart';

export 'package:mousa_store/core/design_system/design_system.dart';

extension ContextExtensions on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;

  ThemeData get theme => Theme.of(this);
}
