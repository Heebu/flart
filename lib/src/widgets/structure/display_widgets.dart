import '../../../flartdart.dart';

typedef AspectRatio = FDAspectRatio;
typedef ClipRRect = FDClipRRect;
typedef ClipOval = FDClipOval;
typedef Opacity = FDOpacity;
typedef FittedBox = FDFittedBox;
typedef RotatedBox = FDRotatedBox;
typedef Placeholder = FDPlaceholder;

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
        'aspect-ratio': aspectRatio.toString(),
        'width': '100%',
        'display': 'flex',
        'position': 'relative',
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
    return FlartElementNode(
      'div',
      id: key?.toString(),
      attributes: {'class': 'flart-clip-rrect'},
      styles: {
        'border-radius': borderRadius.toCss(),
        'overflow': 'hidden',
        'display': 'inline-block',
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
    return FlartElementNode(
      'div',
      id: key?.toString(),
      attributes: {'class': 'flart-clip-oval'},
      styles: {
        'border-radius': '50%',
        'overflow': 'hidden',
        'display': 'inline-block',
      },
      children: child != null ? [child!.buildNode(context)] : null,
    );
  }
}

/// A widget that makes its child partially transparent.
class FDOpacity extends Widget {
  final double opacity;
  final Widget? child;

  const FDOpacity({
    required this.opacity,
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
        'opacity': opacity.toString(),
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
  final Widget? child;

  const FDFittedBox({
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
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
        'display': 'flex',
        'justify-content': alignment.justifyContent,
        'align-items': alignment.alignItems,
        'width': '100%',
        'height': '100%',
        'overflow': 'hidden',
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

  const FDPlaceholder({
    this.color = const FlartColor('#455A64'),
    this.strokeWidth = 2.0,
    this.fallbackWidth = 400.0,
    this.fallbackHeight = 400.0,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final c = color.toString();
    // Using an embedded SVG for crisp diagonal lines
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
        'width': '${fallbackWidth}px',
        'height': '${fallbackHeight}px',
        'background-color': 'rgba(0, 0, 0, 0.05)',
        'box-sizing': 'border-box',
      },
      children: [FlartRawHtmlNode(svg)],
    );
  }
}
