import '../../../flartdart.dart';

class FDSizedBox extends Widget {
  final double? width;
  final double? height;
  final Widget? child;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDSizedBox({
    this.width,
    this.height,
    this.child,
    this.cssStyle,
    this.rawCss,
    Key? key,
  }) : super(key: key);

  @override
  String render(BuildContext context) {
    final style = {
      if (width != null) 'width': '${width}px',
      if (height != null) 'height': '${height}px',
      ...?cssStyle,
    }.entries.map((e) => '${e.key}: ${e.value};').join(' ');

    return '''
      <div style="$style ${rawCss ?? ''}">
        ${child?.render(context) ?? ''}
      </div>
    ''';
  }
}
