import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mousa_store/core/design_system/app_sizes.dart';
import 'package:mousa_store/core/design_system/app_spacing.dart';
import 'package:mousa_store/core/utils/aspect_ratio_calculator.dart';
import 'package:mousa_store/core/utils/screen_utils.dart';
import 'package:mousa_store/core/widgets/app_bottom_sheet.dart';
import 'package:mousa_store/core/widgets/app_empty_state.dart';
import 'package:mousa_store/core/widgets/app_otp_field.dart';
import 'package:mousa_store/core/widgets/app_page_indicator.dart';
import 'package:mousa_store/core/widgets/app_sliver_grid.dart';
import 'package:mousa_store/core/widgets/custom_button.dart';
import 'package:mousa_store/l10n/app_localizations.dart';

class _ViewportSpec {
  const _ViewportSpec(this.name, this.size, {required this.expectedColumns});

  final String name;
  final Size size;
  final int expectedColumns;
}

const List<_ViewportSpec> _viewportMatrix = <_ViewportSpec>[
  _ViewportSpec('Small Phone (320x568)', Size(320, 568), expectedColumns: 2),
  _ViewportSpec(
    'Standard Android (360x800)',
    Size(360, 800),
    expectedColumns: 2,
  ),
  _ViewportSpec(
    'Standard iPhone (390x844)',
    Size(390, 844),
    expectedColumns: 2,
  ),
  _ViewportSpec('Large Phone (430x932)', Size(430, 932), expectedColumns: 2),
  _ViewportSpec('Small Tablet (600x960)', Size(600, 960), expectedColumns: 3),
  _ViewportSpec('Large Tablet (768x1024)', Size(768, 1024), expectedColumns: 3),
  _ViewportSpec(
    'Tablet Landscape (1024x768)',
    Size(1024, 768),
    expectedColumns: 4,
  ),
  _ViewportSpec(
    'Expanded Desktop (1280x800)',
    Size(1280, 800),
    expectedColumns: 4,
  ),
];

Widget _buildResponsiveHarness({
  required Size size,
  required double textScaleFactor,
  required Locale locale,
  required Widget child,
}) => MediaQuery(
  data: MediaQueryData(
    size: size,
    textScaler: TextScaler.linear(textScaleFactor),
  ),
  child: MaterialApp(
    locale: locale,
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    home: Scaffold(body: SafeArea(child: child)),
  ),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Responsive Breakpoints & AspectRatioCalculator Unit Tests', () {
    test('AppScreenUtils.adaptiveGridColumns scales across breakpoints', () {
      for (final spec in _viewportMatrix) {
        expect(
          AppScreenUtils.adaptiveGridColumns(spec.size.width),
          spec.expectedColumns,
          reason: 'Unexpected column count for ${spec.name}',
        );
      }
    });

    test(
      'aspectRatioCalculator computes logical aspect ratio from constraints',
      () {
        final phoneRatio = aspectRatioCalculator(
          const BoxConstraints(maxWidth: 390),
        );
        final tabletRatio = aspectRatioCalculator(
          const BoxConstraints(maxWidth: 768),
          crossAxisCount: 3,
        );

        expect(phoneRatio, greaterThan(0.5));
        expect(tabletRatio, greaterThan(phoneRatio));
        expect(
          itemHeightCalculator(const BoxConstraints(maxWidth: 390)),
          equals(200.0),
        );
      },
    );

    test(
      'AppSizes interactive touch targets meet >= 48dp accessibility minimum',
      () {
        expect(AppSizes.minTouchTarget, greaterThanOrEqualTo(48.0));
        expect(AppSizes.buttonHeight, greaterThanOrEqualTo(48.0));
        expect(AppSizes.inputHeight, greaterThanOrEqualTo(48.0));
        expect(AppSizes.searchBarHeight, greaterThanOrEqualTo(48.0));
      },
    );
  });

  group('Phase 8 Viewport, Text Scale (1.0x, 1.3x, 2.0x) & RTL/LTR Matrix', () {
    for (final viewport in _viewportMatrix) {
      for (final scale in const <double>[1.0, 1.3, 2.0]) {
        for (final locale in const <Locale>[Locale('en'), Locale('ar')]) {
          testWidgets(
            'renders responsive layout without overflow on ${viewport.name} '
            'at ${scale}x text scale (${locale.languageCode})',
            (tester) async {
              tester.view.physicalSize = viewport.size;
              tester.view.devicePixelRatio = 1.0;
              addTearDown(() {
                tester.view.resetPhysicalSize();
                tester.view.resetDevicePixelRatio();
              });

              final otpController = TextEditingController();
              addTearDown(otpController.dispose);

              await tester.pumpWidget(
                _buildResponsiveHarness(
                  size: viewport.size,
                  textScaleFactor: scale,
                  locale: locale,
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: ResponsiveConstrainedBox(
                          maxWidth: AppBreakpoints.maxFormWidth,
                          child: Padding(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                AppButton(
                                  text: locale.languageCode == 'ar'
                                      ? 'إتمام عملية الشراء الآن'
                                      : 'Complete Checkout Now',
                                  icon: const Icon(Icons.shopping_bag_outlined),
                                  onPressed: () {},
                                ),
                                const SizedBox(height: AppSpacing.md),
                                AppOtpField(
                                  controller: otpController,
                                  onCompleted: (_) {},
                                ),
                                const SizedBox(height: AppSpacing.md),
                                const Center(
                                  child: AppExpandingDotsIndicator(
                                    count: 4,
                                    activeIndex: 1,
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.md),
                                AppEmptyState(
                                  icon: Icons.inventory_2_outlined,
                                  title: locale.languageCode == 'ar'
                                      ? 'لا توجد منتجات متاحة حالياً'
                                      : 'No Products Available Currently',
                                  description: locale.languageCode == 'ar'
                                      ? 'جرّب تغيير الفلاتر أو البحث بكلمات أخرى'
                                      : 'Try adjusting your filters or searching again',
                                  actionLabel: locale.languageCode == 'ar'
                                      ? 'تحديث الصفحة'
                                      : 'Refresh Page',
                                  onActionTap: () {},
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                        ),
                        sliver: AppSliverGrid<int>(
                          items: const <int>[0, 1, 2, 3],
                          isLoading: false,
                          itemBuilder: (context, item, index) => Card(
                            child: Padding(
                              padding: const EdgeInsets.all(AppSpacing.sm),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Expanded(
                                    child: Center(
                                      child: Icon(Icons.image_outlined),
                                    ),
                                  ),
                                  Text(
                                    locale.languageCode == 'ar'
                                        ? 'منتج تجريبي رقم $item بوصف طويل للتجربة'
                                        : 'Sample Product #$item With Long Title',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );

              await tester.pump(const Duration(milliseconds: 500));

              expect(tester.takeException(), isNull);
              expect(find.byType(AppButton), findsWidgets);
              expect(find.byType(AppOtpField), findsOneWidget);
              expect(find.byType(AppEmptyState), findsOneWidget);
            },
          );
        }
      }
    }

    testWidgets(
      'AppBottomSheet constrains width on tablet (768x1024) at 2.0x text scale',
      (tester) async {
        const tabletSize = Size(768, 1024);
        tester.view.physicalSize = tabletSize;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        await tester.pumpWidget(
          _buildResponsiveHarness(
            size: tabletSize,
            textScaleFactor: 2.0,
            locale: const Locale('ar'),
            child: const AppBottomSheet(
              title: 'تفاصيل التصفية والترتيب المتقدمة للمنتجات',
              child: Text('محتوى النافذة المنبثقة'),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
        final sheetBox = tester.getSize(find.byType(AppBottomSheet));
        expect(sheetBox.width, lessThanOrEqualTo(AppBreakpoints.maxSheetWidth));
      },
    );
  });
}
