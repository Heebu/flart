import 'media_query.dart';

/// A utility class for responsive design, similar to flutter_screenutil.
class ScreenUtil {
  static final ScreenUtil _instance = ScreenUtil._internal();
  factory ScreenUtil() => _instance;
  ScreenUtil._internal();

  static double _designWidth = 1440;
  static double _designHeight = 900;

  /// Initializes the ScreenUtil with design dimensions.
  /// Default is 1440x900 (typical desktop size).
  static void init({double width = 1440, double height = 900}) {
    _designWidth = width;
    _designHeight = height;
  }

  /// The horizontal scale factor
  static double get scaleWidth => MediaQuery.of().width / _designWidth;

  /// The vertical scale factor
  static double get scaleHeight => MediaQuery.of().height / _designHeight;

  /// The text scale factor (defaults to width scale)
  static double get scaleText => scaleWidth;
}

/// Extensions on [num] to provide responsive sizing utilities.
extension ResponsiveExtensions on num {
  /// Adapts the value to the screen width based on design size.
  /// Example: 10.w
  double get w => this * ScreenUtil.scaleWidth;

  /// Adapts the value to the screen height based on design size.
  /// Example: 20.h
  double get h => this * ScreenUtil.scaleHeight;

  /// Adapts the value for font sizes.
  /// Example: 16.sp
  double get sp => this * ScreenUtil.scaleText;

  /// Returns a percentage of the screen width.
  /// Example: 50.sw (50% of screen width)
  double get sw => (this / 100) * MediaQuery.of().width;

  /// Returns a percentage of the screen height.
  /// Example: 50.sh (50% of screen height)
  double get sh => (this / 100) * MediaQuery.of().height;
}
