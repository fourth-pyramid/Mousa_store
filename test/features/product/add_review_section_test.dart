import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mousa_store/core/di/locator.dart';
import 'package:mousa_store/core/service/auth_service.dart';
import 'package:mousa_store/core/utils/screen_utils.dart';
import 'package:mousa_store/core/widgets/custom_button.dart';
import 'package:mousa_store/core/widgets/custom_form_field.dart';
import 'package:mousa_store/features/product/domain/usecases/product_use_cases.dart';
import 'package:mousa_store/features/product/presentation/bloc/review_bloc.dart';
import 'package:mousa_store/features/product/presentation/widgets/add_review_section.dart';
import 'package:mousa_store/l10n/app_localizations.dart';

class MockAddReviewUseCase extends Mock implements AddReviewUseCase {}
class MockAuthService extends Mock implements AuthService {}

Widget _buildTestWidget({required ReviewBloc reviewBloc}) => ScreenUtilInit(
  designSize: const Size(375, 812),
  builder: (_, _) => BlocProvider<ReviewBloc>.value(
    value: reviewBloc,
    child: const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale('en'),
      home: Scaffold(
        body: SingleChildScrollView(
          child: AddReviewSection(productId: 10),
        ),
      ),
    ),
  ),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockAddReviewUseCase mockAddReviewUseCase;
  late MockAuthService mockAuthService;
  late ReviewBloc reviewBloc;

  setUp(() async {
    mockAddReviewUseCase = MockAddReviewUseCase();
    mockAuthService = MockAuthService();
    reviewBloc = ReviewBloc(addReviewUseCase: mockAddReviewUseCase);

    if (getIt.isRegistered<AuthService>()) {
      await getIt.unregister<AuthService>();
    }
    getIt.registerSingleton<AuthService>(mockAuthService);
    when(() => mockAuthService.isLoggedIn).thenReturn(true);
  });

  tearDown(() async {
    await reviewBloc.close();
    if (getIt.isRegistered<AuthService>()) {
      await getIt.unregister<AuthService>();
    }
  });

  group('AddReviewSection Widget Tests', () {
    testWidgets('button is disabled when no rating and no comment', (tester) async {
      await tester.pumpWidget(_buildTestWidget(reviewBloc: reviewBloc));
      await tester.pumpAndSettle();

      final button = tester.widget<AppButton>(find.byType(AppButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('button remains disabled when only star rating is chosen', (tester) async {
      await tester.pumpWidget(_buildTestWidget(reviewBloc: reviewBloc));
      await tester.pumpAndSettle();

      // Tap 5th star
      final starIcons = find.byIcon(Icons.star_border);
      expect(starIcons, findsNWidgets(5));
      await tester.tap(starIcons.at(4));
      await tester.pumpAndSettle();

      final button = tester.widget<AppButton>(find.byType(AppButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('button remains disabled when only comment is entered', (tester) async {
      await tester.pumpWidget(_buildTestWidget(reviewBloc: reviewBloc));
      await tester.pumpAndSettle();

      // Enter comment text without selecting stars
      await tester.enterText(find.byType(CustomFormField), 'Nice product');
      await tester.pumpAndSettle();

      final button = tester.widget<AppButton>(find.byType(AppButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('button is enabled when both star rating is chosen and comment is entered', (tester) async {
      await tester.pumpWidget(_buildTestWidget(reviewBloc: reviewBloc));
      await tester.pumpAndSettle();

      // Tap 5th star
      final starIcons = find.byIcon(Icons.star_border);
      await tester.tap(starIcons.at(4));
      await tester.pumpAndSettle();

      // Enter comment text
      await tester.enterText(find.byType(CustomFormField), 'Awesome phone!');
      await tester.pumpAndSettle();

      final button = tester.widget<AppButton>(find.byType(AppButton));
      expect(button.onPressed, isNotNull);
    });

    testWidgets('comment focusNode has skipTraversal enabled by default', (tester) async {
      await tester.pumpWidget(_buildTestWidget(reviewBloc: reviewBloc));
      await tester.pumpAndSettle();

      final formField = tester.widget<CustomFormField>(find.byType(CustomFormField));
      final focusNode = formField.focusNode!;
      expect(focusNode.hasFocus, isFalse);
      expect(focusNode.skipTraversal, isTrue);
    });
  });
}
