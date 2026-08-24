# Bynona - E-Commerce Mobile Application

A modern Flutter-based e-commerce mobile application that supports both wholesale and retail purchasing modes with bilingual support (English & Arabic).

## 📱 Features

### Core Features

- **Dual Purchase Modes**: Switch between wholesale and retail pricing
- **Multi-language Support**: Full English and Arabic localization
- **Theme Support**: Light and dark mode themes
- **User Authentication**: Complete auth flow with OTP verification
- **Product Catalog**: Browse products by categories with advanced filtering
- **Shopping Cart**: Add, update, and manage cart items
- **Favorites**: Save and manage favorite products
- **Order Management**: Track orders and view order history
- **Product Reviews**: View and submit product reviews
- **Search**: Advanced product search functionality
- **Notifications**: Firebase Cloud Messaging integration with local notifications
- **Address Management**: Save and manage multiple shipping addresses
- **Payment Options**: Support for multiple payment methods including credit cards and cash on delivery
- **Offline Support**: Connectivity monitoring and offline state handling

### Technical Features

- **State Management**: BLoC pattern with flutter_bloc
- **Dependency Injection**: GetIt service locator
- **Network Caching**: Cached network images for optimal performance
- **Responsive UI**: Screen size adaptation with flutter_screenutil
- **Smooth Animations**: Enhanced UX with smooth transitions and loading states
- **Firebase Integration**: Push notifications and cloud messaging

## 🛠️ Tech Stack

### Framework & Language

- **Flutter SDK**: ^3.10.0
- **Dart**: ^3.10.0

### Key Dependencies

- **State Management**: `flutter_bloc` (^9.1.1)
- **Dependency Injection**: `get_it` (^8.0.2)
- **Networking**: `dio` (^5.9.0)
- **Local Storage**: `shared_preferences` (^2.5.3)
- **Firebase**:
  - `firebase_core` (^4.3.0)
  - `firebase_messaging` (^16.1.0)
- **Notifications**: `awesome_notifications` (^0.10.1)
- **UI Components**:
  - `google_fonts` (^6.3.2)
  - `cached_network_image` (^3.4.1)
  - `carousel_slider` (^5.1.1)
  - `smooth_page_indicator` (^1.2.1)
  - `skeletonizer` (^2.1.1)
  - `flutter_screenutil` (^5.9.3)
  - `circle_nav_bar` (^2.2.0)
- **Connectivity**:
  - `connectivity_plus` (^7.0.0)
  - `internet_state_manager` (^1.10.1+3)
- **Utilities**:
  - `intl` (^0.20.2)
  - `uuid` (^4.5.2)
  - `fluttertoast` (^9.0.0)

## 📋 Prerequisites

Before running this project, ensure you have the following installed:

1. **Flutter SDK** (version 3.10.0 or higher)
   - Download from: <https://flutter.dev/docs/get-started/install>
   - Verify installation: `flutter --version`

2. **Dart SDK** (comes with Flutter)

3. **Android Studio** or **Xcode** (for iOS development)
   - Android Studio: <https://developer.android.com/studio>
   - Xcode: Available on Mac App Store (macOS only)

4. **Git** (for version control)

5. **Firebase Account** (for push notifications)
   - Create a project at: <https://console.firebase.google.com>

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone <repository-url>
cd bynona
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Firebase Configuration

This project uses Firebase for push notifications. The Firebase configuration files are already included:

- **Android**: `android/app/google-services.json`
- **iOS**: `ios/Runner/GoogleService-Info.plist`
- **Flutter**: `lib/firebase_options.dart`

If you need to set up your own Firebase project:

1. Create a new Firebase project at <https://console.firebase.google.com>
2. Add Android and/or iOS apps to your Firebase project
3. Download the configuration files:
   - For Android: Download `google-services.json` and place it in `android/app/`
   - For iOS: Download `GoogleService-Info.plist` and place it in `ios/Runner/`
4. Run the FlutterFire CLI to generate `firebase_options.dart`:

   ```bash
   flutter pub global activate flutterfire_cli
   flutterfire configure
   ```

### 4. Run the Application

#### For Android

```bash
flutter run
```

#### For iOS (macOS only)

```bash
cd ios
pod install
cd ..
flutter run
```

#### For a specific device

```bash
# List available devices
flutter devices

# Run on a specific device
flutter run -d <device-id>
```

## 🏗️ Project Structure

```
lib/
├── core/                    # Core functionality and utilities
│   ├── main/               # App initialization and content
│   └── service/            # Service locator and dependency injection
├── features/               # Feature modules
│   ├── auth/              # Authentication (login, register, OTP)
│   ├── cart/              # Shopping cart management
│   ├── categories/        # Product categories
│   ├── category_items/    # Category product listings
│   ├── favorites/         # Favorite products
│   ├── home/              # Home screen and dashboard
│   ├── layout/            # App layout and navigation
│   ├── notification/      # Push notifications
│   ├── onboarding/        # Onboarding screens
│   ├── orders/            # Order management and history
│   ├── product/           # Product details and reviews
│   ├── profile/           # User profile
│   ├── search/            # Product search
│   ├── setting_profile/   # App settings (theme, language)
│   └── wholesale_or_retail/ # Purchase mode selection
├── l10n/                  # Localization files (English & Arabic)
├── firebase_options.dart  # Firebase configuration
└── main.dart             # Application entry point
```

## 🌍 Localization

The app supports two languages:

- **English** (en)
- **Arabic** (ar)

Localization files are located in `lib/l10n/`:

- `app_en.arb` - English translations
- `app_ar.arb` - Arabic translations

To add or modify translations, edit the respective `.arb` files and run:

```bash
flutter gen-l10n
```

## 🎨 Theming

The app supports both light and dark themes. Users can switch between themes in the settings.

## 🔧 Build Configuration

### Development Build

```bash
flutter run --debug
```

### Release Build

#### Android APK

```bash
flutter build apk --release
```

#### Android App Bundle (for Play Store)

```bash
flutter build appbundle --release
```

#### iOS (macOS only)

```bash
flutter build ios --release
```

## 📦 Assets

The project uses the following asset directories:

- `assets/on_boarding/` - Onboarding screen images
- `assets/images/` - General application images
- `assets/icons/` - Application icons

## 🧪 Testing

Run tests with:

```bash
flutter test
```

## 🐛 Troubleshooting

### Common Issues

1. **Firebase initialization error**
   - Ensure `google-services.json` (Android) or `GoogleService-Info.plist` (iOS) is properly configured
   - Run `flutterfire configure` to regenerate Firebase configuration

2. **Dependency conflicts**

   ```bash
   flutter clean
   flutter pub get
   ```

3. **iOS build issues**

   ```bash
   cd ios
   pod deintegrate
   pod install
   cd ..
   flutter clean
   flutter run
   ```

4. **Android build issues**
   - Ensure Android SDK is properly installed
   - Check `android/local.properties` for correct SDK path
   - Try invalidating cache in Android Studio

## 📱 Minimum Requirements

- **Android**: API level 21 (Android 5.0) or higher
- **iOS**: iOS 12.0 or higher

## 🔐 Permissions

The app requires the following permissions:

### Android

- Internet access
- Network state
- Notification permissions

### iOS

- Network access
- Push notification permissions

## 📄 License

This project is proprietary software. All rights reserved.

## 👥 Support

For issues, questions, or contributions, please contact the development team.

---

**Version**: 1.0.0+1

**Last Updated**: December 2025
#   M o u s a _ s t o r e  
 