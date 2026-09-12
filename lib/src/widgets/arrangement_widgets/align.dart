import '../../../flartdart.dart';

class FDAlign extends Widget {
  final Widget child;
  final dynamic alignment;
  final double? widthFactor;
  final double? heightFactor;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDAlign({
    required this.child,
    this.alignment = Alignment.center,
    this.widthFactor,
    this.heightFactor,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    Map<String, String> alignStyle = {};
    if (alignment is Alignment) {
      alignStyle = (alignment as Alignment).toCss();
    } else if (alignment is Aligns) {
      alignStyle = (alignment as Aligns).toCss();
    } else {
      alignStyle = Alignment.center.toCss();
    }

    final combinedStyle = <String, String>{
      'display': 'flex',
      ...alignStyle,
      if (widthFactor != null) 'width': '${widthFactor! * 100}%' else 'width': '100%',
      if (heightFactor != null) 'height': '${heightFactor! * 100}%' else 'height': '100%',
      ...?cssStyle,
    };

    if (rawCss != null && rawCss!.isNotEmpty) {
      final pairs = rawCss!.split(';');
      for (var pair in pairs) {
        if (pair.trim().isEmpty) continue;
        final parts = pair.split(':');
        if (parts.length >= 2) {
          combinedStyle[parts[0].trim()] = parts.sublist(1).join(':').trim();
        }
      }
    }

    return FlartElementNode(
      'div',
      id: key?.toString(),
      styles: combinedStyle,
      children: [child.buildNode(context)],
    );
  }
}
