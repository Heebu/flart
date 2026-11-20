import '../../../flartdart.dart';

enum DecorationPosition {
  background,
  foreground,
}

typedef DecoratedBox = FDDecoratedBox;
typedef ColoredBox = FDColoredBox;

/// A widget that paints a [BoxDecoration] either before or after its child paints.
class FDDecoratedBox extends Widget {
  final BoxDecoration decoration;
  final DecorationPosition position;
  final Widget? child;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDDecoratedBox({
    required this.decoration,
    this.position = DecorationPosition.background,
    this.child,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final styles = <String, String>{
      'box-sizing': 'border-box',
      ...decoration.toCss(),
      ...?cssStyle,
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

    return FlartElementNode(
      'div',
      id: key?.toString(),
      styles: styles,
      children: child != null ? [child!.buildNode(context)] : null,
    );
  }
}

/// A widget that paints its area with a specified [FlartColor] and then its child.
class FDColoredBox extends Widget {
  final FlartColor color;
  final Widget? child;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDColoredBox({
    required this.color,
    this.child,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final styles = <String, String>{
      'box-sizing': 'border-box',
      'background-color': color.toString(),
      ...?cssStyle,
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

    return FlartElementNode(
      'div',
      id: key?.toString(),
      styles: styles,
      children: child != null ? [child!.buildNode(context)] : null,
    );
  }
}
