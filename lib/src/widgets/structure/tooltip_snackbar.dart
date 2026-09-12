import '../../../flartdart.dart';

/// A Tooltip widget that reveals a text label on hover
class FDTooltip extends Widget {
  final Widget child;
  final String message;
  final EdgeInsets? padding;
  final FlartColor? backgroundColor;
  final TextStyle? textStyle;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDTooltip({
    required this.child,
    required this.message,
    this.padding,
    this.backgroundColor,
    this.textStyle,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final bgColor = backgroundColor?.toString() ?? 'rgba(97, 97, 97, 0.9)';
    final pad = padding ?? const EdgeInsets.all(8);

    final tooltipClass = 'tooltip_${key?.toString() ?? hashCode}';

    final styleBlock = '''
      <style>
        .$tooltipClass {
          position: relative;
          display: inline-block;
        }
        .$tooltipClass .flart-tooltip-text {
          visibility: hidden;
          opacity: 0;
          position: absolute;
          z-index: 1000;
          bottom: 125%;
          left: 50%;
          transform: translateX(-50%);
          white-space: nowrap;
          transition: opacity 0.2s, visibility 0.2s;
          pointer-events: none;
        }
        .$tooltipClass:hover .flart-tooltip-text {
          visibility: visible;
          opacity: 1;
        }
      </style>
    ''';

    final tooltipContentNode = FlartElementNode(
      'div',
      attributes: {'class': 'flart-tooltip-text', 'role': 'tooltip'},
      styles: {
        'background-color': bgColor,
        'color': textStyle?.color?.toString() ?? 'white',
        'font-size': textStyle?.fontSize != null ? '${textStyle!.fontSize}px' : '12px',
        'text-align': 'center',
        'border-radius': '4px',
        'padding': pad.toCss(),
      },
      children: [
        FlartTextNode(message),
      ],
    );

    return FlartElementNode(
      'div',
      id: key?.toString(),
      attributes: {'class': tooltipClass},
      styles: cssStyle,
      children: [
        FlartRawHtmlNode(styleBlock),
        child.buildNode(context),
        tooltipContentNode,
      ],
    );
  }
}

/// A SnackBar widget for brief status messages
class FDSnackBar extends Widget {
  final Widget content;
  final Duration duration;
  final Widget? action;
  final FlartColor? backgroundColor;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDSnackBar({
    required this.content,
    this.duration = const Duration(seconds: 4),
    this.action,
    this.backgroundColor,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final bgColor = backgroundColor?.toString() ?? '#323232';

    final styles = <String, String>{
      'position': 'fixed',
      'bottom': '20px',
      'left': '50%',
      'transform': 'translateX(-50%)',
      'background-color': bgColor,
      'color': 'white',
      'padding': '14px 24px',
      'border-radius': '4px',
      'box-shadow': '0 3px 5px rgba(0,0,0,0.2)',
      'display': 'flex',
      'align-items': 'center',
      'gap': '16px',
      'z-index': '9999',
      'transition': 'all 0.3s ease',
      ...?cssStyle,
    };

    final children = <FlartNode>[
      FlartElementNode(
        'div',
        styles: {'flex': '1'},
        children: [content.buildNode(context)],
      ),
    ];

    if (action != null) {
      children.add(action!.buildNode(context));
    }

    return FlartElementNode(
      'div',
      id: key?.toString(),
      attributes: {'class': 'flart-snackbar', 'role': 'status'},
      styles: styles,
      children: children,
    );
  }
}
