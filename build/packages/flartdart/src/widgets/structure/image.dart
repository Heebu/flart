import '../../../flartdart.dart';
import '../../enums/box_fit.dart';

enum ImageLoading {
  eager,
  lazy,
}

class FDImage extends Widget {
  final String src;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Map<String, String>? cssStyle;
  final String? alt;
  final ImageLoading loading;
  final String? rawCss;

  FDImage.network(
    String? src, {
    this.width,
    this.height,
    this.fit,
    this.cssStyle,
    this.alt,
    this.loading = ImageLoading.lazy,
    this.rawCss,
  }) : src = (src == null || src.isEmpty)
            ? '/assets/flart_logo_with_text.png'
            : src;

  FDImage.asset(
    String? assetPath, {
    this.width,
    this.height,
    this.fit,
    this.cssStyle,
    this.alt,
    this.loading = ImageLoading.lazy,
    this.rawCss,
  }) : src = (assetPath == null || assetPath.isEmpty)
            ? '/assets/flart_logo_with_text.png'
            : '/$assetPath'; // Adjust this based on your asset structure

  @override
  String render(BuildContext context) {
    final styleMap = {
      if (width != null) 'width': '${width}px',
      if (height != null) 'height': '${height}px',
      if (fit != null) 'object-fit': _boxFitToCss(fit!),
      ...?cssStyle,
    };

    final style =
        styleMap.entries.map((e) => '${e.key}: ${e.value};').join(' ');
    final loadingAttr =
        loading == ImageLoading.lazy ? 'loading="lazy"' : 'loading="eager"';

    return '''
      <img src="$src" alt="${alt ?? ''}" style="$style ${rawCss ?? ''}" $loadingAttr />
    ''';
  }

  String _boxFitToCss(BoxFit fit) {
    switch (fit) {
      case BoxFit.fill:
        return 'fill';
      case BoxFit.contain:
        return 'contain';
      case BoxFit.cover:
        return 'cover';
      case BoxFit.none:
        return 'none';
      case BoxFit.scaleDown:
        return 'scale-down';
    }
  }
}
