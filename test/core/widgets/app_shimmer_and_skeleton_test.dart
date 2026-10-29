import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mousa_store/core/widgets/app_shimmer.dart';
import 'package:mousa_store/core/widgets/app_skeleton.dart';

Widget _buildTestWidget(Widget child) => MaterialApp(
  home: Scaffold(body: Center(child: child)),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppShimmer and AppSkeleton Widget Tests', () {
    testWidgets('AppShimmer renders child correctly', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(const AppShimmer(child: Text('Loading Placeholder'))),
      );
      await tester.pump();

      expect(find.text('Loading Placeholder'), findsOneWidget);
      expect(find.byType(ShaderMask), findsOneWidget);
    });

    testWidgets('AppSkeletonCard renders without layout overflow', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestWidget(
          const SizedBox(width: 180, height: 250, child: AppSkeletonCard()),
        ),
      );
      await tester.pump();

      expect(find.byType(AppSkeletonCard), findsOneWidget);
      expect(find.byType(AppShimmer), findsOneWidget);
    });

    testWidgets('AppSkeletonGrid renders grid of skeleton cards', (
      tester,
    ) async {
      await tester.pumpWidget(
        _buildTestWidget(
          const SizedBox(
            width: 375,
            height: 600,
            child: AppSkeletonGrid(itemCount: 4),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(AppSkeletonCard), findsNWidgets(4));
    });

    testWidgets('AppSkeletonBox renders with given dimensions', (tester) async {
      await tester.pumpWidget(
        _buildTestWidget(const AppSkeletonBox(width: 80, height: 20)),
      );
      await tester.pump();

      final boxFinder = find.byType(Container);
      expect(boxFinder, findsWidgets);
    });
  });
}
