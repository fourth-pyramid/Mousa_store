[bloc]
[flutter-best-practices]
[flutter-apply-architecture-best-practices]
[flutter-app-architecture]

# STRICT PROJECT-WIDE MIGRATION
# MVVM → BLoC + CLEAN ARCHITECTURE
# FEATURE-FIRST / PRODUCTION-GRADE FLUTTER

You are working on an existing production Flutter application.

The project currently uses a Feature-First MVVM-style architecture.

Example of the current structure:

categories/
├── models/
├── repositories/
├── services/
├── viewmodels/
└── views/

I want you to migrate the ENTIRE project to:

FEATURE-FIRST + CLEAN ARCHITECTURE + BLoC

This is a COMPLETE ARCHITECTURAL MIGRATION.

Do NOT simply rename folders.

Do NOT blindly move files.

Do NOT create unnecessary abstractions.

You must analyze the current project, understand the existing responsibilities, and then reorganize the architecture correctly.

The final architecture must have clear separation between:

PRESENTATION
DOMAIN
DATA

and use BLoC as the presentation state-management solution.

==================================================
# 1. PRIMARY OBJECTIVE
==================================================

Transform the existing MVVM architecture into:

Feature-First
+
Clean Architecture
+
BLoC

The final dependency direction must be:

Presentation
      ↓
Domain
      ↓
Data

More precisely:

Presentation
    ↓
Use Cases
    ↓
Domain Repository Interfaces
    ↑
Data Repository Implementations
    ↓
Data Sources / APIs / Local Storage

The Domain layer MUST NOT depend on:

- Flutter
- BLoC
- Dio
- HTTP clients
- Supabase
- Hive
- SharedPreferences
- Firebase
- UI widgets
- BuildContext
- Navigation
- platform-specific APIs

The Domain layer must remain as framework-independent as reasonably possible.

==================================================
# 2. NON-NEGOTIABLE ARCHITECTURAL RULES
==================================================

1. DO NOT simply rename `viewmodels` to `bloc`.

2. DO NOT move ViewModel code directly into Bloc classes.

3. DO NOT keep ViewModels after their migration is complete.

4. DO NOT let BLoCs call APIs directly.

5. DO NOT let BLoCs depend directly on Dio/http/Supabase/Hive/etc.

6. DO NOT let Presentation depend directly on Data implementations.

7. DO NOT let Domain depend on Data.

8. DO NOT put business rules inside widgets.

9. DO NOT put business rules inside services.

10. DO NOT put UI logic inside repositories.

11. DO NOT put navigation inside BLoCs.

12. DO NOT put SnackBars/Dialog logic inside BLoCs.

13. DO NOT expose Data Models directly to Presentation when a Domain Entity is appropriate.

14. Repository interfaces belong to Domain.

15. Repository implementations belong to Data.

16. Use Cases belong to Domain.

17. API/local implementations belong to Data.

18. BLoCs belong to Presentation.

19. Widgets/pages belong to Presentation.

20. Use dependency injection to connect layers.

21. Dependencies must point inward toward Domain abstractions.

22. Follow YAGNI.

23. Do not create Use Cases that merely wrap trivial code unless they provide meaningful application/domain behavior.

24. Do not create abstractions that provide no architectural value.

25. Do not introduce a new package/framework unless it is genuinely required.

26. Preserve existing application behavior.

27. Preserve existing API behavior.

28. Preserve authentication behavior.

29. Preserve caching/offline behavior.

30. Preserve pagination.

31. Preserve search/filter functionality.

32. Preserve navigation and deep links.

33. Preserve error handling semantics unless the current implementation is incorrect.

34. Follow the project's actual Flutter/Dart version.

35. Do not use language features unsupported by the project's Dart version.

==================================================
# 3. TARGET FEATURE ARCHITECTURE
==================================================

Each feature should follow this general structure:

feature/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
│
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
│
└── presentation/
    ├── bloc/
    ├── pages/
    └── widgets/

Example:

categories/
│
├── data/
│   ├── datasources/
│   │   ├── category_remote_data_source.dart
│   │   └── category_local_data_source.dart
│   │
│   ├── models/
│   │   └── category_model.dart
│   │
│   └── repositories/
│       └── category_repository_impl.dart
│
├── domain/
│   ├── entities/
│   │   └── category.dart
│   │
│   ├── repositories/
│   │   └── category_repository.dart
│   │
│   └── usecases/
│       ├── get_categories.dart
│       └── get_category.dart
│
└── presentation/
    ├── bloc/
    │   ├── categories_bloc.dart
    │   ├── categories_event.dart
    │   └── categories_state.dart
    │
    ├── pages/
    │   └── categories_page.dart
    │
    └── widgets/
        └── category_card.dart

Do NOT blindly create all possible files.

Only create files that are justified by the feature.

==================================================
# 4. CURRENT → TARGET MAPPING
==================================================

Analyze the existing architecture and map responsibilities.

CURRENT:

models/
repositories/
services/
viewmodels/
views/

TARGET:

models
→ data/models

services
→ data/datasources

repositories
→ split into:

domain/repositories
+
data/repositories

viewmodels
→ presentation/bloc

views
→ presentation/pages
+
presentation/widgets

IMPORTANT:

A current repository may contain both:

- abstraction
- implementation

If so, split them correctly.

Example:

Current:

CategoryRepository

If it is an abstraction:

→ domain/repositories/category_repository.dart

If it contains Dio/API implementation:

→ data/repositories/category_repository_impl.dart

==================================================
# 5. DOMAIN LAYER
==================================================

The Domain layer represents application/business rules.

It should contain:

- Entities
- Repository contracts/interfaces
- Use Cases

Example:

domain/entities/category.dart

domain/repositories/category_repository.dart

domain/usecases/get_categories.dart

Example:

abstract class CategoryRepository {
  Future<Result<List<Category>>> getCategories();
}

The exact Result/Error pattern must follow the existing project where appropriate.

Do NOT automatically introduce Either/Result if the project does not need it.

Use the simplest robust approach.

==================================================
# 6. ENTITIES VS MODELS
==================================================

Carefully distinguish:

DOMAIN ENTITY
vs
DATA MODEL

Example:

Domain:

class Category {
  final String id;
  final String name;

  const Category({
    required this.id,
    required this.name,
  });
}

Data:

class CategoryModel extends Category {
  const CategoryModel({
    required super.id,
    required super.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    ...
  }

  Map<String, dynamic> toJson() {
    ...
  }
}

Do NOT create duplicate Entity/Model classes if there is no meaningful separation.

However, if the current model contains:

- JSON parsing
- API-specific fields
- serialization
- database annotations
- transport-specific logic

then separate it from the Domain Entity.

The goal is correct boundaries, not maximum number of classes.

==================================================
# 7. DATA SOURCES
==================================================

Move external data access into Data Sources.

Typical structure:

data/datasources/

category_remote_data_source.dart

category_local_data_source.dart

Remote Data Source responsibilities:

- API requests
- Dio/http/Supabase calls
- serialization
- API-specific exceptions
- remote response handling

Local Data Source responsibilities:

- Hive
- SharedPreferences
- local database
- local cache
- local persistence

Data Sources must NOT:

- update UI
- navigate
- emit BLoC states
- know about widgets
- know about BuildContext

==================================================
# 8. REPOSITORY IMPLEMENTATION
==================================================

Repository implementation belongs in Data.

Example:

class CategoryRepositoryImpl implements CategoryRepository {

  final CategoryRemoteDataSource remoteDataSource;

  CategoryRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<...> getCategories() async {
    ...
  }
}

The repository implementation is responsible for:

- coordinating data sources
- mapping Models → Entities where appropriate
- handling data-source errors
- deciding remote/local source strategy
- caching strategy when appropriate

It must NOT contain UI logic.

==================================================
# 9. REPOSITORY INTERFACE
==================================================

Repository interfaces belong to Domain.

Example:

abstract class CategoryRepository {
  Future<List<Category>> getCategories();
}

The Domain layer should depend only on this abstraction.

It must NOT know:

- CategoryRepositoryImpl
- Dio
- Supabase
- API URLs
- HTTP response objects
- JSON
- database implementation

==================================================
# 10. USE CASES
==================================================

Use Cases belong to Domain.

They represent meaningful application actions.

Examples:

GetCategories
GetCategory
CreateCategory
UpdateCategory
DeleteCategory
SearchCategories
RefreshCategories

Example:

class GetCategories {
  final CategoryRepository repository;

  GetCategories(this.repository);

  Future<List<Category>> call() {
    return repository.getCategories();
  }
}

BLoC should call Use Cases rather than directly calling repository implementations.

Flow:

UI
↓
BLoC Event
↓
Use Case
↓
Domain Repository
↓
Data Repository Implementation
↓
Data Source
↓
API / Local Storage

==================================================
# 11. BLoC ARCHITECTURE
==================================================

BLoC belongs entirely to Presentation.

BLoC responsibilities:

- receive Events
- call Use Cases
- transform results into States
- coordinate presentation state
- manage loading/error/success states

BLoC must NOT:

- call Dio
- call Supabase directly
- call Hive directly
- call HTTP clients
- parse JSON
- navigate
- show SnackBars
- show dialogs
- manipulate widgets

Example:

CategoriesStarted
        ↓
CategoriesBloc
        ↓
GetCategories()
        ↓
CategoryRepository
        ↓
CategoryRepositoryImpl
        ↓
CategoryRemoteDataSource
        ↓
API

==================================================
# 12. BLOC EVENTS
==================================================

Events must represent user intent or meaningful state transitions.

Examples:

CategoriesStarted
CategoriesRefreshed
CategoriesLoadMoreRequested
CategorySelected
CategoriesSearchChanged
CategoriesRetryRequested

Do NOT create events for internal implementation details.

Avoid excessive events.

==================================================
# 13. BLOC STATES
==================================================

States must be immutable and predictable.

Avoid contradictory boolean states such as:

isLoading
isSuccess
hasError

all being independently mutable.

Prefer a clear state model.

For example:

CategoriesInitial

CategoriesLoading

CategoriesLoaded

CategoriesEmpty

CategoriesError

For complex features, preserve existing data while refreshing or loading more.

Example:

Loaded categories
↓
Refresh
↓
Refreshing with previous data
↓
Updated Loaded state

Do NOT unnecessarily clear the existing list during refresh.

==================================================
# 14. UI / PRESENTATION
==================================================

Pages and widgets belong to Presentation.

Presentation should:

- dispatch events
- render states
- handle UI side effects

Use:

BlocProvider
BlocBuilder
BlocListener
BlocConsumer
BlocSelector

appropriately.

Use BlocSelector when only a small state portion is required.

Do not use BlocConsumer everywhere.

Use BlocListener for:

- navigation
- SnackBars
- dialogs
- one-time UI effects

Example:

BlocListener<AuthBloc, AuthState>(
  listener: (context, state) {
    if (state is Authenticated) {
      // Navigation
    }
  },
)

The BLoC itself must not navigate.

==================================================
# 15. DEPENDENCY INJECTION
==================================================

Analyze the project's current dependency injection.

Use the existing DI system if it is reasonable.

Register:

Data Sources
↓
Repository Implementations
↓
Use Cases
↓
BLoCs

Example:

RemoteDataSource
→ RepositoryImpl
→ GetCategories
→ CategoriesBloc

Do not instantiate repositories/services inside widgets.

Do not instantiate API clients inside BLoCs.

Do not introduce a DI framework unless necessary.

==================================================
# 16. ERROR HANDLING
==================================================

Audit the existing error architecture.

Errors should flow cleanly:

Data Source
↓
Repository
↓
Use Case
↓
BLoC
↓
State
↓
UI

Do not expose raw API exceptions directly to the UI unless the project intentionally does so.

Do not silently swallow exceptions.

Do not use:

catch (_) {}

without a legitimate reason.

Preserve useful error information.

==================================================
# 17. PAGINATION
==================================================

Audit every paginated feature.

Correct flow:

Initial Load
→ Loading
→ Loaded

Load More
→ Existing Data + Loading More
→ New Data
→ Updated Data

Handle:

- duplicate requests
- concurrent requests
- last page
- failed pagination
- retry
- refresh
- empty results

Do not lose previously loaded data.

==================================================
# 18. SEARCH / FILTER
==================================================

Audit all:

- search
- filters
- sorting
- debounce

Move state handling into BLoC.

Keep filtering/business rules in appropriate layers.

Do not put complex filtering logic inside widgets.

Avoid unnecessary API calls.

Use debouncing only when justified.

==================================================
# 19. CACHING / OFFLINE
==================================================

Preserve existing:

- Hive
- SharedPreferences
- local DB
- memory cache
- offline mode
- API cache

Move data-access responsibility to Data.

BLoC only coordinates presentation state.

Repository determines the appropriate source.

==================================================
# 20. AUTHENTICATION
==================================================

If authentication exists, audit:

- login
- logout
- token storage
- refresh token
- current user
- session restoration
- email verification
- password reset
- auth guards
- deep links

Do not break existing authentication behavior.

Separate:

Presentation AuthBloc
Domain Auth UseCases
Data Auth Repository
Data Auth DataSources

where appropriate.

==================================================
# 21. NAVIGATION
==================================================

Navigation belongs to Presentation/Application routing.

BLoC must not directly call:

Navigator
GoRouter
BuildContext

Instead:

BLoC emits state
↓
BlocListener
↓
Router/UI reacts

Preserve all existing:

- routes
- deep links
- authentication redirects
- nested navigation
- cold start behavior

==================================================
# 22. PERFORMANCE
==================================================

While migrating, audit:

- unnecessary BLoC rebuilds
- BlocSelector opportunities
- repeated API calls
- duplicate events
- pagination requests
- widget rebuilds
- expensive build methods
- unnecessary state emissions
- unnecessary object creation
- memory usage

Do not optimize blindly.

Measure or identify a real reason before introducing complexity.

==================================================
# 23. TESTING
==================================================

Migrate existing ViewModel tests.

Create tests where important.

Test:

BLoC:

Event
→ Use Case
→ State

Repository:

Repository
→ Data Source
→ Result

Use Cases:

Use Case
→ Repository

Do not couple Domain tests to Flutter.

Use bloc_test if appropriate and consistent with the project.

Do not delete tests merely because the architecture changed.

==================================================
# 24. COMPLETE PROJECT AUDIT
==================================================

Before modifying anything, scan the ENTIRE project.

Find:

- all features
- all viewmodels
- all repositories
- all services
- all models
- all API clients
- all local data sources
- all state-management code
- all dependency injection
- all providers
- all ChangeNotifiers
- all Bloc/Cubit usage
- all navigation dependencies
- all tests

Create an internal migration map.

Example:

categories:
MVVM
→ Clean Architecture + BLoC

products:
MVVM
→ Clean Architecture + BLoC

profile:
MVVM
→ Clean Architecture + BLoC

auth:
MVVM
→ Clean Architecture + BLoC

==================================================
# 25. PHASED EXECUTION
==================================================

DO NOT perform a blind global replacement.

Work phase by phase.

--------------------------------------------------
PHASE 0 — COMPLETE ARCHITECTURE AUDIT
--------------------------------------------------

Do NOT modify code.

Inspect the entire project.

Document:

- current architecture
- every feature
- every ViewModel
- responsibilities
- repositories
- services
- models
- dependencies
- state management
- DI
- navigation
- API layer
- local storage
- tests
- migration risks

Then design the target architecture.

--------------------------------------------------
PHASE 1 — DEFINE ARCHITECTURAL CONVENTIONS
--------------------------------------------------

Establish:

- Feature-First structure
- Domain rules
- Data rules
- Presentation rules
- BLoC conventions
- Event naming
- State naming
- Repository conventions
- Use Case conventions
- Error handling
- DI conventions

Do NOT over-engineer.

--------------------------------------------------
PHASE 2 — MIGRATE ONE FEATURE COMPLETELY
--------------------------------------------------

Choose an appropriate feature.

Perform:

Current Feature Audit
↓
Domain Entities
↓
Domain Repository
↓
Use Cases
↓
Data Models
↓
Data Sources
↓
Repository Implementation
↓
BLoC Events
↓
BLoC States
↓
BLoC
↓
Dependency Injection
↓
Pages
↓
Widgets
↓
Tests
↓
Remove ViewModel
↓
flutter analyze

Do NOT start another feature until the current feature is clean.

--------------------------------------------------
PHASE 3 — MIGRATE REMAINING FEATURES
--------------------------------------------------

Repeat the complete process feature by feature.

Do NOT leave partially migrated features.

--------------------------------------------------
PHASE 4 — GLOBAL MVVM CLEANUP
--------------------------------------------------

Search for:

viewmodel
ViewModel
ChangeNotifier
notifyListeners
Provider
Consumer
context.watch
context.read

Determine whether each usage is still valid.

Remove obsolete MVVM code.

Do not remove unrelated valid code.

--------------------------------------------------
PHASE 5 — ARCHITECTURE VALIDATION
--------------------------------------------------

Verify dependency direction.

Presentation
↓
Domain

Data
↓
Domain

Domain
X Presentation
X Data
X Flutter
X API

Verify there are no violations.

--------------------------------------------------
PHASE 6 — PERFORMANCE REVIEW
--------------------------------------------------

Review:

- BLoC rebuilds
- state emissions
- API calls
- pagination
- search
- caching
- widget rebuilds
- memory

Optimize only where justified.

--------------------------------------------------
PHASE 7 — TESTING & BUILD
--------------------------------------------------

Run:

flutter analyze

flutter test

flutter build <appropriate-target>

Fix all errors and warnings caused by the migration.

Do not ignore analyzer warnings.

Do not leave dead code.

Do not leave unused imports.

Do not leave obsolete dependencies.

--------------------------------------------------
PHASE 8 — FINAL CLEAN ARCHITECTURE AUDIT
--------------------------------------------------

Verify:

1. No obsolete ViewModels remain.
2. No migrated feature depends on ViewModels.
3. BLoCs do not call APIs directly.
4. BLoCs do not depend on Data implementations.
5. Domain does not depend on Flutter.
6. Domain does not depend on Data.
7. Repository interfaces are in Domain.
8. Repository implementations are in Data.
9. Data Sources are in Data.
10. Use Cases are in Domain.
11. BLoCs are in Presentation.
12. UI does not contain business logic.
13. Navigation is outside BLoCs.
14. Error handling is consistent.
15. DI is correct.
16. Tests pass.
17. Analyzer passes.
18. Build passes.

==================================================
# 26. IMPORTANT — DO NOT OVER-ENGINEER
==================================================

Clean Architecture does NOT mean creating:

- interfaces for every class
- Use Cases for every trivial getter
- factories for everything
- managers for everything
- unnecessary service abstractions
- unnecessary Result wrappers
- unnecessary base classes
- unnecessary generic abstractions

Use Clean Architecture where it provides real separation of concerns.

Prefer:

Simple
+
Clear
+
Testable
+
Maintainable

over:

Complex
+
Over-abstracted
+
Hard to understand

==================================================
# 27. FINAL SUCCESS CRITERIA
==================================================

The migration is successful only when:

CURRENT:

Feature
├── models
├── repositories
├── services
├── viewmodels
└── views

becomes conceptually:

Feature
├── data
│   ├── datasources
│   ├── models
│   └── repositories
│
├── domain
│   ├── entities
│   ├── repositories
│   └── usecases
│
└── presentation
    ├── bloc
    ├── pages
    └── widgets

with proper dependency direction.

The architecture must be:

Feature-First
+
Clean Architecture
+
BLoC
+
Dependency Injection
+
Testable
+
Maintainable
+
Production Ready

==================================================
# 28. FINAL REPORT
==================================================

At the end provide:

- Total features audited
- Total ViewModels found
- Total ViewModels removed
- Total BLoCs created
- Total Events created
- Total States created
- Total Use Cases created
- Domain Entities created
- Repository interfaces created
- Repository implementations created
- Data Sources created
- Features fully migrated
- MVVM dependencies removed
- DI changes
- Navigation changes
- Testing changes
- Performance improvements
- flutter analyze result
- flutter test result
- build result
- Remaining issues

IMPORTANT:

Never claim the project is fully migrated unless you actually verified the entire project.

Never hide architecture violations.

Never leave a feature partially migrated without explicitly reporting it.

Do not stop after migrating one feature.

The final result must be a genuinely implemented:

FEATURE-FIRST
+
CLEAN ARCHITECTURE
+
BLoC

Flutter application.