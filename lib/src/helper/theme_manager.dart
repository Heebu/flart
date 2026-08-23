import 'package:web/web.dart';
import 'dart:js_interop';

class FlartThemeManager {
  static const _lightClass = 'flart-light';
  static const _darkClass = 'flart-dark';

  static void setTheme(String theme) {
    document.documentElement?.classList.remove(_lightClass);
    document.documentElement?.classList.remove(_darkClass);
    document.documentElement?.classList
        .add(theme == 'dark' ? _darkClass : _lightClass);
  }

  static void toggleTheme() {
    if (document.documentElement?.classList.contains(_darkClass) == true) {
      setTheme('light');
    } else {
      setTheme('dark');
    }
  }

  static void applySystemPreference() {
    final mediaQuery = window.matchMedia('(prefers-color-scheme: dark)');

    setTheme(mediaQuery.matches ? 'dark' : 'light');

    mediaQuery.addEventListener(
        'change',
        ((Event event) {
          setTheme(mediaQuery.matches ? 'dark' : 'light');
        }).toJS);
  }
}

///to toggle theme
//FlartThemeManager.toggleTheme();
