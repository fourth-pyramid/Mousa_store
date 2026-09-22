import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Centralized configuration access for environment variables loaded from `.env`.
abstract final class AppEnv {
  static const String _defaultBaseUrl = 'https://bynona.store/api/v1/';
  static const String _defaultAppName = 'Mousa Store';
  static const int _defaultTimeout = 30000;

  static String _get(String key, {required String fallback}) {
    if (!dotenv.isInitialized) {
      return fallback;
    }
    return dotenv.get(key, fallback: fallback);
  }

  /// Base API URL
  static String get baseUrl => _get('BASE_URL', fallback: _defaultBaseUrl);

  /// Application display name
  static String get appName => _get('APP_NAME', fallback: _defaultAppName);

  /// API request timeout in milliseconds
  static int get apiTimeout =>
      int.tryParse(_get('API_TIMEOUT', fallback: '$_defaultTimeout')) ??
      _defaultTimeout;

  /// Environment mode (e.g. development, staging, production)
  static String get environment => _get('ENVIRONMENT', fallback: 'production');

  /// Convenience flag to check if running in production
  static bool get isProduction => environment.toLowerCase() == 'production';
}
