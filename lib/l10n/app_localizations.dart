import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// Title for the first onboarding screen
  ///
  /// In en, this message translates to:
  /// **'Everything about your phone in one place'**
  String get onboarding_title_1;

  /// Description for the first onboarding screen
  ///
  /// In en, this message translates to:
  /// **'From phones to accessories, all the products you need are available easily and with the best quality.'**
  String get onboarding_desc_1;

  /// Title for the second onboarding screen
  ///
  /// In en, this message translates to:
  /// **'Lots of choices from all your favorite brands'**
  String get onboarding_title_2;

  /// Description for the second onboarding screen
  ///
  /// In en, this message translates to:
  /// **'Discover the latest models and offers from the most famous global and local brands.'**
  String get onboarding_desc_2;

  /// Title for the third onboarding screen
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get onboarding_title_3;

  /// Description for the third onboarding screen
  ///
  /// In en, this message translates to:
  /// **'Log in or create a new account to start shopping easily.'**
  String get onboarding_desc_3;

  /// Text for the 'Next' button
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next_button;

  /// Text for the 'Send' button
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send_button;

  /// Text for the 'Get Started' button
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get get_started_button;

  /// Text for the 'Login' button
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get login_button;

  /// Text for the 'Sign Up' button
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get sign_up_button;

  /// Text for registration option
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get auth_register;

  /// Text for login option
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get auth_login;

  /// Welcome back message
  ///
  /// In en, this message translates to:
  /// **'Welcome back!'**
  String get welcome_back_text;

  /// Simple welcome greeting
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome_text;

  /// Start shopping welcome text
  ///
  /// In en, this message translates to:
  /// **'Start shopping now'**
  String get welcome_start_text;

  /// Label for email field
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email_text;

  /// Label for password field
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password_text;

  /// Label for confirm password field
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirm_password_text;

  /// Text for forgot password link
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get forgot_password_text;

  /// Text for skip button
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip_text;

  /// Text for alternative login options
  ///
  /// In en, this message translates to:
  /// **'Or sign in with'**
  String get or_sign_in_with_text;

  /// Label for first name field
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get first_name_text;

  /// Label for last name field
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get last_name_text;

  /// Label for phone number field
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone_number_text;

  /// Error message for invalid email
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email.'**
  String get email_validation_error;

  /// Error message for short password
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters.'**
  String get password_validation_error;

  /// Error message for password mismatch
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get confirm_password_validation_error;

  /// Error message for empty first name
  ///
  /// In en, this message translates to:
  /// **'Please enter your first name.'**
  String get first_name_validation_error;

  /// Error message for empty last name
  ///
  /// In en, this message translates to:
  /// **'Please enter your last name.'**
  String get last_name_validation_error;

  /// Error message for invalid phone number
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number.'**
  String get phone_number_validation_error;

  /// Text for country selection
  ///
  /// In en, this message translates to:
  /// **'Select Country'**
  String get select_country_text;

  /// Search hint for country
  ///
  /// In en, this message translates to:
  /// **'Search for a country'**
  String get search_country_text;

  /// Text for reset password
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get reset_password_text;

  /// Login to account title
  ///
  /// In en, this message translates to:
  /// **'Log In to your account'**
  String get login_your_account;

  /// Account menu text
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account_text;

  /// Personal info text
  ///
  /// In en, this message translates to:
  /// **'Personal information'**
  String get personal_information_text;

  /// Edit personal info text
  ///
  /// In en, this message translates to:
  /// **'Edit personal information'**
  String get change_personal_information_text;

  /// Favorites menu text
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorite_text;

  /// Favorite products list title
  ///
  /// In en, this message translates to:
  /// **'Your Favorite Products'**
  String get favorite_products_text;

  /// Orders menu text
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders_text;

  /// Order history title
  ///
  /// In en, this message translates to:
  /// **'Order History'**
  String get order_history_text;

  /// Settings menu text
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_text;

  /// Notifications menu text
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications_text;

  /// Notification settings title
  ///
  /// In en, this message translates to:
  /// **'Notification Settings'**
  String get notification_settings_text;

  /// Language menu text
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language_text;

  /// Change language title
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get change_language_text;

  /// Dark mode toggle text
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get mode_text;

  /// Appearance settings text
  ///
  /// In en, this message translates to:
  /// **'Enable Dark Mode'**
  String get enable_dark_mode_text;

  /// Call us text
  ///
  /// In en, this message translates to:
  /// **'Call Us'**
  String get call_us_text;

  /// Contact us text
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contact_us_text;

  /// Arabic language name
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic_text;

  /// English language name
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english_text;

  /// Light theme name
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light_mode_text;

  /// Dark theme name
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark_mode_text;

  /// System theme name
  ///
  /// In en, this message translates to:
  /// **'System Mode'**
  String get system_mode_text;

  /// Edit profile title
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get edit_profile_text;

  /// Change email text
  ///
  /// In en, this message translates to:
  /// **'Change Email'**
  String get change_account_mill_text;

  /// Email account label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get mail_account_text;

  /// Change email process text
  ///
  /// In en, this message translates to:
  /// **'Change the email'**
  String get chang_mail_account_one_text;

  /// Change phone text
  ///
  /// In en, this message translates to:
  /// **'Change Phone'**
  String get change_phone_number_text;

  /// Edit phone title
  ///
  /// In en, this message translates to:
  /// **'Edit Phone'**
  String get edit_phone_text;

  /// Detailed change phone text
  ///
  /// In en, this message translates to:
  /// **'Change your personal phone'**
  String get change_phone_persnol_text;

  /// Change password text
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get change_password_text;

  /// Edit password title
  ///
  /// In en, this message translates to:
  /// **'Edit Password'**
  String get edit_password_text;

  /// Change password instruction
  ///
  /// In en, this message translates to:
  /// **'Change your password'**
  String get change_your_password_text;

  /// Label for current password
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get password_old_text;

  /// Label for new password
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get password_new_text;

  /// Label for confirm new password
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get password_confirm_text;

  /// Save button text
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save_text;

  /// OTP verification title
  ///
  /// In en, this message translates to:
  /// **'OTP Verification'**
  String get otp_verification;

  /// OTP entry instruction
  ///
  /// In en, this message translates to:
  /// **'Enter the code sent to your phone'**
  String get enter_otp;

  /// Verify button text
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// Resend code button text
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get resend_code;

  /// Info text for where OTP was sent
  ///
  /// In en, this message translates to:
  /// **'Code sent to'**
  String get otp_sent_to;

  /// Success message for OTP sent
  ///
  /// In en, this message translates to:
  /// **'Code sent successfully'**
  String get code_sent_successfully;

  /// Text for resend timer
  ///
  /// In en, this message translates to:
  /// **'Resend after'**
  String get resend_after;

  /// Shopping type choice title
  ///
  /// In en, this message translates to:
  /// **'Choose your type of shopping'**
  String get choose_your_type_of_shopping;

  /// Shopping type choice question
  ///
  /// In en, this message translates to:
  /// **'Do you want to buy wholesale or retail?'**
  String get do_you_want_to_buy_wholesale_or_retail;

  /// Confirmation dialog title for changing purchase type
  ///
  /// In en, this message translates to:
  /// **'Change Purchase Type'**
  String get change_purchase_type_confirmation_title;

  /// Confirmation dialog message for changing purchase type
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to change the shopping type? This will refresh all data.'**
  String get change_purchase_type_confirmation_message;

  /// Wholesale option text
  ///
  /// In en, this message translates to:
  /// **'Wholesale'**
  String get wholesale_text;

  /// Retail option text
  ///
  /// In en, this message translates to:
  /// **'Retail'**
  String get retail_text;

  /// Continue button text
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continue_text;

  /// Title for user selection
  ///
  /// In en, this message translates to:
  /// **'Choose the user'**
  String get choose_user;

  /// Recently arrived products header
  ///
  /// In en, this message translates to:
  /// **'Recently Arrived'**
  String get recently_arrived_text;

  /// Browse categories header
  ///
  /// In en, this message translates to:
  /// **'Browse Categories'**
  String get browse_categories_text;

  /// Search field hint with context
  ///
  /// In en, this message translates to:
  /// **'Search in {value}'**
  String search_text(Object value);

  /// Discount label
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount_text;

  /// Currency name (English variant may use EGP)
  ///
  /// In en, this message translates to:
  /// **'Pound'**
  String get pound_text;

  /// Sections title
  ///
  /// In en, this message translates to:
  /// **'Sections'**
  String get sections_text;

  /// Most popular sorting/header
  ///
  /// In en, this message translates to:
  /// **'Most popular'**
  String get most_popular_text;

  /// Sort alphabetically ascending
  ///
  /// In en, this message translates to:
  /// **'A - Z'**
  String get a_to_z_text;

  /// Sort alphabetically descending
  ///
  /// In en, this message translates to:
  /// **'Z - A'**
  String get z_to_a_text;

  /// Sort price low to high
  ///
  /// In en, this message translates to:
  /// **'Low to High'**
  String get low_to_high_text;

  /// Sort price high to low
  ///
  /// In en, this message translates to:
  /// **'High to Low'**
  String get high_to_low_text;

  /// Sort by newest
  ///
  /// In en, this message translates to:
  /// **'Latest'**
  String get latest_text;

  /// Featured discounts section title
  ///
  /// In en, this message translates to:
  /// **'Featured discounts'**
  String get featured_discounts_text;

  /// Filter button/action
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter_text;

  /// Sort by label
  ///
  /// In en, this message translates to:
  /// **'Sort By'**
  String get sort_by_text;

  /// Apply button text
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply_text;

  /// Privacy policy menu text
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy_text;

  /// Full Privacy Policy text
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy_policy_text;

  /// Logout button text
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout_text;

  /// Shopping cart title
  ///
  /// In en, this message translates to:
  /// **'Shopping cart'**
  String get shopping_cart_text;

  /// Order value summary label
  ///
  /// In en, this message translates to:
  /// **'Order Value'**
  String get order_value_text;

  /// Plural form of products
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get products_plural_text;

  /// Egyptian Pound abbreviation
  ///
  /// In en, this message translates to:
  /// **'EGP'**
  String get egp_text;

  /// Currency abbreviation
  ///
  /// In en, this message translates to:
  /// **'EGP'**
  String get currency_text;

  /// Notice about delivery charges
  ///
  /// In en, this message translates to:
  /// **'Delivery charges will be calculated at checkout'**
  String get delivery_charges_notice_text;

  /// Continue shopping button text
  ///
  /// In en, this message translates to:
  /// **'Continue Shopping'**
  String get continue_shopping_text;

  /// Checkout button/title
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout_text;

  /// Payment method selection title
  ///
  /// In en, this message translates to:
  /// **'Pay with'**
  String get pay_with_text;

  /// Cash on delivery option
  ///
  /// In en, this message translates to:
  /// **'Cash on delivery'**
  String get cash_on_delivery_text;

  /// Pay button text
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get pay_text;

  /// Error message when payment method is not chosen
  ///
  /// In en, this message translates to:
  /// **'Choose a payment method first'**
  String get choose_payment_method_first_text;

  /// Delivery info section title
  ///
  /// In en, this message translates to:
  /// **'Delivery information'**
  String get delivery_information_text;

  /// Label for full name field
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get full_name_text;

  /// Hint for full name field
  ///
  /// In en, this message translates to:
  /// **'Enter full name'**
  String get enter_full_name_text;

  /// Label for address field
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address_text;

  /// Hint for address field
  ///
  /// In en, this message translates to:
  /// **'Enter address'**
  String get enter_address_text;

  /// Label for simple phone field
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone_text;

  /// Prices summary header
  ///
  /// In en, this message translates to:
  /// **'Prices'**
  String get prices_text;

  /// Subtotal before shipping
  ///
  /// In en, this message translates to:
  /// **'Price before shipping'**
  String get price_before_shipping_text;

  /// Label for shipping fee
  ///
  /// In en, this message translates to:
  /// **'Shipping fee'**
  String get shipping_fee_text;

  /// Label for total price
  ///
  /// In en, this message translates to:
  /// **'Total price'**
  String get total_price_text;

  /// Confirm order button text
  ///
  /// In en, this message translates to:
  /// **'Confirm order'**
  String get confirm_order_button_text;

  /// Confirm order dialog title
  ///
  /// In en, this message translates to:
  /// **'Confirm order'**
  String get confirm_order_title_text;

  /// Confirm order dialog message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to confirm the order?'**
  String get confirm_order_message_text;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel_text;

  /// Confirm button text
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm_text;

  /// Label for card holder name field
  ///
  /// In en, this message translates to:
  /// **'Card holder name'**
  String get card_holder_name_text;

  /// Label for card number field
  ///
  /// In en, this message translates to:
  /// **'Card number'**
  String get card_number_text;

  /// Label for card expiry date field
  ///
  /// In en, this message translates to:
  /// **'Expiry date'**
  String get expiry_date_text;

  /// Success message after payment
  ///
  /// In en, this message translates to:
  /// **'Payment successful'**
  String get payment_success_message_text;

  /// Pay now button text
  ///
  /// In en, this message translates to:
  /// **'Pay now'**
  String get pay_now_button_text;

  /// Logout confirmation dialog title
  ///
  /// In en, this message translates to:
  /// **'Logout confirmation'**
  String get logout_confirmation_text;

  /// Logout confirmation dialog message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logout_confirmation_message_shure_text;

  /// Offers and discounts title
  ///
  /// In en, this message translates to:
  /// **'Discounts & Offers'**
  String get offers_discount_text;

  /// All products header
  ///
  /// In en, this message translates to:
  /// **'All Products'**
  String get all_products_text;

  /// Change button text
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get chang_text;

  /// Change name dialog title
  ///
  /// In en, this message translates to:
  /// **'Change Name'**
  String get change_name_text;

  /// Success message for name change
  ///
  /// In en, this message translates to:
  /// **'Name updated successfully'**
  String get name_updated_successfully_text;

  /// Required field suffix/text
  ///
  /// In en, this message translates to:
  /// **' required'**
  String get required_text;

  /// Info message if data was not updated
  ///
  /// In en, this message translates to:
  /// **'Data was not updated'**
  String get data_not_updated_text;

  /// Standard error for required field
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get required_field_text;

  /// Empty state message for section
  ///
  /// In en, this message translates to:
  /// **'There are no products in this section at the moment'**
  String get no_products_in_section_text;

  /// Suggestion for empty state
  ///
  /// In en, this message translates to:
  /// **'Browse other sections to find what you need'**
  String get browse_other_sections_text;

  /// Empty cart title
  ///
  /// In en, this message translates to:
  /// **'Your shopping cart is empty'**
  String get empty_cart_text;

  /// Start shopping CTA
  ///
  /// In en, this message translates to:
  /// **'Start adding products to your cart'**
  String get start_adding_products_text;

  /// General 'no products' message
  ///
  /// In en, this message translates to:
  /// **'No products available'**
  String get no_products_text;

  /// Empty favorites title
  ///
  /// In en, this message translates to:
  /// **'No products in favorites'**
  String get no_favorite_products_text;

  /// Empty favorites description
  ///
  /// In en, this message translates to:
  /// **'The products you add to your favorites will appear here'**
  String get products_favorites_empty_text;

  /// General error message
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get error_occurred_text;

  /// Error message for failed product load
  ///
  /// In en, this message translates to:
  /// **'Failed to load product'**
  String get product_load_failed_text;

  /// Back button text
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back_text;

  /// Label for product brand
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get brand_text;

  /// Label for product description section
  ///
  /// In en, this message translates to:
  /// **'Product Description'**
  String get product_description_text;

  /// Label for product properties section
  ///
  /// In en, this message translates to:
  /// **'Product Properties'**
  String get product_properties_text;

  /// Generic 'no data' message
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get no_data_text;

  /// Label for quantity
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity_text;

  /// Confirmation that product is in cart
  ///
  /// In en, this message translates to:
  /// **'Product added'**
  String get product_added_text;

  /// Add to cart button text
  ///
  /// In en, this message translates to:
  /// **'Add to cart'**
  String get add_to_cart_text;

  /// Login alert dialog title
  ///
  /// In en, this message translates to:
  /// **'Alert'**
  String get login_alert_title;

  /// Login alert dialog message
  ///
  /// In en, this message translates to:
  /// **'Please log in first to continue'**
  String get login_alert_message;

  /// Success message for favorite removal
  ///
  /// In en, this message translates to:
  /// **'Product removed from favorites'**
  String get product_removed_from_favorites_text;

  /// Success message for favorite addition
  ///
  /// In en, this message translates to:
  /// **'Product added to favorites'**
  String get product_added_to_favorites_text;

  /// Success message for cart addition
  ///
  /// In en, this message translates to:
  /// **'Product added to cart'**
  String get product_added_to_cart_text;

  /// Success message for cart removal
  ///
  /// In en, this message translates to:
  /// **'Product removed from cart'**
  String get product_removed_from_cart_text;

  /// Delete confirmation dialog title
  ///
  /// In en, this message translates to:
  /// **'Delete Confirmation'**
  String get delete_confirmation_title;

  /// Delete button text
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete_text;

  /// From cart label
  ///
  /// In en, this message translates to:
  /// **'from cart'**
  String get from_cart_text;

  /// Delete confirmation message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete?'**
  String get delete_confirmation_message_text;

  /// Generic 'removed' message
  ///
  /// In en, this message translates to:
  /// **'Removed'**
  String get removed_text;

  /// Generic mandatory entry prompt
  ///
  /// In en, this message translates to:
  /// **'Please enter'**
  String get enter_text_prompt;

  /// Error message for CVV field
  ///
  /// In en, this message translates to:
  /// **'Must be 3 digits only'**
  String get three_digits_only_text;

  /// Confirmed selection text
  ///
  /// In en, this message translates to:
  /// **'Selected:'**
  String get selected_text;

  /// Success message for phone change
  ///
  /// In en, this message translates to:
  /// **'Phone number changed successfully'**
  String get phone_number_changed_success_text;

  /// Success message for password change
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully'**
  String get password_changed_success_text;

  /// Error for incorrect current password
  ///
  /// In en, this message translates to:
  /// **'Current password is incorrect'**
  String get current_password_incorrect_text;

  /// Validation error for password length
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get password_min_8_chars_text;

  /// Validation error for password mismatch
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwords_do_not_match_text;

  /// Label for product colors
  ///
  /// In en, this message translates to:
  /// **'Colors'**
  String get product_colors_text;

  /// Label for order number
  ///
  /// In en, this message translates to:
  /// **'Order Number'**
  String get order_number_text;

  /// Label for order date
  ///
  /// In en, this message translates to:
  /// **'Order Date'**
  String get order_date_text;

  /// Status: Delivered
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get delivered_text;

  /// Status: Pending
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending_text;

  /// Status: Shipped
  ///
  /// In en, this message translates to:
  /// **'Shipped'**
  String get shipped_text;

  /// Status: Canceled
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get canceled_text;

  /// Order details page title
  ///
  /// In en, this message translates to:
  /// **'Order Details'**
  String get order_details_text;

  /// Order info section header
  ///
  /// In en, this message translates to:
  /// **'Order Info'**
  String get order_info_text;

  /// Label for unit price
  ///
  /// In en, this message translates to:
  /// **'Unit Price'**
  String get unit_price_text;

  /// Label for shipping address
  ///
  /// In en, this message translates to:
  /// **'Shipping Address'**
  String get shipping_address_text;

  /// Label for recipient name
  ///
  /// In en, this message translates to:
  /// **'Recipient Name'**
  String get recipient_name_text;

  /// Label for price summary
  ///
  /// In en, this message translates to:
  /// **'Price Summary'**
  String get price_summary_text;

  /// Label for subtotal
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal_text;

  /// Label for shipping
  ///
  /// In en, this message translates to:
  /// **'Shipping'**
  String get shipping_text;

  /// Label for total
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total_text;

  /// Close button text
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close_text;

  /// Product reviews section title
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get product_reviews_text;

  /// Tab label for 'All'
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all_tab_text;

  /// Tab label for 'Offers'
  ///
  /// In en, this message translates to:
  /// **'Offers'**
  String get offers_tab_text;

  /// Tab label for 'Alerts'
  ///
  /// In en, this message translates to:
  /// **'Alerts'**
  String get alerts_tab_text;

  /// Today section header
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today_section_text;

  /// Earlier section header
  ///
  /// In en, this message translates to:
  /// **'Earlier'**
  String get earlier_section_text;

  /// Message for no notifications
  ///
  /// In en, this message translates to:
  /// **'No notifications right now'**
  String get no_notifications_message_text;

  /// Message when all notifications are seen
  ///
  /// In en, this message translates to:
  /// **'You\'re all caught up'**
  String get all_caught_up_message_text;

  /// Double back to exit message
  ///
  /// In en, this message translates to:
  /// **'Press again to exit the application'**
  String get press_again_to_exit_text;

  /// Hint/Prompt for entering CVV
  ///
  /// In en, this message translates to:
  /// **'Please enter CVV'**
  String get enter_cvv_text;

  /// User reviews header
  ///
  /// In en, this message translates to:
  /// **'User Reviews'**
  String get user_reviews_text;

  /// View all reviews button
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get view_all_text;

  /// Reviews section title
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews_title_text;

  /// Success message for submitting review
  ///
  /// In en, this message translates to:
  /// **'Review added successfully'**
  String get review_added_text;

  /// Empty state for product reviews
  ///
  /// In en, this message translates to:
  /// **'No reviews yet'**
  String get no_reviews_yet_text;

  /// CTA for adding a review
  ///
  /// In en, this message translates to:
  /// **'Add your review'**
  String get add_your_review_text;

  /// Hint for review comment field
  ///
  /// In en, this message translates to:
  /// **'Write your comment here...'**
  String get write_comment_hint_text;

  /// Error message when rating is not selected
  ///
  /// In en, this message translates to:
  /// **'Please select a rating'**
  String get please_select_rating_text;

  /// Generic 'sending' indicator
  ///
  /// In en, this message translates to:
  /// **'Sending...'**
  String get sending_text;

  /// Submit review button text
  ///
  /// In en, this message translates to:
  /// **'Submit Review'**
  String get submit_review_text;

  /// Addresses section/title
  ///
  /// In en, this message translates to:
  /// **'Addresses'**
  String get addresses_text;

  /// Edit address button/title
  ///
  /// In en, this message translates to:
  /// **'Edit Address'**
  String get edit_address_text;

  /// User addresses list header
  ///
  /// In en, this message translates to:
  /// **'Your Addresses'**
  String get your_addresses_text;

  /// Empty state for addresses list
  ///
  /// In en, this message translates to:
  /// **'No addresses yet'**
  String get no_addresses_yet_text;

  /// General login failure message
  ///
  /// In en, this message translates to:
  /// **'Login Failed'**
  String get login_failed_text;

  /// General success indicator
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success_text;

  /// General error indicator
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error_text;

  /// Error message during data loading
  ///
  /// In en, this message translates to:
  /// **'An error occurred while loading data'**
  String get error_while_loading_text;

  /// Warning/Info text for temporary address choice
  ///
  /// In en, this message translates to:
  /// **'Temporary address for this order only'**
  String get temporary_address_text;

  /// Title for no internet screen
  ///
  /// In en, this message translates to:
  /// **'No Internet Connection'**
  String get no_internet_title;

  /// Description for no internet screen
  ///
  /// In en, this message translates to:
  /// **'Please check your internet connection and try again.'**
  String get no_internet_description;

  /// Text for try again button
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get try_again_text;

  /// Title for language restart confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Restart Required'**
  String get language_restart_title;

  /// Message for language restart confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'The app will restart to apply the language change.'**
  String get language_restart_message;

  /// Title for adding new address
  ///
  /// In en, this message translates to:
  /// **'Add New Address'**
  String get add_new_address_text;

  /// Title for editing address
  ///
  /// In en, this message translates to:
  /// **'Edit Address'**
  String get edit_address_title_text;

  /// Label for address name field
  ///
  /// In en, this message translates to:
  /// **'Address Name'**
  String get address_name_text;

  /// Add button text
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add_text;

  /// Edit button text
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit_text;

  /// Title for delete address dialog
  ///
  /// In en, this message translates to:
  /// **'Delete Address'**
  String get delete_address_title_text;

  /// Confirmation message for deleting address
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{name}\"?'**
  String delete_address_confirmation_text(Object name);

  /// Message when no orders are available
  ///
  /// In en, this message translates to:
  /// **'No orders found'**
  String get no_orders_found_text;

  /// Label for order type
  ///
  /// In en, this message translates to:
  /// **'Order Type'**
  String get order_type_label_text;

  /// Validation error for empty full name
  ///
  /// In en, this message translates to:
  /// **'Please enter full name'**
  String get enter_full_name_validation_text;

  /// Validation error for short name
  ///
  /// In en, this message translates to:
  /// **'Name is too short'**
  String get name_too_short_text;

  /// Validation error for empty phone
  ///
  /// In en, this message translates to:
  /// **'Please enter phone number'**
  String get enter_phone_validation_text;

  /// Validation error for invalid phone format
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get invalid_phone_text;

  /// Validation error for address selection
  ///
  /// In en, this message translates to:
  /// **'Please select or enter address'**
  String get select_or_enter_address_text;

  /// Success message after order confirmation
  ///
  /// In en, this message translates to:
  /// **'Order confirmed successfully'**
  String get order_confirmed_successfully_text;

  /// Label for price per piece in cart
  ///
  /// In en, this message translates to:
  /// **'Piece Price'**
  String get piece_price_text;

  /// Empty orders title
  ///
  /// In en, this message translates to:
  /// **'No orders yet'**
  String get no_orders_text;

  /// Empty orders description
  ///
  /// In en, this message translates to:
  /// **'Your order history will appear here once you make a purchase'**
  String get orders_empty_desc_text;

  /// Title for empty category items state
  ///
  /// In en, this message translates to:
  /// **'No Items Found'**
  String get empty_category_items_title;

  /// Message for empty category items state
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t find any items in this category.'**
  String get empty_category_items_message;

  /// No description provided for @loading_text.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading_text;

  /// No description provided for @no_products_found_text.
  ///
  /// In en, this message translates to:
  /// **'No products found'**
  String get no_products_found_text;

  /// No description provided for @select_governorate_text.
  ///
  /// In en, this message translates to:
  /// **'Select Governorate'**
  String get select_governorate_text;

  /// No description provided for @governorate_text.
  ///
  /// In en, this message translates to:
  /// **'Governorate'**
  String get governorate_text;

  /// No description provided for @city_text.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city_text;

  /// No description provided for @street_text.
  ///
  /// In en, this message translates to:
  /// **'Street'**
  String get street_text;

  /// No description provided for @all_brands_text.
  ///
  /// In en, this message translates to:
  /// **'All Brands'**
  String get all_brands_text;

  /// No description provided for @no_results_found_text.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get no_results_found_text;

  /// No description provided for @try_searching_different_keywords_text.
  ///
  /// In en, this message translates to:
  /// **'Try searching with different keywords.'**
  String get try_searching_different_keywords_text;

  /// No description provided for @search_failed_text.
  ///
  /// In en, this message translates to:
  /// **'Search failed'**
  String get search_failed_text;

  /// No description provided for @search_products_title_text.
  ///
  /// In en, this message translates to:
  /// **'Search Products'**
  String get search_products_title_text;

  /// No description provided for @search_products_desc_text.
  ///
  /// In en, this message translates to:
  /// **'Search by product name, category or brand.'**
  String get search_products_desc_text;

  /// No description provided for @item_not_in_cart.
  ///
  /// In en, this message translates to:
  /// **'This product is not currently in cart'**
  String get item_not_in_cart;

  /// No description provided for @item_not_in_favorites.
  ///
  /// In en, this message translates to:
  /// **'This product is not currently in favorites'**
  String get item_not_in_favorites;

  /// No description provided for @item_not_in_cart_or_favorites.
  ///
  /// In en, this message translates to:
  /// **'This product is not currently in cart or favorites'**
  String get item_not_in_cart_or_favorites;

  /// No description provided for @offer_no_longer_available.
  ///
  /// In en, this message translates to:
  /// **'Sorry, this offer is no longer available'**
  String get offer_no_longer_available;

  /// No description provided for @cannot_display_order_details.
  ///
  /// In en, this message translates to:
  /// **'Sorry, order details cannot be displayed'**
  String get cannot_display_order_details;

  /// No description provided for @content_not_available.
  ///
  /// In en, this message translates to:
  /// **'Sorry, this content is currently unavailable'**
  String get content_not_available;

  /// No description provided for @check_it_out_on_mousa_store.
  ///
  /// In en, this message translates to:
  /// **'👇 Check it out on Mousa Store:'**
  String get check_it_out_on_mousa_store;

  /// No description provided for @check_out_product_on_mousa_store.
  ///
  /// In en, this message translates to:
  /// **'Check out {productName} on Mousa Store!'**
  String check_out_product_on_mousa_store(String productName);

  /// No description provided for @privacy_policy_intro.
  ///
  /// In en, this message translates to:
  /// **'Your privacy is paramount to us at Mousa Store. This Privacy Policy outlines the types of personal information we collect and how we use and protect it.'**
  String get privacy_policy_intro;

  /// No description provided for @privacy_policy_sec1_title.
  ///
  /// In en, this message translates to:
  /// **'1. Information We Collect'**
  String get privacy_policy_sec1_title;

  /// No description provided for @privacy_policy_sec1_desc.
  ///
  /// In en, this message translates to:
  /// **'When using our app, we may collect the following information:\n• Personal info: Name, email address, phone number, and shipping address.\n• Order info: Details of products purchased and transaction history.\n• Device info: Device type, OS, and unique device identifiers.'**
  String get privacy_policy_sec1_desc;

  /// No description provided for @privacy_policy_sec2_title.
  ///
  /// In en, this message translates to:
  /// **'2. How We Use Your Information'**
  String get privacy_policy_sec2_title;

  /// No description provided for @privacy_policy_sec2_desc.
  ///
  /// In en, this message translates to:
  /// **'We use collected information for the following purposes:\n• Processing and delivering your orders.\n• Improving our services and user experience.\n• Communicating regarding orders, offers, and updates.\n• Security and fraud prevention.'**
  String get privacy_policy_sec2_desc;

  /// No description provided for @privacy_policy_sec3_title.
  ///
  /// In en, this message translates to:
  /// **'3. Sharing Information'**
  String get privacy_policy_sec3_title;

  /// No description provided for @privacy_policy_sec3_desc.
  ///
  /// In en, this message translates to:
  /// **'We do not sell your personal information to third parties. We only share it with delivery services to fulfill orders, payment providers, or when required by law.'**
  String get privacy_policy_sec3_desc;

  /// No description provided for @privacy_policy_sec4_title.
  ///
  /// In en, this message translates to:
  /// **'4. Data Protection'**
  String get privacy_policy_sec4_title;

  /// No description provided for @privacy_policy_sec4_desc.
  ///
  /// In en, this message translates to:
  /// **'We take appropriate technical and administrative security measures to protect your information from unauthorized access, alteration, disclosure, or destruction.'**
  String get privacy_policy_sec4_desc;

  /// No description provided for @privacy_policy_sec5_title.
  ///
  /// In en, this message translates to:
  /// **'5. Your Rights'**
  String get privacy_policy_sec5_title;

  /// No description provided for @privacy_policy_sec5_desc.
  ///
  /// In en, this message translates to:
  /// **'You have the right to access, update, or request deletion of your personal data through account settings or by contacting us.'**
  String get privacy_policy_sec5_desc;

  /// No description provided for @privacy_policy_copyright.
  ///
  /// In en, this message translates to:
  /// **'© 2026 Mousa Store'**
  String get privacy_policy_copyright;

  /// No description provided for @app_name.
  ///
  /// In en, this message translates to:
  /// **'Mousa Store'**
  String get app_name;

  /// No description provided for @home_tab.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home_tab;

  /// No description provided for @categories_tab.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories_tab;

  /// No description provided for @cart_tab.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart_tab;

  /// No description provided for @favorites_tab.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get favorites_tab;

  /// No description provided for @profile_tab.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile_tab;

  /// No description provided for @explore_text.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get explore_text;

  /// No description provided for @explore_products_text.
  ///
  /// In en, this message translates to:
  /// **'Explore Products'**
  String get explore_products_text;

  /// No description provided for @something_went_wrong_text.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get something_went_wrong_text;

  /// No description provided for @could_not_load_content_text.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t load this content. Please try again.'**
  String get could_not_load_content_text;

  /// Title for shop by category section
  ///
  /// In en, this message translates to:
  /// **'Shop By Category'**
  String get shop_by_category_text;

  /// Image asset path for services banner
  ///
  /// In en, this message translates to:
  /// **'assets/images/services_banner_en.jpg'**
  String get services_banner_image;

  /// Image asset path for services banner in dark mode
  ///
  /// In en, this message translates to:
  /// **'assets/images/services_banner_en.jpg'**
  String get services_banner_image_dark;

  /// Image asset path for services banner in light mode
  ///
  /// In en, this message translates to:
  /// **'assets/images/services_banner_light_en.jpg'**
  String get services_banner_image_light;

  /// Description prompt asking user to log in to view favorites
  ///
  /// In en, this message translates to:
  /// **'Favorites list is only available after log in. Please log in to save and access your favorite products.'**
  String get favorites_login_prompt_text;

  /// Description prompt asking user to log in to view cart
  ///
  /// In en, this message translates to:
  /// **'Shopping cart is only available after log in. Please log in to add products and complete your purchase.'**
  String get cart_login_prompt_text;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
