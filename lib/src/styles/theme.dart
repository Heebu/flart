import '../widgets/utils/build_context.dart';
import '../widgets/inherited_widget.dart';
import 'colors.dart';
import 'text_style.dart';

class ThemeData {
  final FlartColor primaryColor;
  final FlartColor scaffoldBackgroundColor;
  final FlartColor cardColor;
  final TextStyle textStyle;
  final FlartColor dividerColor;
  final FlartColor errorColor;
  final FlartColor successColor;
  final FlartColor warningColor;
  final FlartColor accentColor;
  final bool isDark;

  const ThemeData({
    required this.primaryColor,
    required this.scaffoldBackgroundColor,
    required this.cardColor,
    required this.textStyle,
    required this.dividerColor,
    required this.errorColor,
    required this.successColor,
    required this.warningColor,
    required this.accentColor,
    this.isDark = false,
  });

  factory ThemeData.light() => ThemeData(
        primaryColor: FlartColors.blue,
        scaffoldBackgroundColor: FlartColors.white,
        cardColor: FlartColors.white,
        textStyle: TextStyle(color: FlartColors.black, fontSize: 16),
        dividerColor: FlartColor('#eeeeee'),
        errorColor: FlartColors.red,
        successColor: FlartColors.green,
        warningColor: FlartColors.orange,
        accentColor: FlartColors.pink,
        isDark: false,
      );

  factory ThemeData.dark() => ThemeData(
        primaryColor: FlartColors.amber,
        scaffoldBackgroundColor: FlartColor('#121212'),
        cardColor: FlartColor('#1e1e1e'),
        textStyle: TextStyle(color: FlartColors.white, fontSize: 16),
        dividerColor: FlartColor('#333333'),
        errorColor: FlartColor('#cf6679'),
        successColor: FlartColor('#03dac6'),
        warningColor: FlartColor('#ffb74d'),
        accentColor: FlartColor('#03dac6'),
        isDark: true,
      );

  ThemeData copyWith({
    FlartColor? primaryColor,
    FlartColor? scaffoldBackgroundColor,
    FlartColor? cardColor,
    TextStyle? textStyle,
    FlartColor? dividerColor,
    FlartColor? errorColor,
    FlartColor? successColor,
    FlartColor? warningColor,
    FlartColor? accentColor,
    bool? isDark,
  }) {
    return ThemeData(
      primaryColor: primaryColor ?? this.primaryColor,
      scaffoldBackgroundColor:
          scaffoldBackgroundColor ?? this.scaffoldBackgroundColor,
      cardColor: cardColor ?? this.cardColor,
      textStyle: textStyle ?? this.textStyle,
      dividerColor: dividerColor ?? this.dividerColor,
      errorColor: errorColor ?? this.errorColor,
      successColor: successColor ?? this.successColor,
      warningColor: warningColor ?? this.warningColor,
      accentColor: accentColor ?? this.accentColor,
      isDark: isDark ?? this.isDark,
    );
  }
}

class Theme extends InheritedWidget {
  final ThemeData data;

  const Theme({
    required this.data,
    required super.child,
    super.key,
  });

  static ThemeData of(BuildContext context) {
    final inheritedTheme = context.dependOnInheritedWidgetOfExactType<Theme>();
    return inheritedTheme?.data ?? ThemeData.light();
  }

  @override
  bool updateShouldNotify(Theme oldWidget) => data != oldWidget.data;
}
