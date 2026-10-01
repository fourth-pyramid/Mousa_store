import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mousa_store/core/service/auth_service.dart';
import 'package:mousa_store/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:mousa_store/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:mousa_store/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mousa_store/features/auth/domain/repositories/auth_repository.dart';
import 'package:mousa_store/features/auth/domain/usecases/forgot_password_use_case.dart';
import 'package:mousa_store/features/auth/domain/usecases/login_use_case.dart';
import 'package:mousa_store/features/auth/domain/usecases/resend_otp_use_case.dart';
import 'package:mousa_store/features/auth/domain/usecases/reset_password_use_case.dart';
import 'package:mousa_store/features/auth/domain/usecases/signup_use_case.dart';
import 'package:mousa_store/features/auth/domain/usecases/verify_otp_use_case.dart';
import 'package:mousa_store/features/auth/presentation/bloc/forgot_password_bloc.dart';
import 'package:mousa_store/features/auth/presentation/bloc/login_bloc.dart';
import 'package:mousa_store/features/auth/presentation/bloc/otp_bloc.dart';
import 'package:mousa_store/features/auth/presentation/bloc/reset_password_bloc.dart';
import 'package:mousa_store/features/auth/presentation/bloc/signup_bloc.dart';
import 'package:mousa_store/features/brands/data/datasources/brand_remote_data_source.dart';
import 'package:mousa_store/features/brands/data/repositories/brand_repository_impl.dart';
import 'package:mousa_store/features/brands/domain/repositories/brand_repository.dart';
import 'package:mousa_store/features/brands/domain/usecases/get_brands_use_case.dart';
import 'package:mousa_store/features/brands/presentation/bloc/brand_bloc.dart';
import 'package:mousa_store/features/cart/data/datasources/cart_remote_data_source.dart';
import 'package:mousa_store/features/cart/data/datasources/checkout_remote_data_source.dart';
import 'package:mousa_store/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:mousa_store/features/cart/data/repositories/checkout_repository_impl.dart';
import 'package:mousa_store/features/cart/domain/repositories/cart_repository.dart';
import 'package:mousa_store/features/cart/domain/repositories/checkout_repository.dart';
import 'package:mousa_store/features/cart/domain/usecases/cart_use_cases.dart';
import 'package:mousa_store/features/cart/domain/usecases/checkout_use_cases.dart';
import 'package:mousa_store/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:mousa_store/features/cart/presentation/bloc/checkout_bloc.dart';
import 'package:mousa_store/features/categories/data/datasources/category_remote_data_source.dart';
import 'package:mousa_store/features/categories/data/repositories/category_repository_impl.dart';
import 'package:mousa_store/features/categories/domain/repositories/category_repository.dart';
import 'package:mousa_store/features/categories/domain/usecases/get_categories_use_case.dart';
import 'package:mousa_store/features/categories/presentation/bloc/category_bloc.dart';
import 'package:mousa_store/features/category_items/data/datasources/category_items_remote_data_source.dart';
import 'package:mousa_store/features/category_items/data/repositories/category_items_repository_impl.dart';
import 'package:mousa_store/features/category_items/domain/entities/item_fetch_type.dart';
import 'package:mousa_store/features/category_items/domain/repositories/category_items_repository.dart';
import 'package:mousa_store/features/category_items/domain/usecases/get_category_items_use_case.dart';
import 'package:mousa_store/features/category_items/presentation/bloc/category_items_bloc.dart';
import 'package:mousa_store/features/favorites/data/datasources/favorite_remote_data_source.dart';
import 'package:mousa_store/features/favorites/data/repositories/favorite_repository_impl.dart';
import 'package:mousa_store/features/favorites/domain/repositories/favorite_repository.dart';
import 'package:mousa_store/features/favorites/domain/usecases/get_favorites_use_case.dart';
import 'package:mousa_store/features/favorites/domain/usecases/toggle_favorite_use_case.dart';
import 'package:mousa_store/features/favorites/presentation/bloc/favorite_bloc.dart';
import 'package:mousa_store/features/home/data/datasources/home_remote_data_source.dart';
import 'package:mousa_store/features/home/data/repositories/home_repository_impl.dart';
import 'package:mousa_store/features/home/domain/repositories/home_repository.dart';
import 'package:mousa_store/features/home/domain/usecases/fetch_home_data_use_case.dart';
import 'package:mousa_store/features/home/presentation/bloc/home_bloc.dart';
import 'package:mousa_store/features/notification/data/datasources/notification_remote_data_source.dart';
import 'package:mousa_store/features/notification/data/repositories/notification_repository_impl.dart';
import 'package:mousa_store/features/notification/domain/repositories/notification_repository.dart';
import 'package:mousa_store/features/notification/domain/usecases/get_notifications_use_case.dart';
import 'package:mousa_store/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:mousa_store/features/orders/data/datasources/orders_remote_data_source.dart';
import 'package:mousa_store/features/orders/data/repositories/orders_repository_impl.dart';
import 'package:mousa_store/features/orders/domain/repositories/orders_repository.dart';
import 'package:mousa_store/features/orders/domain/usecases/orders_use_cases.dart';
import 'package:mousa_store/features/orders/presentation/bloc/order_details_bloc.dart';
import 'package:mousa_store/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:mousa_store/features/product/data/datasources/product_remote_data_source.dart';
import 'package:mousa_store/features/product/data/repositories/product_repository_impl.dart';
import 'package:mousa_store/features/product/domain/repositories/product_repository.dart';
import 'package:mousa_store/features/product/domain/usecases/product_use_cases.dart';
import 'package:mousa_store/features/product/presentation/bloc/product_bloc.dart';
import 'package:mousa_store/features/product/presentation/bloc/review_bloc.dart';
import 'package:mousa_store/features/profile/data/datasources/contact_remote_data_source.dart';
import 'package:mousa_store/features/profile/data/repositories/contact_repository_impl.dart';
import 'package:mousa_store/features/profile/domain/repositories/contact_repository.dart';
import 'package:mousa_store/features/profile/domain/usecases/get_contact_info_use_case.dart';
import 'package:mousa_store/features/profile/presentation/bloc/contact_bloc.dart';
import 'package:mousa_store/features/search/data/datasources/search_remote_data_source.dart';
import 'package:mousa_store/features/search/data/repositories/search_repository_impl.dart';
import 'package:mousa_store/features/search/domain/repositories/search_repository.dart';
import 'package:mousa_store/features/search/domain/usecases/search_products_use_case.dart';
import 'package:mousa_store/features/search/presentation/bloc/search_bloc.dart';
import 'package:mousa_store/features/setting_profile/data/datasources/profile_remote_data_source.dart';
import 'package:mousa_store/features/setting_profile/data/repositories/setting_profile_repository_impl.dart';
import 'package:mousa_store/features/setting_profile/domain/repositories/setting_profile_repository.dart';
import 'package:mousa_store/features/setting_profile/domain/usecases/profile_use_cases.dart';
import 'package:mousa_store/features/setting_profile/presentation/bloc/language_bloc.dart';
import 'package:mousa_store/features/setting_profile/presentation/bloc/profile_bloc.dart';
import 'package:mousa_store/features/setting_profile/presentation/bloc/theme_bloc.dart';
import 'package:mousa_store/features/wholesale_or_retail/data/datasources/price_mode_local_data_source.dart';
import 'package:mousa_store/features/wholesale_or_retail/data/repositories/price_mode_repository_impl.dart';
import 'package:mousa_store/features/wholesale_or_retail/domain/repositories/price_mode_repository.dart';
import 'package:mousa_store/features/wholesale_or_retail/domain/usecases/get_price_mode_use_case.dart';
import 'package:mousa_store/features/wholesale_or_retail/domain/usecases/set_price_mode_use_case.dart';
import 'package:mousa_store/features/wholesale_or_retail/presentation/bloc/price_mode_bloc.dart';

/// Global service locator instance
final getIt = GetIt.instance;

/// Setup and register all dependencies with the central service locator
Future<void> setupServiceLocator({
  ThemeMode initialThemeMode = ThemeMode.system,
}) async {
  // 1. External & Cross-Cutting Services
  getIt
    ..registerLazySingleton<Connectivity>(Connectivity.new)
    ..registerLazySingleton<AuthService>(AuthService.new)
    // 2. Feature Services (Data Sources)
    ..registerLazySingleton<AuthRemoteDataSource>(
      AuthRemoteDataSourceImpl.new,
    )
    ..registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(authService: getIt()),
    )
    ..registerLazySingleton<CartRemoteDataSource>(
      CartRemoteDataSourceImpl.new,
    )
    ..registerLazySingleton<BrandRemoteDataSource>(
      BrandRemoteDataSourceImpl.new,
    )
    ..registerLazySingleton<CategoryRemoteDataSource>(
      CategoryRemoteDataSourceImpl.new,
    )
    ..registerLazySingleton<CategoryItemsRemoteDataSource>(
      CategoryItemsRemoteDataSourceImpl.new,
    )
    ..registerLazySingleton<ProductRemoteDataSource>(
      ProductRemoteDataSourceImpl.new,
    )
    ..registerLazySingleton<FavoriteRemoteDataSource>(
      FavoriteRemoteDataSourceImpl.new,
    )
    ..registerLazySingleton<SearchRemoteDataSource>(
      SearchRemoteDataSourceImpl.new,
    )
    ..registerLazySingleton<ReviewRemoteDataSource>(
      ReviewRemoteDataSourceImpl.new,
    )
    ..registerLazySingleton<CheckoutRemoteDataSource>(
      CheckoutRemoteDataSourceImpl.new,
    )
    ..registerLazySingleton<OrdersRemoteDataSource>(
      OrdersRemoteDataSourceImpl.new,
    )
    ..registerLazySingleton<NotificationRemoteDataSource>(
      NotificationRemoteDataSourceImpl.new,
    )
    ..registerLazySingleton<ContactRemoteDataSource>(
      ContactRemoteDataSourceImpl.new,
    )
    ..registerLazySingleton<HomeRemoteDataSource>(
      HomeRemoteDataSourceImpl.new,
    )
    ..registerLazySingleton<ProfileRemoteDataSource>(
      ProfileRemoteDataSourceImpl.new,
    )
    ..registerLazySingleton<PriceModeLocalDataSource>(
      PriceModeLocalDataSourceImpl.new,
    )
    // 3. Repositories (SSOT)
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: getIt(),
        localDataSource: getIt(),
      ),
    )
    ..registerLazySingleton<BrandRepository>(
      () => BrandRepositoryImpl(remoteDataSource: getIt()),
    )
    ..registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(remoteDataSource: getIt()),
    )
    ..registerLazySingleton<CategoryItemsRepository>(
      () => CategoryItemsRepositoryImpl(getIt()),
    )
    ..registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(getIt()),
    )
    ..registerLazySingleton<FavoriteRepository>(
      () => FavoriteRepositoryImpl(remoteDataSource: getIt()),
    )
    ..registerLazySingleton<SearchRepository>(
      () => SearchRepositoryImpl(getIt()),
    )
    ..registerLazySingleton<CartRepository>(
      () => CartRepositoryImpl(getIt()),
    )
    ..registerLazySingleton<ReviewRepository>(
      () => ReviewRepositoryImpl(getIt()),
    )
    ..registerLazySingleton<CheckoutRepository>(
      () => CheckoutRepositoryImpl(getIt()),
    )
    ..registerLazySingleton<OrdersRepository>(
      () => OrdersRepositoryImpl(getIt()),
    )
    ..registerLazySingleton<NotificationRepository>(
      () => NotificationRepositoryImpl(remoteDataSource: getIt()),
    )
    ..registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(remoteDataSource: getIt()),
    )
    ..registerLazySingleton<ContactRepository>(
      () => ContactRepositoryImpl(remoteDataSource: getIt()),
    )
    ..registerLazySingleton<SettingProfileRepository>(
      () => SettingProfileRepositoryImpl(remoteDataSource: getIt()),
    )
    ..registerLazySingleton<PriceModeRepository>(
      () => PriceModeRepositoryImpl(localDataSource: getIt()),
    )
    // 4. Domain UseCases
    ..registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(getIt()),
    )
    ..registerLazySingleton<SignupUseCase>(
      () => SignupUseCase(getIt()),
    )
    ..registerLazySingleton<VerifyOtpUseCase>(
      () => VerifyOtpUseCase(getIt()),
    )
    ..registerLazySingleton<ResendOtpUseCase>(
      () => ResendOtpUseCase(getIt()),
    )
    ..registerLazySingleton<ForgotPasswordUseCase>(
      () => ForgotPasswordUseCase(getIt()),
    )
    ..registerLazySingleton<ResetPasswordUseCase>(
      () => ResetPasswordUseCase(getIt()),
    )
    ..registerLazySingleton<GetBrandsUseCase>(
      () => GetBrandsUseCase(getIt()),
    )
    ..registerLazySingleton<GetCategoriesUseCase>(
      () => GetCategoriesUseCase(getIt()),
    )
    ..registerLazySingleton<GetFavoritesUseCase>(
      () => GetFavoritesUseCase(getIt()),
    )
    ..registerLazySingleton<ToggleFavoriteUseCase>(
      () => ToggleFavoriteUseCase(getIt()),
    )
    ..registerLazySingleton<SearchProductsUseCase>(
      () => SearchProductsUseCase(getIt()),
    )
    ..registerLazySingleton<GetCategoryItemsUseCase>(
      () => GetCategoryItemsUseCase(getIt()),
    )
    ..registerLazySingleton<GetGlobalAttributesUseCase>(
      () => GetGlobalAttributesUseCase(getIt()),
    )
    ..registerLazySingleton<GetProductUseCase>(
      () => GetProductUseCase(getIt()),
    )
    ..registerLazySingleton<AddReviewUseCase>(
      () => AddReviewUseCase(getIt()),
    )
    ..registerLazySingleton<GetCartUseCase>(
      () => GetCartUseCase(getIt()),
    )
    ..registerLazySingleton<AddToCartUseCase>(
      () => AddToCartUseCase(getIt()),
    )
    ..registerLazySingleton<UpdateCartItemUseCase>(
      () => UpdateCartItemUseCase(getIt()),
    )
    ..registerLazySingleton<RemoveFromCartUseCase>(
      () => RemoveFromCartUseCase(getIt()),
    )
    ..registerLazySingleton<CheckoutUseCase>(
      () => CheckoutUseCase(getIt()),
    )
    ..registerLazySingleton<GetShippingFeeUseCase>(
      () => GetShippingFeeUseCase(getIt()),
    )
    ..registerLazySingleton<GetOrdersUseCase>(
      () => GetOrdersUseCase(getIt()),
    )
    ..registerLazySingleton<GetOrderDetailsUseCase>(
      () => GetOrderDetailsUseCase(getIt()),
    )
    ..registerLazySingleton<GetNotificationsUseCase>(
      () => GetNotificationsUseCase(getIt()),
    )
    ..registerLazySingleton<GetContactInfoUseCase>(
      () => GetContactInfoUseCase(getIt()),
    )
    ..registerLazySingleton<GetProfileUseCase>(
      () => GetProfileUseCase(getIt()),
    )
    ..registerLazySingleton<UpdateProfileUseCase>(
      () => UpdateProfileUseCase(getIt()),
    )
    ..registerLazySingleton<GetPriceModeUseCase>(
      () => GetPriceModeUseCase(getIt()),
    )
    ..registerLazySingleton<SetPriceModeUseCase>(
      () => SetPriceModeUseCase(getIt()),
    )
    ..registerLazySingleton<FetchHomeDataUseCase>(
      () => FetchHomeDataUseCase(
        homeRepository: getIt(),
        categoryRepo: getIt(),
        brandRepo: getIt(),
      ),
    )
    // 5. Cubits & Blocs (State Holders)
    ..registerSingleton<ThemeBloc>(ThemeBloc(initialThemeMode))
    ..registerSingleton<PriceModeBloc>(
      PriceModeBloc(
        getPriceModeUseCase: getIt(),
        setPriceModeUseCase: getIt(),
      ),
    )
    ..registerLazySingleton<LanguageBloc>(LanguageBloc.new)
    ..registerFactory<LoginBloc>(
      () => LoginBloc(loginUseCase: getIt()),
    )
    ..registerFactory<SignupBloc>(
      () => SignupBloc(signupUseCase: getIt()),
    )
    ..registerFactoryParam<OtpBloc, OtpFlowType, void>(
      (flowType, _) => OtpBloc(
        verifyOtpUseCase: getIt(),
        resendOtpUseCase: getIt(),
        flowType: flowType,
      ),
    )
    ..registerFactory<ForgotPasswordBloc>(
      () => ForgotPasswordBloc(forgotPasswordUseCase: getIt()),
    )
    ..registerFactory<ResetPasswordBloc>(
      () => ResetPasswordBloc(resetPasswordUseCase: getIt()),
    )
    ..registerFactory<BrandBloc>(
      () => BrandBloc(getBrandsUseCase: getIt()),
    )
    ..registerFactory<CategoryBloc>(
      () => CategoryBloc(getCategoriesUseCase: getIt()),
    )
    ..registerFactoryParam<CategoryItemsBloc, ItemFetchType, int?>(
      (fetchType, id) => CategoryItemsBloc(
        getCategoryItemsUseCase: getIt(),
        getGlobalAttributesUseCase: getIt(),
        fetchType: fetchType,
        categoryId: fetchType == ItemFetchType.category ? id : null,
        brandId: fetchType == ItemFetchType.brand ? id : null,
      ),
    )
    ..registerFactory<ProductBloc>(
      () => ProductBloc(getProductUseCase: getIt()),
    )
    ..registerFactory<SearchBloc>(
      () => SearchBloc(searchProductsUseCase: getIt()),
    )
    ..registerLazySingleton<FavoriteBloc>(
      () => FavoriteBloc(
        getFavoritesUseCase: getIt(),
        toggleFavoriteUseCase: getIt(),
      ),
    )
    ..registerLazySingleton<CartBloc>(
      () => CartBloc(
        getCartUseCase: getIt(),
        addToCartUseCase: getIt(),
        updateCartItemUseCase: getIt(),
        removeFromCartUseCase: getIt(),
      ),
    )
    ..registerFactory<ReviewBloc>(
      () => ReviewBloc(addReviewUseCase: getIt()),
    )
    ..registerFactory<CheckoutBloc>(
      () => CheckoutBloc(
        checkoutUseCase: getIt(),
        getShippingFeeUseCase: getIt(),
      ),
    )
    ..registerFactory<OrdersBloc>(
      () => OrdersBloc(getOrdersUseCase: getIt()),
    )
    ..registerFactory<OrderDetailsBloc>(
      () => OrderDetailsBloc(getOrderDetailsUseCase: getIt()),
    )
    ..registerFactory<NotificationBloc>(
      () => NotificationBloc(getNotificationsUseCase: getIt()),
    )
    ..registerFactory<HomeBloc>(() => HomeBloc(useCase: getIt()))
    ..registerFactory<ContactBloc>(
      () => ContactBloc(getContactInfoUseCase: getIt()),
    )
    ..registerFactory<ProfileBloc>(
      () => ProfileBloc(
        getProfileUseCase: getIt(),
        updateProfileUseCase: getIt(),
        authService: getIt(),
      ),
    );
}
