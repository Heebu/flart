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
  });

  /// Creates a circular skeleton.
  const FDSkeleton.circle({
    double? radius,
    EdgeInsets? margin,
    Map<String, String>? cssStyle,
    String? rawCss,
  }) : this(
          width: radius != null ? radius * 2 : null,
          height: radius != null ? radius * 2 : null,
          borderRadius: const BorderRadius.all(9999),
          margin: margin,
          cssStyle: cssStyle,
          rawCss: rawCss,
        );

  @override
  String render(BuildContext context) {
    final theme = Theme.of(context);
    final id = 'skeleton_${DateTime.now().microsecondsSinceEpoch}';

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

    final styleString =
        styles.entries.map((e) => '${e.key}: ${e.value};').join(' ');

    return '''
      <div id="$id" class="flart-skeleton" style="$styleString ${rawCss ?? ''}">
        <div class="flart-shimmer"></div>
      </div>
      <style>
        #$id .flart-shimmer {
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
  }
}
