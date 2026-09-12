import '../../../flartdart.dart';

/// A skeleton loader widget that displays a shimmering box.
///
/// Use this as a placeholder while content is loading.
class FDSkeleton extends Widget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final EdgeInsets? margin;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDSkeleton({
    this.width,
    this.height,
    this.borderRadius,
    this.margin,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  /// Creates a circular skeleton.
  const FDSkeleton.circle({
    double? radius,
    EdgeInsets? margin,
    Map<String, String>? cssStyle,
    String? rawCss,
    Key? key,
  }) : this(
          key: key,
          width: radius != null ? radius * 2 : null,
          height: radius != null ? radius * 2 : null,
          borderRadius: const BorderRadius.all(9999),
          margin: margin,
          cssStyle: cssStyle,
          rawCss: rawCss,
        );

  @override
  FlartNode buildNode(BuildContext context) {
    final theme = Theme.of(context);

    // Background color based on theme
    final baseColor =
        theme.isDark ? 'rgba(255, 255, 255, 0.1)' : 'rgba(0, 0, 0, 0.08)';
    final highlightColor =
        theme.isDark ? 'rgba(255, 255, 255, 0.2)' : 'rgba(255, 255, 255, 0.5)';

    final styles = <String, String>{
      'display': 'inline-block',
      if (width != null) 'width': '${width}px' else 'width': '100%',
      if (height != null) 'height': '${height}px' else 'height': '1em',
      'background-color': baseColor,
      'position': 'relative',
      'overflow': 'hidden',
      'border-radius': borderRadius != null
          ? '${borderRadius!.topLeft}px ${borderRadius!.topRight}px ${borderRadius!.bottomRight}px ${borderRadius!.bottomLeft}px'
          : '4px',
      if (margin != null) 'margin': margin!.toCss(),
      ...?cssStyle,
    };

    if (rawCss != null && rawCss!.isNotEmpty) {
      final pairs = rawCss!.split(';');
      for (var pair in pairs) {
        if (pair.trim().isEmpty) continue;
        final parts = pair.split(':');
        if (parts.length >= 2) {
          styles[parts[0].trim()] = parts.sublist(1).join(':').trim();
        }
      }
    }

    final shimmerKeyframes = '''
      <style>
        .flart-skeleton .flart-shimmer {
          position: absolute;
          top: 0;
          left: -100%;
          width: 200%;
          height: 100%;
          background: linear-gradient(
            90deg, 
            transparent 0%, 
            $highlightColor 50%, 
            transparent 100%
          );
          animation: flart-shimmer-anim 1.5s infinite;
        }
        @keyframes flart-shimmer-anim {
          0% { transform: translateX(-50%); }
          100% { transform: translateX(50%); }
        }
      </style>
    ''';

    return FlartElementNode(
      'div',
      id: key?.toString(),
      attributes: {'class': 'flart-skeleton'},
      styles: styles,
      children: [
        FlartRawHtmlNode(shimmerKeyframes),
        FlartElementNode(
          'div',
          attributes: {'class': 'flart-shimmer'},
        ),
      ],
    );
  }
}
