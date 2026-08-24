import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mousa_store/core/service/auth_service.dart';
import 'package:mousa_store/features/auth/repo/login_repo.dart';
import 'package:mousa_store/features/auth/repo/otp_repo.dart';
import 'package:mousa_store/features/auth/repo/reset_password_repo.dart';
import 'package:mousa_store/features/auth/repo/signup_repo.dart';
import 'package:mousa_store/features/auth/service/login_service.dart';
import 'package:mousa_store/features/auth/service/otp_service.dart';
import 'package:mousa_store/features/auth/service/reset_password_service.dart';
import 'package:mousa_store/features/auth/service/signup_service.dart';
import 'package:mousa_store/features/auth/view_model/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:mousa_store/features/auth/view_model/login_cubit/login_cubit.dart';
import 'package:mousa_store/features/auth/view_model/otp_cubit/otp_cubit.dart';
import 'package:mousa_store/features/auth/view_model/otp_cubit/otp_state.dart';
import 'package:mousa_store/features/auth/view_model/reset_password_cubit/reset_password_cubit.dart';
import 'package:mousa_store/features/auth/view_model/signup_cubit/signup_cubit.dart';
import 'package:mousa_store/features/brands/repositories/brand_repo.dart';
import 'package:mousa_store/features/brands/services/brand_service.dart';
import 'package:mousa_store/features/brands/viewmodels/brand_cubit.dart';
import 'package:mousa_store/features/cart/repositories/cart_repo.dart';
import 'package:mousa_store/features/cart/repositories/checkout_repo.dart';
import 'package:mousa_store/features/cart/services/cart_service.dart' as feat_cart;
import 'package:mousa_store/features/cart/services/checkout_service.dart';
import 'package:mousa_store/features/cart/viewmodels/cart_cubit.dart';
import 'package:mousa_store/features/cart/viewmodels/checkout_cubit.dart';
import 'package:mousa_store/features/categories/repositories/category_repo.dart';
import 'package:mousa_store/features/categories/services/category_service.dart';
import 'package:mousa_store/features/categories/viewmodels/category_cubit.dart';
import 'package:mousa_store/features/category_items/repositories/category_items_repo.dart';
import 'package:mousa_store/features/category_items/services/category_items_service.dart';
import 'package:mousa_store/features/category_items/viewmodels/category_items_cubit.dart';
import 'package:mousa_store/features/favorites/repositories/favorite_repo.dart';
import 'package:mousa_store/features/favorites/services/favorite_service.dart';
import 'package:mousa_store/features/favorites/viewmodels/favorite_cubit.dart';
import 'package:mousa_store/features/home/repositories/home_repository.dart';
import 'package:mousa_store/features/home/services/home_service.dart';
import 'package:mousa_store/features/home/viewmodels/home_cubit.dart';
import 'package:mousa_store/features/notification/repo/notification_repo.dart';
import 'package:mousa_store/features/notification/service/notification_service.dart';
import 'package:mousa_store/features/notification/view_model/notification_cubit.dart';
import 'package:mousa_store/features/orders/repos/orders_repo.dart';
import 'package:mousa_store/features/orders/services/orders_service.dart';
import 'package:mousa_store/features/orders/view_model/order_details_cubit/order_details_cubit.dart';
import 'package:mousa_store/features/orders/view_model/orders_cubit/orders_cubit.dart';
import 'package:mousa_store/features/product/repo/product_repo.dart';
import 'package:mousa_store/features/product/repo/review_repo.dart';
import 'package:mousa_store/features/product/service/product_service.dart';
import 'package:mousa_store/features/product/service/review_service.dart';
import 'package:mousa_store/features/product/view_model/product_cubit/product_cubit.dart';
import 'package:mousa_store/features/product/view_model/reviews_cubit/review_cubit.dart';
import 'package:mousa_store/features/profile/cubit/contact_cubit.dart';
import 'package:mousa_store/features/profile/repo/contact_repo.dart';
import 'package:mousa_store/features/search/repo/search_repo.dart';
import 'package:mousa_store/features/search/service/search_service.dart';
import 'package:mousa_store/features/search/view_model/search_cubit.dart';
import 'package:mousa_store/features/setting_profile/view_model/language_cubit/language_cubit.dart';
import 'package:mousa_store/features/setting_profile/view_model/theme_cubit/theme_cubit.dart';
import 'package:mousa_store/features/wholesale_or_retail/view_model/price_mode_cubit.dart';

/// Global service locator instance
final getIt = GetIt.instance;

/// Setup and register all services with the service locator
Future<void> setupDi({ThemeMode initialThemeMode = ThemeMode.system}) async {
  // Register Services
  getIt
    ..registerLazySingleton<Connectivity>(Connectivity.new)
    ..registerLazySingleton<AuthService>(AuthService.new)
    ..registerLazySingleton<LoginService>(LoginService.new)
    ..registerLazySingleton<SignupService>(SignupService.new)
    ..registerLazySingleton<OtpService>(OtpService.new)
    ..registerLazySingleton<ResetPasswordService>(ResetPasswordService.new)
    ..registerLazySingleton<feat_cart.CartService>(
      feat_cart.CartService.new,
    ) // Moved CartService registration here
    ..registerLazySingleton<BrandService>(BrandService.new)
    ..registerLazySingleton<CategoryService>(CategoryService.new)
    ..registerLazySingleton<CategoryItemsService>(CategoryItemsService.new)
    ..registerLazySingleton<ProductService>(ProductService.new)
    ..registerLazySingleton<FavoriteService>(FavoriteService.new)
    ..registerLazySingleton<SearchService>(SearchService.new)
    ..registerLazySingleton<ReviewService>(ReviewService.new)
    ..registerLazySingleton<CheckoutService>(CheckoutService.new)
    ..registerLazySingleton<OrdersService>(OrdersService.new)
    ..registerLazySingleton<NotificationService>(NotificationService.new)
    ..registerLazySingleton<HomeService>(HomeService.new)
    // Register Repositories
    ..registerLazySingleton<LoginRepo>(() => LoginRepo(loginService: getIt()))
    ..registerLazySingleton<SignupRepo>(
      () => SignupRepo(signupService: getIt()),
    )
    ..registerLazySingleton<OtpRepo>(() => OtpRepo(otpService: getIt()))
    ..registerLazySingleton<ResetPasswordRepo>(
      () => ResetPasswordRepo(resetPasswordService: getIt()),
    )
    ..registerLazySingleton<BrandRepo>(() => BrandRepo(service: getIt()))
    ..registerLazySingleton<CategoryRepo>(() => CategoryRepo(service: getIt()))
    ..registerLazySingleton<CategoryItemsRepo>(
      () => CategoryItemsRepo(service: getIt()),
    )
    ..registerLazySingleton<ProductRepo>(() => ProductRepo(service: getIt()))
    ..registerLazySingleton<FavoriteRepo>(() => FavoriteRepo(service: getIt()))
    ..registerLazySingleton<SearchRepo>(() => SearchRepo(getIt()))
    ..registerLazySingleton<CartRepo>(() => CartRepo(service: getIt()))
    ..registerLazySingleton<ReviewRepo>(() => ReviewRepo(getIt()))
    ..registerLazySingleton<CheckoutRepo>(() => CheckoutRepo(service: getIt()))
    ..registerLazySingleton<OrdersRepo>(() => OrdersRepo(getIt()))
    ..registerLazySingleton<NotificationRepo>(() => NotificationRepo(getIt()))
    ..registerLazySingleton<HomeRepository>(
      () => HomeRepository(
        homeService: getIt(),
        categoryRepo: getIt(),
        brandRepo: getIt(),
      ),
    )
    // Register Cubits
    ..registerSingleton<ThemeCubit>(ThemeCubit(initialThemeMode))
    ..registerSingleton<PriceModeCubit>(PriceModeCubit())
    ..registerLazySingleton<LanguageCubit>(LanguageCubit.new)
    ..registerFactory<LoginCubit>(() => LoginCubit(loginRepo: getIt()))
    ..registerFactory<SignupCubit>(() => SignupCubit(repository: getIt()))
    ..registerFactoryParam<OtpCubit, OtpFlowType, void>(
      (flowType, _) => OtpCubit(otpRepo: getIt(), flowType: flowType),
    )
    ..registerFactory<ForgotPasswordCubit>(
      () => ForgotPasswordCubit(otpRepo: getIt()),
    )
    ..registerFactory<ResetPasswordCubit>(
      () => ResetPasswordCubit(resetPasswordRepo: getIt()),
    )
    ..registerFactory<BrandCubit>(() => BrandCubit(repository: getIt()))
    ..registerFactory<CategoryCubit>(() => CategoryCubit(repository: getIt()))
    // Important: Register with params. categoryId or brandId is optional.
    ..registerFactoryParam<CategoryItemsCubit, ItemFetchType, int?>(
      (fetchType, id) => CategoryItemsCubit(
        repository: getIt(),
        fetchType: fetchType,
        categoryId: fetchType == ItemFetchType.category ? id : null,
        brandId: fetchType == ItemFetchType.brand ? id : null,
      ),
    )
    ..registerFactory<ProductCubit>(() => ProductCubit(repository: getIt()))
    ..registerFactory<SearchCubit>(() => SearchCubit(getIt()))
    ..registerLazySingleton<FavoriteCubit>(() => FavoriteCubit(getIt()))
    ..registerLazySingleton<CartCubit>(() => CartCubit(getIt()))
    ..registerFactory<ReviewCubit>(() => ReviewCubit(getIt()))
    ..registerFactory<CheckoutCubit>(() => CheckoutCubit(getIt()))
    ..registerFactory<OrdersCubit>(() => OrdersCubit(getIt()))
    ..registerFactory<OrderDetailsCubit>(() => OrderDetailsCubit(getIt()))
    ..registerFactory<NotificationCubit>(() => NotificationCubit(getIt()))
    ..registerFactory<HomeCubit>(() => HomeCubit(repository: getIt()))
    // Contact Us
    ..registerLazySingleton<ContactRepo>(ContactRepo.new)
    ..registerFactory<ContactCubit>(() => ContactCubit(getIt()));
}
