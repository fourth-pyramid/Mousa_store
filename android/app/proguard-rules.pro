# Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Firebase (firebase_core, firebase_messaging)
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**

# Retain generic type information for use by reflection by converters and serialization
-keepattributes Signature
-keepattributes *Annotation*
-keepattributes EnclosingMethod
-keepattributes InnerClasses,Exceptions

# Default flutter proguard rules
# https://github.com/flutter/flutter/wiki/Obfuscating-Dart-Code
-keep class io.flutter.embedding.engine.FlutterJNI { *; }

# Suppress warnings for Play Store classes (deferred components)
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.SplitInstallException
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManager
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManagerFactory
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest$Builder
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest
-dontwarn com.google.android.play.core.splitinstall.SplitInstallSessionState
-dontwarn com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task

# App-specific rules (Dio/OkHttp, Awesome Notifications)
-dontwarn okhttp3.**
-dontwarn okio.**
-dontwarn javax.annotation.**

# Awesome Notifications
-keep class me.carda.awesome_notifications.** { *; }
-dontwarn me.carda.awesome_notifications.**

# ponytail: App-specific ProGuard rules for Baynona
