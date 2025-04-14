import 'dart:html';

class FlartThemeManager {
  static const _lightClass = 'flart-light';
  static const _darkClass = 'flart-dark';

  static void setTheme(String theme) {
    document.documentElement?.classes
      ?..remove(_lightClass)
      ..remove(_darkClass)
      ..add(theme == 'dark' ? _darkClass : _lightClass);
  }

  static void toggleTheme() {
    if (document.documentElement?.classes.contains(_darkClass) == true) {
      setTheme('light');
    } else {
      setTheme('dark');
    }
  }

  static void applySystemPreference() {
    final mediaQuery = window.matchMedia('(prefers-color-scheme: dark)');

    setTheme(mediaQuery.matches ? 'dark' : 'light');

    mediaQuery.addEventListener('change', (event) {
        setTheme(mediaQuery.matches ? 'dark' : 'light');
    });
  }
}


///to toggle theme
//FlartThemeManager.toggleTheme();

