import '../../../flartdart.dart';

typedef Image = FDImage;

enum ImageLoading {
  eager,
  lazy,
}

class FDImage extends Widget {
  final String src;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Alignment? alignment;
  final BorderRadius? borderRadius;
  final FlartColor? color;
  final Map<String, String>? cssStyle;
  final String? alt;
  final ImageLoading loading;
  final String? rawCss;

  FDImage.network(
    String? src, {
    this.width,
    this.height,
    this.fit,
    this.alignment,
    this.borderRadius,
    this.color,
    this.cssStyle,
    this.alt,
    this.loading = ImageLoading.lazy,
    this.rawCss,
    super.key,
  }) : src = (src == null || src.isEmpty)
            ? '/assets/flart_logo_with_text.png'
            : src;

  FDImage.asset(
    String? assetPath, {
    this.width,
    this.height,
    this.fit,
    this.alignment,
    this.borderRadius,
    this.color,
    this.cssStyle,
    this.alt,
    this.loading = ImageLoading.lazy,
    this.rawCss,
    super.key,
  }) : src = (assetPath == null || assetPath.isEmpty)
            ? '/assets/flart_logo_with_text.png'
            : '/$assetPath';

  @override
  FlartNode buildNode(BuildContext context) {
    final styleMap = <String, String>{
      'box-sizing': 'border-box',
      'display': 'inline-block',
      if (width != null) 'width': '${width}px',
      if (height != null) 'height': '${height}px',
      if (fit != null) 'object-fit': _boxFitToCss(fit!),
      if (alignment != null) 'object-position': _alignmentToCss(alignment!),
      if (borderRadius != null) ...{
        'border-radius': borderRadius!.toCss(),
        'overflow': 'hidden',
      },
      if (color != null) 'filter': 'drop-shadow(0 0 0 ${color!})',
      ...?cssStyle,
    };

    if (rawCss != null && rawCss!.isNotEmpty) {
      final pairs = rawCss!.split(';');
      for (var pair in pairs) {
        if (pair.trim().isEmpty) continue;
        final parts = pair.split(':');
        if (parts.length >= 2) {
          styleMap[parts[0].trim()] = parts.sublist(1).join(':').trim();
        }
      }
    }

    return FlartElementNode(
      'img',
      id: key?.toString(),
      attributes: {
        'src': src,
        'alt': alt ?? '',
        'loading': loading == ImageLoading.lazy ? 'lazy' : 'eager',
      },
      styles: styleMap,
    );
  }

  String _boxFitToCss(BoxFit fit) {
    switch (fit) {
      case BoxFit.fill:
        return 'fill';
      case BoxFit.contain:
        return 'contain';
      case BoxFit.cover:
        return 'cover';
      case BoxFit.fitWidth:
        return 'scale-down';
      case BoxFit.fitHeight:
        return 'scale-down';
      case BoxFit.none:
        return 'none';
      case BoxFit.scaleDown:
        return 'scale-down';
    }
  }

  String _alignmentToCss(Alignment alignment) {
    String x = 'center';
    String y = 'center';
    if (alignment.justifyContent == 'flex-start') x = 'left';
    if (alignment.justifyContent == 'flex-end') x = 'right';
    if (alignment.alignItems == 'flex-start') y = 'top';
    if (alignment.alignItems == 'flex-end') y = 'bottom';
    return '$x $y';
  }
}
