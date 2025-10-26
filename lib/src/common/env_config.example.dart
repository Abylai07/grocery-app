/// Environment Configuration Template
///
/// IMPORTANT: Copy this file to 'env_config.dart' and fill in your actual values.
/// The 'env_config.dart' file is gitignored for security.
///
/// Usage:
/// 1. Copy this file: cp env_config.example.dart env_config.dart
/// 2. Fill in your actual API keys and secrets in env_config.dart
/// 3. Never commit env_config.dart to version control

class EnvConfig {
  // Google Maps API Key
  // Get your key from: https://console.cloud.google.com/google/maps-apis
  static const String googleMapsApiKey = 'YOUR_GOOGLE_MAPS_API_KEY_HERE';

  // Development API Key (if applicable)
  static const String devKey = 'YOUR_DEV_KEY_HERE';

  // API Endpoints
  // Replace with your actual backend API URLs
  static const String apiBaseUrl = 'https://api.example.com/v1/';
  static const String apiBaseUrlDev = 'https://dev-api.example.com/v1/';

  // Environment flag
  static const bool isProduction = true;

  // Use mock data for demonstration (set to true to use fixtures instead of API)
  static const bool useMockData = true;

  // Get current API base URL based on environment
  static String get currentApiUrl => isProduction ? apiBaseUrl : apiBaseUrlDev;
}