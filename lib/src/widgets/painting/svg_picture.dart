import '../../../flartdart.dart';
import '../../enums/box_fit.dart';

class FDSvgPicture extends Widget {
  final String? assetName;
  final String? string;
  final double? width;
  final double? height;
  final FlartColor? color;
  final BoxFit fit;
  final String? rawCss;

  FDSvgPicture.asset(
    this.assetName, {
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.contain,
    this.rawCss,
  }) : string = null;

  FDSvgPicture.string(
    this.string, {
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.contain,
    this.rawCss,
  }) : assetName = null;

  @override
  String render(BuildContext context) {
    final w = width != null ? '${width}px' : 'auto';
    final h = height != null ? '${height}px' : 'auto';

    // Inline SVG
    if (string != null) {
      final style = {
        if (width != null) 'width': w,
        if (height != null) 'height': h,
        if (color != null) 'fill': color.toString(),
        if (color != null) 'color': color.toString(),
        ..._parseRawCss(rawCss),
      }.entries.map((e) => '${e.key}: ${e.value};').join(' ');

      return '<div style="display: inline-block; $style">$string</div>';
    }
    // Asset SVG
    else if (assetName != null) {
      // Color filter using mask
      if (color != null) {
        final c = color.toString();
        return '''
          <div style="
            width: ${width ?? 24}px; 
            height: ${height ?? 24}px; 
            background-color: $c;
            mask: url(/$assetName) no-repeat center;
            -webkit-mask: url(/$assetName) no-repeat center;
            mask-size: ${_boxFitToCss(fit)};
            -webkit-mask-size: ${_boxFitToCss(fit)};
            display: inline-block;
            ${rawCss ?? ''}
          "></div>
        ''';
      }

      final style = {
        if (width != null) 'width': w,
        if (height != null) 'height': h,
        'object-fit': _boxFitToCss(fit),
        ..._parseRawCss(rawCss),
      }.entries.map((e) => '${e.key}: ${e.value};').join(' ');

      return '<img src="/$assetName" style="$style" alt="svg" />';
    }
    return '';
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
        return 'contain'; // approximation
    }
  }

  Map<String, String> _parseRawCss(String? css) {
    if (css == null) return {};
    final map = <String, String>{};
    css.split(';').forEach((element) {
      final parts = element.split(':');
      if (parts.length == 2) {
        map[parts[0].trim()] = parts[1].trim();
      }
    });
    return map;
  }
}
