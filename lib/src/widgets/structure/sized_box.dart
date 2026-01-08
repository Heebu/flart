import '../../../flartdart.dart';

class FDSizedBox extends Widget {
  final double? width;
  final double? height;
  final Widget? child;
  final Map<String, String>? cssStyle;

  FDSizedBox({this.width, this.height, this.child, this.cssStyle});

  @override
  String render(BuildContext context) {
    final style = {
      if (width != null) 'width': '${width}px',
      if (height != null) 'height': '${height}px',
      ...?cssStyle,
    }.entries.map((e) => '${e.key}: ${e.value};').join(' ');

    return '''
      <div style="$style">
        ${child?.render(context) ?? ''}
      </div>
    ''';
  }


}



