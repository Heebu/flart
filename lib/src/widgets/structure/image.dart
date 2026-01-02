import '../../../flart.dart';

enum BoxFit {
  fill,
  contain,
  cover,
  none,
  scaleDown,
}

enum ImageLoading {
  eager,
  lazy,
}

class FlartImage extends Widget {
  final String src;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Map<String, String>? cssStyle;
  final String? alt;
  final ImageLoading loading;

  FlartImage.network(
    this.src, {
    this.width,
    this.height,
    this.fit,
    this.cssStyle,
    this.alt,
    this.loading = ImageLoading.lazy,
  });

  FlartImage.asset(
    String assetPath, {
    this.width,
    this.height,
    this.fit,
    this.cssStyle,
    this.alt,
    this.loading = ImageLoading.lazy,
  }) : src = '/$assetPath'; // Adjust this based on your asset structure

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
      <img src="$src" alt="${alt ?? ''}" style="$style" $loadingAttr />
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
