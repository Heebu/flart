import '../../../flartdart.dart';
typedef FlartVoidCallback = String Function();

class FDFloatingActionButton extends Widget {
  final Widget child;
  final FlartColor backgroundColor;
  final VoidCallback? onPressed;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  FDFloatingActionButton({
    required this.child,
    this.backgroundColor = FlartColors.green,
    this.onPressed,
    this.cssStyle,
    this.rawCss,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final id = _generateUniqueId();

    final styles = <String, String>{
      'position': 'fixed',
      'bottom': '20px',
      'right': '20px',
      'width': '56px',
      'height': '56px',
      'border-radius': '50%',
      'background-color': backgroundColor.toString(),
      'display': 'flex',
      'align-items': 'center',
      'justify-content': 'center',
      'box-shadow': '0 3px 6px rgba(0,0,0,0.16)',
      'cursor': onPressed != null ? 'pointer' : 'default',
      'z-index': '1000',
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

    final events = <String, void Function(dynamic)>{};
    if (onPressed != null) {
      events['click'] = (e) => onPressed!();
    }

    return FlartElementNode(
      'div',
      id: id,
      styles: styles,
      events: events,
      children: [child.buildNode(context)],
    );
  }

  String _generateUniqueId() {
    final now = DateTime.now();
    return 'fab_${now.millisecondsSinceEpoch}_${now.microsecondsSinceEpoch}';
  }
}
