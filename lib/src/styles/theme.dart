import '../widgets/widget.dart';
import '../widgets/utils/build_context.dart';
import '../widgets/inherited_widget.dart';
import '../foundation/key.dart';
import 'colors.dart';
import 'text_style.dart';

class ThemeData {
  final FlartColor primaryColor;
  final FlartColor scaffoldBackgroundColor;
  final FlartColor cardColor;
  final TextStyle textStyle;
  final FlartColor dividerColor;
  final bool isDark;

  const ThemeData({
    required this.primaryColor,
    required this.scaffoldBackgroundColor,
    required this.cardColor,
    required this.textStyle,
    required this.dividerColor,
    this.isDark = false,
  });

  factory ThemeData.light() => ThemeData(
        primaryColor: FlartColors.blue,
        scaffoldBackgroundColor: FlartColors.white,
        cardColor: FlartColors.white,
        textStyle: TextStyle(color: FlartColors.black, fontSize: 16),
        dividerColor: FlartColor('#eeeeee'),
        isDark: false,
      );

  factory ThemeData.dark() => ThemeData(
        primaryColor: FlartColors.blue,
        scaffoldBackgroundColor: FlartColor('#121212'),
        cardColor: FlartColor('#1e1e1e'),
        textStyle: TextStyle(color: FlartColors.white, fontSize: 16),
        dividerColor: FlartColor('#333333'),
        isDark: true,
      );
}

class Theme extends InheritedWidget {
  final ThemeData data;

  const Theme({
    required this.data,
    required Widget child,
    Key? key,
  }) : super(child: child, key: key);

  static ThemeData of(BuildContext context) {
    final inheritedTheme = context.dependOnInheritedWidgetOfExactType<Theme>();
    return inheritedTheme?.data ?? ThemeData.light();
  }

  @override
  bool updateShouldNotify(Theme oldWidget) => data != oldWidget.data;
}
