import '../../../flartdart.dart';

class FDSvgPicture extends Widget {
  final String? assetName;
  final String? string;
  final double? width;
  final double? height;
  final FlartColor? color;
  final BoxFit fit;
  final String? rawCss;

  const FDSvgPicture.asset(
    this.assetName, {
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.contain,
    this.rawCss,
    super.key,
  }) : string = null;

  const FDSvgPicture.string(
    this.string, {
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.contain,
    this.rawCss,
    super.key,
  }) : assetName = null;

  @override
  FlartNode buildNode(BuildContext context) {
    final styles = <String, String>{
      'display': 'inline-block',
      if (width != null) 'width': '${width}px',
      if (height != null) 'height': '${height}px',
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

    if (string != null) {
      if (color != null) {
        styles['fill'] = color.toString();
        styles['color'] = color.toString();
      }
      return FlartElementNode(
        'div',
        id: key?.toString(),
        styles: styles,
        children: [FlartRawHtmlNode(string!)],
      );
    } else if (assetName != null) {
      if (color != null) {
        final c = color.toString();
        final maskStyles = <String, String>{
          'width': '${width ?? 24}px',
          'height': '${height ?? 24}px',
          'background-color': c,
          'mask': 'url(/$assetName) no-repeat center',
          '-webkit-mask': 'url(/$assetName) no-repeat center',
          'mask-size': _boxFitToCss(fit),
          '-webkit-mask-size': _boxFitToCss(fit),
          'display': 'inline-block',
          ...styles,
        };

        return FlartElementNode(
          'div',
          id: key?.toString(),
          styles: maskStyles,
        );
      }

      styles['object-fit'] = _boxFitToCss(fit);
      return FlartElementNode(
        'img',
        id: key?.toString(),
        attributes: {
          'src': '/$assetName',
          'alt': 'svg',
        },
        styles: styles,
      );
    }

    return FlartElementNode('div', id: key?.toString());
  }

  String _boxFitToCss(BoxFit fit) {
    switch (fit) {
      case BoxFit.fill:
        return '100% 100%';
      case BoxFit.contain:
        return 'contain';
      case BoxFit.cover:
        return 'cover';
      case BoxFit.none:
        return 'auto';
      case BoxFit.scaleDown:
        return 'contain';
    }
  }
}
