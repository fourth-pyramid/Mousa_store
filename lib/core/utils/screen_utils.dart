import 'package:flutter_screenutil/flutter_screenutil.dart';

export 'package:flutter_screenutil/flutter_screenutil.dart';

/// Centralized Screen Utilities abstraction helper.
///
/// This file serves as the single source of truth for responsive screen sizing
/// across the application, decoupling feature components from any specific
/// underlying responsive package.
abstract class AppScreenUtils {
  static double get screenWidth => ScreenUtil().screenWidth;
  static double get screenHeight => ScreenUtil().screenHeight;
  static double get scaleWidth => ScreenUtil().scaleWidth;
  static double get scaleHeight => ScreenUtil().scaleHeight;
  static double get scaleText => ScreenUtil().scaleText;
  static double get statusBarHeight => ScreenUtil().statusBarHeight;
  static double get bottomBarHeight => ScreenUtil().bottomBarHeight;

  static double setWidth(num width) => width.w;
  static double setHeight(num height) => height.h;
  static double setSp(num fontSize) => fontSize.sp;
  static double radius(num radius) => radius.r;
}
