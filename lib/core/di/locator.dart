import 'package:flutter/material.dart';
import 'package:mousa_store/core/di/service_locator.dart';

export 'package:mousa_store/core/di/service_locator.dart';

/// Backwards-compatible setupDi alias delegating to centralized setupServiceLocator
Future<void> setupDi({ThemeMode initialThemeMode = ThemeMode.system}) =>
    setupServiceLocator(initialThemeMode: initialThemeMode);
