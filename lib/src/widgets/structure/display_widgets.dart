import '../../../flartdart.dart';

typedef AspectRatio = FDAspectRatio;
typedef ClipRRect = FDClipRRect;
typedef ClipOval = FDClipOval;
typedef Opacity = FDOpacity;
typedef FittedBox = FDFittedBox;
typedef RotatedBox = FDRotatedBox;
typedef Placeholder = FDPlaceholder;
typedef CircleAvatar = FDCircleAvatar;

/// A widget that attempts to size the child to a specific aspect ratio.
class FDAspectRatio extends Widget {
  final double aspectRatio;
  final Widget? child;

  const FDAspectRatio({
    required this.aspectRatio,
    this.child,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    return FlartElementNode(
      'div',
      id: key?.toString(),
      attributes: {'class': 'flart-aspect-ratio'},
      styles: {
        'box-sizing': 'border-box',
        'aspect-ratio': aspectRatio.toString(),
        'width': '100%',
        'max-width': '100%',
        'display': 'flex',
        'position': 'relative',
        'align-items': 'stretch',
        'justify-content': 'stretch',
      },
      children: child != null ? [child!.buildNode(context)] : null,
    );
  }
}

/// A widget that clips its child using a rounded rectangle.
class FDClipRRect extends Widget {
  final BorderRadius borderRadius;
  final Widget? child;
  final Clip clipBehavior;

  const FDClipRRect({
    this.borderRadius = BorderRadius.zero,
    this.child,
    this.clipBehavior = Clip.antiAlias,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final isClipped = clipBehavior != Clip.none;
    return FlartElementNode(
      'div',
      id: key?.toString(),
      attributes: {'class': 'flart-clip-rrect'},
      styles: {
        'box-sizing': 'border-box',
        'border-radius': borderRadius.toCss(),
        'overflow': isClipped ? 'hidden' : 'visible',
        'display': 'block',
        if (clipBehavior == Clip.antiAlias) 'isolation': 'isolate',
      },
      children: child != null ? [child!.buildNode(context)] : null,
    );
  }
}

/// A widget that clips its child using an oval.
class FDClipOval extends Widget {
  final Widget? child;
  final Clip clipBehavior;

  const FDClipOval({
    this.child,
    this.clipBehavior = Clip.antiAlias,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final isClipped = clipBehavior != Clip.none;
    return FlartElementNode(
      'div',
      id: key?.toString(),
      attributes: {'class': 'flart-clip-oval'},
      styles: {
        'box-sizing': 'border-box',
        'border-radius': '50%',
        'overflow': isClipped ? 'hidden' : 'visible',
        'display': 'block',
        if (clipBehavior == Clip.antiAlias) 'isolation': 'isolate',
      },
      children: child != null ? [child!.buildNode(context)] : null,
    );
  }
}

/// A widget that makes its child partially transparent.
class FDOpacity extends Widget {
  final double opacity;
  final bool alwaysIncludeSemantics;
  final Widget? child;

  const FDOpacity({
    required this.opacity,
    this.alwaysIncludeSemantics = false,
    this.child,
    super.key,
  }) : assert(opacity >= 0.0 && opacity <= 1.0);

  @override
  FlartNode buildNode(BuildContext context) {
    return FlartElementNode(
      'div',
      id: key?.toString(),
      attributes: {'class': 'flart-opacity'},
      styles: {
        'box-sizing': 'border-box',
        'opacity': opacity.toString(),
        if (opacity == 0.0) 'pointer-events': 'none',
        'transition': 'opacity 0.2s',
      },
      children: child != null ? [child!.buildNode(context)] : null,
    );
  }
}

/// Scales and positions its child within itself according to [fit].
class FDFittedBox extends Widget {
  final BoxFit fit;
  final Alignment alignment;
  final Clip clipBehavior;
  final Widget? child;

  const FDFittedBox({
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.clipBehavior = Clip.none,
    this.child,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    return FlartElementNode(
      'div',
      id: key?.toString(),
      attributes: {'class': 'flart-fitted-box'},
      styles: {
        'box-sizing': 'border-box',
        'display': 'flex',
        'justify-content': alignment.justifyContent,
        'align-items': alignment.alignItems,
        'width': '100%',
        'height': '100%',
        'overflow': clipBehavior == Clip.none ? 'visible' : 'hidden',
      },
      children: child != null ? [child!.buildNode(context)] : null,
    );
  }
}

/// A widget that rotates its child by a integral number of quarter turns.
class FDRotatedBox extends Widget {
  final int quarterTurns;
  final Widget? child;

  const FDRotatedBox({
    required this.quarterTurns,
    this.child,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final degrees = (quarterTurns % 4) * 90;

    return FlartElementNode(
      'div',
      id: key?.toString(),
      attributes: {'class': 'flart-rotated-box'},
      styles: {
        'box-sizing': 'border-box',
        'display': 'inline-block',
        'transform': 'rotate(${degrees}deg)',
        'transform-origin': 'center center',
      },
      children: child != null ? [child!.buildNode(context)] : null,
    );
  }
}

/// A widget that draws a box that represents where other widgets will one day be added.
class FDPlaceholder extends Widget {
  final FlartColor color;
  final double strokeWidth;
  final double fallbackWidth;
  final double fallbackHeight;
  final Widget? child;

  const FDPlaceholder({
    this.color = const FlartColor('#455A64'),
    this.strokeWidth = 2.0,
    this.fallbackWidth = 400.0,
    this.fallbackHeight = 400.0,
    this.child,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final c = color.toString();
    final svg = '''
      <svg width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" style="display: block;">
        <rect width="100%" height="100%" fill="none" stroke="$c" stroke-width="${strokeWidth * 2}" />
        <line x1="0" y1="0" x2="100%" y2="100%" stroke="$c" stroke-width="$strokeWidth" />
        <line x1="100%" y1="0" x2="0" y2="100%" stroke="$c" stroke-width="$strokeWidth" />
      </svg>
    ''';

    return FlartElementNode(
      'div',
      id: key?.toString(),
      attributes: {'class': 'flart-placeholder'},
      styles: {
        'box-sizing': 'border-box',
        'position': 'relative',
        'width': '${fallbackWidth}px',
        'height': '${fallbackHeight}px',
        'background-color': 'rgba(0, 0, 0, 0.05)',
      },
      children: [
        FlartRawHtmlNode(svg),
        if (child != null)
          FlartElementNode(
            'div',
            styles: {
              'position': 'absolute',
              'top': '0',
              'left': '0',
              'width': '100%',
              'height': '100%',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
            },
            children: [child!.buildNode(context)],
          ),
      ],
    );
  }
}

/// A circular avatar representing a user, icon, or placeholder image.
class FDCircleAvatar extends Widget {
  final Widget? child;
  final FlartColor? backgroundColor;
  final FlartColor? foregroundColor;
  final double radius;
  final String? backgroundImage;

  const FDCircleAvatar({
    this.child,
    this.backgroundColor,
    this.foregroundColor,
    this.radius = 20.0,
    this.backgroundImage,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final size = radius * 2;
    final bg = backgroundColor ?? const FlartColor('#94a3b8');
    final fg = foregroundColor ?? FlartColors.white;

    final styles = <String, String>{
      'box-sizing': 'border-box',
      'width': '${size}px',
      'height': '${size}px',
      'border-radius': '50%',
      'background-color': bg.toString(),
      'color': fg.toString(),
      'display': 'inline-flex',
      'align-items': 'center',
      'justify-content': 'center',
      'overflow': 'hidden',
      'user-select': 'none',
      if (backgroundImage != null) ...{
        'background-image': 'url($backgroundImage)',
        'background-size': 'cover',
        'background-position': 'center',
      },
    };

    return FlartElementNode(
      'div',
      id: key?.toString(),
      attributes: {'class': 'flart-circle-avatar'},
      styles: styles,
      children: child != null ? [child!.buildNode(context)] : null,
    );
  }
}
