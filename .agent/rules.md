# Baynona Project Rules & Guidelines

> **Project Context**: Flutter E-Commerce Application (Wholesale & Retail)  
> **Architecture**: Clean Architecture + MVVM Pattern  
> **State Management**: BLoC (flutter_bloc)  
> **Languages**: English & Arabic (RTL Support)

---

## 📋 Table of Contents

1. [Project Architecture](#1-project-architecture)
2. [Folder Structure](#2-folder-structure)
3. [Naming Conventions](#3-naming-conventions)
4. [Code Organization](#4-code-organization)
5. [State Management (BLoC)](#5-state-management-bloc)
6. [API Integration](#6-api-integration)
7. [UI/UX Guidelines](#7-uiux-guidelines)
8. [Localization](#8-localization)
9. [Error Handling](#9-error-handling)
10. [Performance Optimization](#10-performance-optimization)
11. [Testing](#11-testing)
12. [Best Practices](#12-best-practices)

---

## 1. Project Architecture

### 1.1 MVVM Layers (Model-View-ViewModel + Repository & Service)

```
Feature/
├── model/          # Data models (JSON serialization, Entity definitions)
├── service/        # API calls (Dio integration, Endpoint definitions)
├── repo/           # Repository (Business logic, Data validation, Data transformation)
├── view_model/     # ViewModel (BLoC/Cubit + State, UI logic, User actions handling)
└── view/           # UI (Main View, Widgets, Presentation logic)
```

### 1.2 Layer Responsibilities

| Layer | Responsibility | Example |
|-------|---------------|---------|
| **Model** | Defines the data structure and handles JSON serialization. | `Product`, `User`, `Order` |
| **Service** | Handles raw HTTP requests and returns raw data or responses. | `AuthService`, `CartService` |
| **Repository** | Acts as a bridge between Service and ViewModel. Handles business logic and validation. | `AllProductsRepo` |
| **ViewModel (Cubit)** | Manages UI state and handles user interactions. Emits immutable states. | `AllProductsCubit` |
| **View** | Renders the UI based on the ViewModel's state. No business logic here. | `HomeView`, `ProductDetailsView` |

### 1.3 Dependency & Data Flow

```
View → ViewModel (Cubit) → Repository → Service → API
```

**Strict Compliance Rules**:
- ✅ **Model**: Must only contain data and serialization logic (`fromJson`/`toJson`).
- ✅ **Service**: Must only handle network communication. No business logic.
- ✅ **Repository**: **MUST** be the only layer the ViewModel talks to for data. It transforms raw service output into usable models.
- ✅ **ViewModel**: Listens to business logic from Repo and updates state. **NEVER** talk to Service directly.
- ✅ **View**: Must be "dumb". It only displays state and sends events/commands to ViewModel.

---

## 2. Folder Structure

### 2.1 Core Directory (`lib/core/`)

```
core/
├── main/
│   ├── app_content.dart      # Main app widget
│   └── app_initializer.dart  # App initialization logic
├── models/                    # Shared models (Category, Brand, Offer)
├── service/
│   ├── cache_helper.dart     # SharedPreferences wrapper
│   ├── dio_helper.dart       # Dio client configuration
│   └── service_locator.dart  # GetIt DI setup
├── theme/                     # App theming (colors, text styles)
└── utils/                     # Shared utilities and widgets
    ├── widgets/               # Reusable widgets
    └── *.dart                 # Helper functions
```

### 2.2 Features Directory (`lib/features/`)

Each feature **MUST** follow this structure:

```
feature_name/
├── model/              # Feature-specific models
├── service/            # API service for this feature
├── repo/               # Repository layer
├── view_model/
│   ├── feature_cubit.dart
│   └── feature_state.dart
├── view/               # Main view file(s)
└── widgets/            # Feature-specific widgets (optional)
```

**Example**: `lib/features/home/all_products/`

---

## 3. Naming Conventions

### 3.1 Files

| Type | Convention | Example |
|------|-----------|---------|
| Model | `{entity}.dart` | `product.dart`, `user.dart` |
| Service | `{feature}_service.dart` | `auth_service.dart` |
| Repository | `{feature}_repo.dart` | `all_products_repo.dart` |
| Cubit | `{feature}_cubit.dart` | `banner_cubit.dart` |
| State | `{feature}_state.dart` | `banner_state.dart` |
| View | `{feature}_view.dart` | `home_view.dart` |
| Widget | `{descriptive_name}.dart` | `custom_button.dart` |

### 3.2 Classes

```dart
// ✅ Correct
class ProductDetailsView extends StatelessWidget {}
class AllProductsCubit extends Cubit<AllProductsState> {}
class AuthService {}

// ❌ Wrong
class ProductDetails {}  // Missing 'View' suffix
class ProductCubit {}    // Not descriptive enough
```

### 3.3 Variables & Functions

```dart
// ✅ Use camelCase
final userName = "Ahmed";
void fetchProducts() {}

// ✅ Boolean variables should start with 'is', 'has', 'can'
bool isLoading = false;
bool hasReachedMax = true;
bool canAddToCart = false;

// ❌ Avoid abbreviations
final prdList = [];  // Use 'productList' instead
```

---

## 4. Code Organization

### 4.1 Import Order

**ALWAYS** organize imports in this order:

```dart
// 1. Dart/Flutter SDK imports
import 'dart:async';
import 'package:flutter/material.dart';

// 2. External package imports
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

// 3. Internal imports (relative paths)
import '../../models/product.dart';
import '../service/product_service.dart';
```

### 4.2 Class Structure

```dart
class ExampleWidget extends StatelessWidget {
  // 1. Constructor
  const ExampleWidget({super.key, required this.title});

  // 2. Final fields
  final String title;

  // 3. Static constants
  static const double padding = 16.0;

  // 4. Build method (for widgets)
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  // 5. Private helper methods
  void _privateHelper() {}

  // 6. Public methods
  void publicMethod() {}
}
```

---

## 5. State Management (BLoC)

### 5.1 Cubit Structure

**Template**:

```dart
class FeatureCubit extends Cubit<FeatureState> {
  FeatureCubit({required this.repository}) 
    : super(const FeatureState());

  final FeatureRepo repository;

  // Public methods only
  Future<void> fetchData() async {
    emit(state.copyWith(status: FeatureStatus.loading));
    
    try {
      final response = await repository.getData();
      emit(state.copyWith(
        status: FeatureStatus.success,
        data: response.data,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FeatureStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
```

### 5.2 State Structure

**Template**:

```dart
enum FeatureStatus { initial, loading, success, failure }

class FeatureState extends Equatable {
  const FeatureState({
    this.status = FeatureStatus.initial,
    this.data = const [],
    this.errorMessage = '',
    this.currentPage = 1,
    this.lastPage = 1,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
  });

  final FeatureStatus status;
  final List<DataType> data;
  final String errorMessage;
  final int currentPage;
  final int lastPage;
  final bool hasReachedMax;
  final bool isLoadingMore;

  // ✅ ALWAYS implement copyWith
  FeatureState copyWith({
    FeatureStatus? status,
    List<DataType>? data,
    String? errorMessage,
    int? currentPage,
    int? lastPage,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) {
    return FeatureState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [
    status,
    data,
    errorMessage,
    currentPage,
    lastPage,
    hasReachedMax,
    isLoadingMore,
  ];
}
```

### 5.3 BLoC Usage in Views

```dart
// ✅ Use BlocBuilder for specific state changes
BlocBuilder<ProductCubit, ProductState>(
  builder: (context, state) {
    if (state.status == ProductStatus.loading) {
      return const LoadingWidget();
    }
    if (state.status == ProductStatus.failure) {
      return ErrorWidget(message: state.errorMessage);
    }
    return ProductList(products: state.products);
  },
)

// ✅ Use BlocSelector for single property
BlocSelector<CartCubit, CartState, int>(
  selector: (state) => state.itemCount,
  builder: (context, itemCount) {
    return Text('$itemCount items');
  },
)

// ✅ Use BlocListener for side effects (navigation, snackbars)
BlocListener<AuthCubit, AuthState>(
  listener: (context, state) {
    if (state.status == AuthStatus.success) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  },
  child: LoginForm(),
)
```

### 5.4 Pagination Pattern

**ALWAYS** implement pagination using this pattern:

```dart
class FeatureCubit extends Cubit<FeatureState> {
  final int perPage = 10;

  // Initial load
  Future<void> fetchData() async {
    emit(state.copyWith(
      status: FeatureStatus.loading,
      currentPage: 1,
      hasReachedMax: false,
    ));

    final response = await repository.getData(perPage: perPage);
    final items = response.data?.data ?? [];
    final currentPage = response.data?.currentPage ?? 1;
    final lastPage = response.data?.lastPage ?? 1;

    emit(state.copyWith(
      status: FeatureStatus.success,
      items: items,
      currentPage: currentPage,
      lastPage: lastPage,
      hasReachedMax: currentPage >= lastPage,
    ));
  }

  // Load more (pagination)
  Future<void> loadMore() async {
    if (state.hasReachedMax || state.isLoadingMore) return;

    emit(state.copyWith(isLoadingMore: true));

    final nextPage = state.currentPage + 1;
    final response = await repository.getData(
      page: nextPage,
      perPage: perPage,
    );

    final newItems = response.data?.data ?? [];
    final updatedItems = List.from(state.items)..addAll(newItems);

    emit(state.copyWith(
      items: updatedItems,
      currentPage: response.data?.currentPage,
      hasReachedMax: response.data?.currentPage >= response.data?.lastPage,
      isLoadingMore: false,
    ));
  }
}
```

---

## 6. API Integration

### 6.1 Service Layer

**Template**:

```dart
class FeatureService {
  FeatureService({required this.dio});
  final Dio dio;

  static const String baseUrl = 'https://api.example.com';

  Future<ResponseType> getData({
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      final response = await dio.get(
        '$baseUrl/endpoint',
        queryParameters: {
          'page': page,
          'per_page': perPage,
        },
      );
      
      return ResponseType.fromJson(response.data);
    } on DioException catch (e) {
      // Handle specific errors
      if (e.type == DioExceptionType.connectionTimeout) {
        throw TimeoutException('Connection timeout');
      }
      throw Exception('Failed to fetch data: ${e.message}');
    }
  }
}
```

### 6.2 Error Handling

**ALWAYS** handle these errors:

```dart
try {
  final response = await repository.getData();
} on SocketException {
  showSnackBar('No internet connection');
} on TimeoutException {
  showSnackBar('Request timed out');
} on DioException catch (e) {
  if (e.response?.statusCode == 401) {
    // Handle unauthorized
  } else if (e.response?.statusCode == 404) {
    // Handle not found
  }
  showSnackBar(e.response?.data['message'] ?? 'Unknown error');
} catch (e) {
  showSnackBar('An unexpected error occurred');
}
```

### 6.3 Repository Layer

```dart
class FeatureRepo {
  FeatureRepo({required this.service});
  final FeatureService service;

  // ✅ Repository handles business logic
  Future<ProductListResponse> getProducts({
    int page = 1,
    int perPage = 10,
  }) async {
    // Add validation or business logic here if needed
    return await service.getProducts(page: page, perPage: perPage);
  }

  // ✅ Transform data if needed
  Future<List<Product>> getValidProducts() async {
    final response = await service.getProducts();
    return response.data?.data
      .where((p) => p.stock > 0)
      .toList() ?? [];
  }
}
```

---

## 7. UI/UX Guidelines

### 7.1 Widget Composition

```dart
// ✅ Do: Extract widgets for reusability
class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(child: ...);
  }
}

// ✅ Do: Use const constructors when possible
const SizedBox(height: 16)
const Divider()

// ❌ Don't: Build everything in one widget
class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 500 lines of code here ❌
        ],
      ),
    );
  }
}
```

### 7.2 Responsive Design

**ALWAYS** use `responsive_helper.dart` for responsive sizing (based on `flutter_screenutil`):

```dart
import '../../../../core/utils/responsive_helper.dart'; // Example path

// ✅ Use .toW for width, .toH for height, .toSp for font size, .toR for radius
Container(
  width: 100.toW,
  height: 50.toH,
  padding: EdgeInsets.symmetric(horizontal: 16.toW, vertical: 8.toH),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12.toR),
  ),
  child: Text(
    'Hello',
    style: TextStyle(fontSize: 14.toSp),
  ),
)
```

### 7.3 Loading States

**ALWAYS** show loading indicators:

```dart
// ✅ Use Skeletonizer for list loading
if (state.status == ProductStatus.loading) {
  return Skeletonizer(
    enabled: true,
    child: ListView.builder(
      itemCount: 5,
      itemBuilder: (_, __) => const ProductCardSkeleton(),
    ),
  );
}

// ✅ Use CircularProgressIndicator for page loading
if (state.isLoadingMore) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(16),
      child: CircularProgressIndicator(),
    ),
  );
}
```

### 7.4 Empty States

```dart
// ✅ Always handle empty states
if (state.products.isEmpty) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.inbox_outlined, size: 64.toW),
        SizedBox(height: 16.toH),
        Text('No products found'),
      ],
    ),
  );
}
```

---

## 8. Localization

### 8.1 Using Localized Strings

```dart
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ✅ Always use localization
Text(AppLocalizations.of(context)!.welcomeMessage)

// ❌ Never hardcode strings
Text('Welcome')  // Wrong!
```

### 8.2 Adding New Translations

1. Add to `lib/l10n/app_en.arb`:
```json
{
  "productName": "Product Name"
}
```

2. Add to `lib/l10n/app_ar.arb`:
```json
{
  "productName": "اسم المنتج"
}
```

3. Run code generation:
```bash
flutter gen-l10n
```

### 8.3 RTL Support

```dart
// ✅ Use Directionality-aware widgets
Padding(
  padding: EdgeInsetsDirectional.only(start: 16.w),
  child: Text('Text'),
)

// ❌ Don't use hardcoded left/right
Padding(
  padding: EdgeInsets.only(left: 16.w),  // Wrong for RTL
)
```

---

## 9. Error Handling

### 9.1 User-Facing Errors

**ALWAYS** show user-friendly messages:

```dart
void _showError(BuildContext context, String error) {
  // Convert technical errors to user-friendly messages
  final message = error.contains('SocketException')
      ? AppLocalizations.of(context)!.noInternetConnection
      : error.contains('TimeoutException')
          ? AppLocalizations.of(context)!.requestTimeout
          : AppLocalizations.of(context)!.genericError;

  showSnackBar(context, message);
}
```

### 9.2 Logging

```dart
// ✅ Use debugPrint for development
debugPrint('Error fetching products: $e');

// ❌ NEVER use print() or console.log
print('Error');  // Wrong!

// ⚠️ Remove ALL logging statements before production
```

---

## 10. Performance Optimization

### 10.1 Const Constructors

```dart
// ✅ Use const whenever possible
const Text('Static text')
const SizedBox(height: 16)
const Icon(Icons.home)

// ❌ Avoid unnecessary rebuilds
Text('Static text')  // Missing const
```

### 10.2 Image Optimization

```dart
// ✅ Use CachedNetworkImage for network images
CachedNetworkImage(
  imageUrl: product.imageUrl,
  memCacheHeight: 100,
  errorWidget: (_, __, ___) => const Icon(Icons.error),
  fit: BoxFit.cover,
)

// ❌ Don't use Image.network directly
Image.network(url)  // No caching!
```

### 10.3 List Optimization

```dart
// ✅ Use ListView.builder for long lists
ListView.builder(
  itemCount: products.length,
  itemBuilder: (context, index) {
    return ProductCard(product: products[index]);
  },
)

// ❌ Don't use ListView with all children
ListView(
  children: products.map((p) => ProductCard(product: p)).toList(),
)
```

### 10.4 Prevent Unnecessary Rebuilds

```dart
// ✅ Use BlocSelector for specific properties
BlocSelector<CartCubit, CartState, int>(
  selector: (state) => state.itemCount,
  builder: (context, itemCount) => Text('$itemCount'),
)

// ✅ Use buildWhen to control rebuilds
BlocBuilder<ProductCubit, ProductState>(
  buildWhen: (previous, current) => previous.products != current.products,
  builder: (context, state) {
    return ProductList(products: state.products);
  },
)
```

---

## 11. Testing

### 11.1 Unit Tests (Models)

```dart
test('Product.fromJson should parse correctly', () {
  final json = {'id': 1, 'name': 'Test Product'};
  final product = Product.fromJson(json);
  
  expect(product.id, 1);
  expect(product.name, 'Test Product');
});
```

### 11.2 Cubit Tests

```dart
blocTest<ProductCubit, ProductState>(
  'emits [loading, success] when fetchProducts succeeds',
  build: () => ProductCubit(repository: mockRepo),
  act: (cubit) => cubit.fetchProducts(),
  expect: () => [
    const ProductState(status: ProductStatus.loading),
    ProductState(
      status: ProductStatus.success,
      products: mockProducts,
    ),
  ],
);
```

---

## 12. Best Practices

### 12.1 General Guidelines

```dart
// ✅ Do
- Use meaningful variable names
- Add comments for complex logic
- Keep functions small (< 50 lines)
- Follow DRY (Don't Repeat Yourself)
- Use early returns to reduce nesting
- Prefer composition over inheritance

// ❌ Don't
- Leave unused imports
- Use magic numbers (define constants)
- Nest code more than 3 levels deep
- Ignore lint warnings
- Commit commented-out code
```

### 12.2 Code Quality

```dart
// ✅ Use early returns
String getProductStatus(Product product) {
  if (product.stock == 0) return 'Out of stock';
  if (product.stock < 10) return 'Low stock';
  return 'In stock';
}

// ❌ Avoid deep nesting
String getProductStatus(Product product) {
  if (product.stock > 0) {
    if (product.stock >= 10) {
      return 'In stock';
    } else {
      return 'Low stock';
    }
  } else {
    return 'Out of stock';
  }
}
```

### 12.3 Null Safety

```dart
// ✅ Use null-aware operators
final name = user?.name ?? 'Guest';
final email = user?.email;

// ✅ Use null assertion only when certain
final userId = user!.id;  // Only if you're 100% sure user is not null

// ❌ Don't overuse null assertions
final data = response!.data!.items!.first!;  // Dangerous!
```

### 12.4 Dependency Injection

**ALWAYS** use GetIt for dependency injection:

```dart
// Setup in service_locator.dart
void setupServiceLocator() {
  final getIt = GetIt.instance;
  
  // Services
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton(() => AuthService(dio: getIt()));
  
  // Repositories
  getIt.registerLazySingleton(() => AuthRepo(service: getIt()));
  
  // Cubits (factories for multiple instances)
  getIt.registerFactory(() => AuthCubit(repository: getIt()));
}

// Usage in views
BlocProvider(
  create: (_) => getIt<ProductCubit>()..fetchProducts(),
  child: ProductView(),
)
```

### 12.5 Git Workflow

```bash
# ✅ Commit messages
git commit -m "feat: Add product variant selection logic"
git commit -m "fix: Resolve quantity validation error"
git commit -m "refactor: Extract product card widget"

# ✅ Branch naming
feature/product-variants
fix/cart-calculation
refactor/auth-flow

# ❌ Bad commit messages
git commit -m "update"
git commit -m "fix bug"
git commit -m "changes"
```

---

## 🎯 Summary Checklist

Before committing code, ensure:

- [ ] Code follows strict MVVM layers (View -> VM -> Repo -> Service)
- [ ] All imports are organized correctly (Dart -> Packages -> Internal)
- [ ] Used const constructors where possible
- [ ] Implemented proper error handling at Service and VM levels
- [ ] Added loading and empty states in Views
- [ ] Used localization for all user-facing strings
- [ ] Followed naming conventions for all layers
- [ ] Removed all debug print statements
- [ ] No lint warnings
- [ ] Code is properly formatted (`dart format .`)
- [ ] Dependencies are properly injected via GetIt
- [ ] BLoC states are immutable with copyWith
- [ ] Used responsive helper sizing (.toW, .toH, .toSp, .toR)
- [ ] Image optimization used (memCacheHeight, CachedNetworkImage)

---

**Last Updated**: January 2026  
**Version**: 1.0.0
