
import '../../../flart.dart';

enum BoxFit {
  fill,
  contain,
  cover,
  none,
  scaleDown,
}

class FlartImage extends Widget {
  final String src;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Map<String, String>? cssStyle;
  final String? alt;

  FlartImage.network(
      this.src, {
        this.width,
        this.height,
        this.fit,
        this.cssStyle,
        this.alt,
      });

  FlartImage.asset(
      String assetPath, {
        this.width,
        this.height,
        this.fit,
        this.cssStyle,
        this.alt,
      }) : src = '/$assetPath'; // Adjust this based on your asset structure

  @override
  String render(BuildContext context) {
    final styleMap = {
      if (width != null) 'width': '${width}px',
      if (height != null) 'height': '${height}px',
      if (fit != null) 'object-fit': _boxFitToCss(fit!),
      ...?cssStyle,
    };

    final style = styleMap.entries.map((e) => '${e.key}: ${e.value};').join(' ');

    return '''
      <img src="$src" alt="${alt ?? ''}" style="$style" />
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
