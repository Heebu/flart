import '../../../flartdart.dart';

/// A circular progress indicator
class FDCircularProgressIndicator extends Widget {
  final double size;
  final double strokeWidth;
  final FlartColor? color;
  final FlartColor? backgroundColor;
  final double? value; // Optional value (0.0 to 1.0)
  final Map<String, String>? cssStyle;

  const FDCircularProgressIndicator({
    this.size = 40.0,
    this.strokeWidth = 4.0,
    this.color,
    this.backgroundColor,
    this.value,
    this.cssStyle,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final theme = Theme.of(context);
    final mainColor = color?.toString() ?? theme.primaryColor.toString();
    final bgColor =
        backgroundColor?.toString() ?? theme.dividerColor.toString();

    final styles = <String, String>{
      'width': '${size}px',
      'height': '${size}px',
      'border': '${strokeWidth}px solid $bgColor',
      'border-top-color': mainColor,
      'border-radius': '50%',
      'display': 'inline-block',
      'box-sizing': 'border-box',
      if (value == null) 'animation': 'flart-spin 1s linear infinite',
      if (value != null) 'transform': 'rotate(${value! * 360}deg)',
      ...?cssStyle,
    };

    const spinKeyframes = '''
      <style>
        @keyframes flart-spin {
          to { transform: rotate(360deg); }
        }
      </style>
    ''';

    return FlartElementNode(
      'div',
      id: key?.toString(),
      attributes: {
        'class': 'flart-circular-progress',
        'role': 'progressbar',
        if (value != null) 'aria-valuenow': '${(value! * 100).toInt()}',
      },
      styles: styles,
      children: [FlartRawHtmlNode(spinKeyframes)],
    );
  }
}

/// A linear progress indicator
class FDLinearProgressIndicator extends Widget {
  final double? value;
  final double height;
  final FlartColor? color;
  final FlartColor? backgroundColor;
  final Map<String, String>? cssStyle;

  const FDLinearProgressIndicator({
    this.value,
    this.height = 4.0,
    this.color,
    this.backgroundColor,
    this.cssStyle,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final theme = Theme.of(context);
    final mainColor = color?.toString() ?? theme.primaryColor.toString();
    final bgColor =
        backgroundColor?.toString() ?? theme.dividerColor.toString();
    final progress = value != null ? (value! * 100).clamp(0, 100) : null;

    final containerStyles = <String, String>{
      'width': '100%',
      'height': '${height}px',
      'background-color': bgColor,
      'border-radius': '${height / 2}px',
      'overflow': 'hidden',
      'position': 'relative',
      ...?cssStyle,
    };

    if (progress != null) {
      // Determinate progress
      return FlartElementNode(
        'div',
        id: key?.toString(),
        attributes: {
          'class': 'flart-linear-progress',
          'role': 'progressbar',
          'aria-valuenow': '$progress',
        },
        styles: containerStyles,
        children: [
          FlartElementNode(
            'div',
            attributes: {'class': 'flart-progress-bar'},
            styles: {
              'width': '$progress%',
              'height': '100%',
              'background-color': mainColor,
              'transition': 'width 0.3s ease',
            },
          ),
        ],
      );
    } else {
      // Indeterminate progress
      const slideKeyframes = '''
        <style>
          @keyframes flart-progress-slide {
            0% { left: -30%; width: 30%; }
            50% { width: 50%; }
            100% { left: 100%; width: 30%; }
          }
        </style>
      ''';

      return FlartElementNode(
        'div',
        id: key?.toString(),
        attributes: {
          'class': 'flart-linear-progress indeterminate',
          'role': 'progressbar',
        },
        styles: containerStyles,
        children: [
          FlartRawHtmlNode(slideKeyframes),
          FlartElementNode(
            'div',
            attributes: {'class': 'flart-progress-bar'},
            styles: {
              'position': 'absolute',
              'height': '100%',
              'background-color': mainColor,
              'animation': 'flart-progress-slide 1.5s ease-in-out infinite',
            },
          ),
        ],
      );
    }
  }
}
