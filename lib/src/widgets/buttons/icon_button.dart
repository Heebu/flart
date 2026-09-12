import '../../../flartdart.dart';
class FDIconButton extends Widget {
  final FDIcon icon;
  final VoidCallback? onPressed;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDIconButton({
    required this.icon,
    this.onPressed,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final id =
        'icon_btn_${key?.toString() ?? hashCode}_${DateTime.now().millisecondsSinceEpoch}';
    final theme = Theme.of(context);

    final styles = <String, String>{
      'display': 'inline-flex',
      'align-items': 'center',
      'justify-content': 'center',
      'padding': '8px',
      'border': 'none',
      'background': 'transparent',
      'border-radius': '50%',
      'cursor': onPressed != null ? 'pointer' : 'default',
      'outline': 'none',
      'transition': 'background-color 0.2s, transform 0.1s',
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

    final buttonNode = FDElement(
      tag: 'button',
      id: id,
      attributes: {'class': 'fd-icon-button'},
      styles: styles,
      events: events,
      children: [icon],
    ).buildNode(context);

    final styleBlock = '''
      <style>
        .fd-icon-button:hover {
          background-color: ${theme.primaryColor.toString()}1A !important;
        }
        .fd-icon-button:active {
          transform: scale(0.92);
          background-color: ${theme.primaryColor.toString()}33 !important;
        }
      </style>
    ''';

    return FlartElementNode(
      'div',
      styles: {'display': 'contents'},
      children: [
        FlartRawHtmlNode(styleBlock),
        buttonNode,
      ],
    );
  }
}
