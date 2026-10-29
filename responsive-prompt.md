# Flutter Responsive Architecture Migration — Remove flutter_screenutil Completely

Act as a Senior Flutter Engineer and Responsive UI Architect. Your task is to completely remove `flutter_screenutil` from the entire Flutter application and replace it with a robust, native Flutter responsive layout system.

The objective is NOT simply to remove the package. The objective is to make the entire application genuinely responsive, accessible, maintainable, and visually consistent across small phones, large phones, tablets, foldable devices, landscape layouts, and different system text scales.

## 1. Mandatory Rules

- Inspect the entire project before modifying any code.
- Follow the existing project architecture, naming conventions, design system, and established coding standards.
- Preserve all existing business logic, navigation, routing, API integrations, BLoCs, Cubits, events, states, repositories, and application behavior.
- Do not introduce another responsive UI package.
- Use Flutter and Dart native APIs exclusively for responsive layouts.
- Do not blindly replace `.w`, `.h`, `.sp`, `.r`, `.sw`, `.sh`, or other ScreenUtil extensions with hardcoded numbers.
- Do not use a global device-width scaling multiplier as a replacement for ScreenUtil.
- Do not redesign unrelated screens or modify unrelated features.
- Avoid unnecessary abstractions, excessive helper classes, duplicated logic, and premature optimization.
- Do not declare the migration complete until the entire codebase has been audited and all validation steps have been executed.

## 2. Phase 1 — Full Project Audit

Search the complete repository, including:

- `lib/`
- Shared widgets and reusable components.
- All feature modules and their views.
- Dialogs, bottom sheets, forms, and overlays.
- Navigation bars, app bars, drawers, and sidebars.
- Custom painters, charts, animations, and custom render objects.
- Themes, design tokens, constants, and utility classes.
- Tests, widget tests, integration tests, and relevant configuration files.

Identify every usage of:

- `flutter_screenutil`
- `ScreenUtilInit`
- `ScreenUtil`
- `.w`, `.h`, `.sp`, `.r`, `.sw`, `.sh`
- `ScreenUtil().screenWidth` and `ScreenUtil().screenHeight`
- Any other ScreenUtil extension, import, initialization, or indirect dependency on its behavior.

Produce an audit report containing:
1. Every affected file and usage.
2. The current purpose of each responsive value.
3. Whether the value represents spacing, dimensions, typography, radius, icon size, or layout behavior.
4. The proposed native Flutter replacement.
5. Potential layout and regression risks.

Do not modify files until the audit is complete.

## 3. Phase 2 — Establish Responsive Design Principles

Implement a consistent responsive strategy using native Flutter APIs.

### A. Available-space-based layouts

Use `LayoutBuilder` whenever a component's layout should depend on its actual available constraints.

Prefer:
- `Expanded` and `Flexible` for distributing remaining space.
- `Wrap` for content that should flow onto additional lines.
- `AspectRatio` for elements that must preserve their proportions.
- `ConstrainedBox` and `SizedBox` for explicit size constraints.
- `FractionallySizedBox` when proportional sizing is appropriate.
- `SingleChildScrollView` or suitable scrollable widgets when content may exceed available space.
- `Sliver` widgets for complex scrolling layouts where appropriate.

Never combine `Expanded` with an unbounded main-axis constraint without addressing the underlying layout problem.

### B. Breakpoints

Create a centralized, project-appropriate responsive breakpoint system using native Flutter functionality.

Use these initial design guidelines as starting points, not universal hardcoded rules:

- Compact phone: width below 360 logical pixels.
- Standard phone: width from 360 to below 600.
- Tablet: width from 600 to below 840.
- Expanded layout: width of 840 and above.

Use `LayoutBuilder` constraints for component-level breakpoints and `MediaQuery.sizeOf(context)` for screen-level decisions.

Determine breakpoints based on actual content requirements and test results. Do not classify every device solely by its physical model or orientation.

Support portrait and landscape orientations.

### C. Responsive layout behavior

Where appropriate:
- Switch between single-column and multi-column layouts.
- Limit content width on tablets and large screens.
- Center content when excessive horizontal space is available.
- Adapt navigation patterns when the layout has enough space.
- Use grids with an appropriate number of columns and a controlled aspect ratio.
- Prevent cards, forms, dialogs, and buttons from stretching beyond reasonable design limits.
- Respect safe areas, keyboard insets, system bars, and display cutouts.

Do not force every screen to use a different layout. Preserve the existing design whenever its layout already adapts correctly.

## 4. Phase 3 — Replace ScreenUtil Usage Correctly

Replace each usage according to its actual design intent.

### Spacing and padding

Replace scaled spacing values with deliberate, consistent spacing tokens or fixed logical-pixel values where appropriate.

Prefer reusable spacing constants for recurring design-system values.

Do not multiply every padding value by screen width or height.

### Width and height

Replace arbitrary scaled widths and heights with:
- Content-driven sizing.
- `Expanded` or `Flexible`.
- Constraints and maximum widths.
- `AspectRatio` for proportion-based components.
- Explicit dimensions only when they are genuinely required.

Preserve intentional fixed dimensions for small controls, borders, and other components whose design requires them.

### Typography

Remove all ScreenUtil-dependent font sizing.

Use native Flutter text styling and a coherent typography scale.

Ensure text can wrap correctly and does not overflow in:
- Arabic and RTL layouts.
- English and LTR layouts.
- Long localized strings.
- Large system text settings.
- Small screens and landscape mode.

Respect Flutter's text scaling and accessibility behavior. Do not disable or arbitrarily cap user-selected text scaling to hide layout problems.

### Border radius and icons

Replace `.r` and other dimension extensions with appropriate native logical-pixel values or centralized design tokens.

Do not automatically scale icon sizes based on device width. Maintain appropriate visual proportions and usable touch targets.

### Screen dimensions

Replace ScreenUtil screen-size access with appropriate native APIs.

Use `MediaQuery.sizeOf(context)` for the current view's size where appropriate, and `LayoutBuilder` when actual parent constraints matter more than the overall screen dimensions.

Account for split-screen windows and resizable application windows.

### Orientation and unusual aspect ratios

Remove assumptions that every screen has a fixed portrait aspect ratio.

Avoid using screen height as the primary determinant of vertical spacing. Prefer content-driven layouts and scrolling where necessary.

## 5. Phase 4 — Shared Responsive Infrastructure

If justified by the existing architecture, introduce a small and maintainable responsive utility layer.

Potential components include:
- A centralized breakpoint definition.
- A lightweight responsive layout helper.
- Shared spacing and typography tokens.
- A reusable maximum-content-width constraint.
- Shared responsive grid or page-layout helpers where repeated patterns exist.

Requirements:
- Use native Flutter APIs only.
- Keep the implementation minimal.
- Do not recreate the entire ScreenUtil API.
- Do not introduce generic abstractions that obscure ordinary Flutter layout code.
- Do not use global mutable screen dimensions.
- Do not cache device dimensions in static variables.
- Do not create unnecessary `BuildContext` extensions for every possible dimension.
- Keep component-level responsive decisions close to the layouts they affect.
- Preserve the existing design system rather than introducing conflicting tokens.

If the project already contains suitable design tokens or responsive helpers, extend them instead of creating duplicate infrastructure.

## 6. Phase 5 — Feature-by-Feature Migration

Migrate the application systematically, feature by feature.

For every affected screen:
1. Inspect the existing layout and identify its design intent.
2. Replace ScreenUtil-dependent sizing with an appropriate native layout strategy.
3. Preserve the original visual hierarchy, colors, typography, spacing, and interactions wherever possible.
4. Fix actual overflow, clipping, and excessive empty-space issues.
5. Verify scrolling and keyboard behavior.
6. Verify Arabic RTL and English LTR layouts where localization is supported.
7. Check dialogs, bottom sheets, forms, cards, and shared widgets.
8. Ensure changes to shared components do not break unrelated screens.
9. Run relevant analysis and tests incrementally.
10. Record completed files and remaining issues.

Do not perform a blind project-wide search-and-replace operation.

Do not stop after migrating a few representative screens. Audit and migrate every actual ScreenUtil usage throughout the project.

## 7. Phase 6 — Performance and Accessibility

Responsive behavior must not introduce unnecessary rebuilds or layout complexity.

Requirements:
- Keep widget trees understandable and reasonably small.
- Avoid unnecessary nested `LayoutBuilder` widgets.
- Avoid redundant `MediaQuery` lookups and duplicated responsive calculations when a parent constraint already provides the required information.
- Preserve existing state-management boundaries.
- Do not move application business logic into responsive widgets.
- Use `const` constructors where appropriate.
- Avoid expensive work inside `build()`.
- Preserve list laziness and existing rendering optimizations.
- Ensure interactive controls have appropriate touch targets.
- Preserve semantic labels and keyboard accessibility.
- Respect text scaling and system accessibility settings.
- Ensure scrollable content remains accessible on compact displays.

Do not claim performance improvements without evidence. Validate meaningful performance concerns using Flutter DevTools or suitable profiling where necessary.

## 8. Phase 7 — Remove the Dependency Completely

After all usages have been migrated:

- Remove `flutter_screenutil` from `pubspec.yaml`.
- Remove all ScreenUtil imports.
- Remove `ScreenUtilInit` and obsolete initialization configuration.
- Remove ScreenUtil-specific code from `main.dart` and application bootstrap files.
- Remove obsolete ScreenUtil-only helpers and configuration.
- Update tests and fixtures that rely on ScreenUtil initialization.
- Update lockfiles through the project's package manager.
- Search the entire repository again for every ScreenUtil API and extension.
- Verify no remaining source file depends on ScreenUtil.
- Check whether another dependency introduces it transitively before claiming that the package is entirely absent from the dependency graph.

Do not remove unrelated dependencies.

## 9. Phase 8 — Responsive Testing Matrix

Validate the application using Flutter widget tests, existing integration tests, and actual device or emulator testing where available.

At minimum, cover these logical viewport sizes:

- 320 × 568 — compact phone.
- 360 × 800 — small phone.
- 390 × 844 — standard phone.
- 430 × 932 — large phone.
- 600 × 960 — compact tablet boundary.
- 768 × 1024 — tablet.
- 1024 × 768 — landscape tablet.
- 1280 × 800 — expanded layout.

Also test:
- Portrait and landscape.
- Large system text scaling, including approximately 1.3× and 2.0× where the UI can reasonably support it.
- Arabic RTL and English LTR if localization is supported.
- Long text and translated labels.
- Keyboard visibility and form interaction.
- Dialogs and bottom sheets.
- Empty, loading, error, and populated states.
- Resizing and split-screen behavior where supported.

These are logical test sizes, not guarantees about physical device screen dimensions.

Detect layout exceptions, overflow errors, clipped content, inaccessible controls, and broken scrolling. Fix the underlying layout instead of hiding overflow indicators or disabling accessibility.

## 10. Phase 9 — Validation and Regression Checks

Execute the available project validation commands, adapting them to the existing repository and Flutter SDK:

- `flutter pub get`
- `dart format --output=none --set-exit-if-changed lib test`
- `flutter analyze`
- `flutter test`

Run additional targeted widget or integration tests when available.

If a command fails:
- Investigate the actual cause.
- Fix issues introduced by the migration.
- Clearly distinguish pre-existing failures from newly introduced failures.
- Never report a successful command that was not executed.
- Never suppress analyzer errors or tests merely to make the migration pass.

Build the relevant application targets if the environment and project configuration allow it.

## 11. Phase 10 — Final Audit Report

Provide a concise but complete report containing:

1. The number of files audited and migrated.
2. All ScreenUtil APIs and initialization code removed.
3. The responsive infrastructure added or reused.
4. The major layout changes and their rationale.
5. The screens tested and viewport sizes covered.
6. Formatting, analysis, test, and build results.
7. Any remaining issues or unverified behavior.
8. Confirmation of whether `flutter_screenutil` is absent from direct dependencies, source imports, and the resolved dependency graph.

## Definition of Done

The task is complete only when:

- The entire application has been audited.
- All actual ScreenUtil usages have been migrated.
- No responsive behavior depends on `flutter_screenutil`.
- The dependency has been removed.
- The application retains its existing functionality and design intent.
- Small phones, standard phones, large phones, tablets, landscape layouts, and text scaling are handled appropriately.
- RTL and LTR layouts remain correct where applicable.
- Relevant static analysis and tests have been executed and their actual results reported.
- No known migration-introduced overflow or layout regression remains in the tested scenarios.
- Any remaining limitations are explicitly documented.

Execute this work in sequential phases. Finish and validate each phase before proceeding to the next. Maintain a migration checklist, inspect actual source files, and make the code changes directly rather than returning recommendations alone.