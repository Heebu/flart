import '../../../flartdart.dart';

/// A tooltip widget that shows on hover
class Tooltip extends Widget {
  final Widget child;
  final String message;
  final EdgeInsets? padding;
  final FlartColor? backgroundColor;
  final TextStyle? textStyle;

  Tooltip({
    required this.child,
    required this.message,
    this.padding,
    this.backgroundColor,
    this.textStyle,
  });

  @override
  String render(BuildContext context) {
    final id = 'tooltip_${DateTime.now().microsecondsSinceEpoch}';
    final bgColor = backgroundColor?.toString() ?? 'rgba(97, 97, 97, 0.9)';
    final pad = padding ?? EdgeInsets.all(8);

    return '''
      <div id="$id" style="position: relative; display: inline-block;">
        ${child.render(context)}
        <div class="tooltip-text" style="
          visibility: hidden;
          opacity: 0;
          background-color: $bgColor;
          color: white;
          text-align: center;
          border-radius: 4px;
          padding: ${pad.toCss()};
          position: absolute;
          z-index: 1000;
          bottom: 125%;
          left: 50%;
          transform: translateX(-50%);
          white-space: nowrap;
          transition: opacity 0.3s, visibility 0.3s;
          pointer-events: none;
        ">
          $message
          <div style="
            position: absolute;
            top: 100%;
            left: 50%;
            margin-left: -5px;
            border-width: 5px;
            border-style: solid;
            border-color: $bgColor transparent transparent transparent;
          "></div>
        </div>
      </div>
      <script>
        (function() {
          const el = document.getElementById('$id');
          const tooltip = el.querySelector('.tooltip-text');
          el.addEventListener('mouseenter', () => {
            tooltip.style.visibility = 'visible';
            tooltip.style.opacity = '1';
          });
          el.addEventListener('mouseleave', () => {
            tooltip.style.visibility = 'hidden';
            tooltip.style.opacity = '0';
          });
        })();
      </script>
    ''';
  }
}

/// A snackbar for temporary messages
class SnackBar extends Widget {
  final Widget content;
  final Duration duration;
  final Widget? action;
  final FlartColor? backgroundColor;

  SnackBar({
    required this.content,
    this.duration = const Duration(seconds: 4),
    this.action,
    this.backgroundColor,
  });

  @override
  String render(BuildContext context) {
    final id = 'snackbar_${DateTime.now().microsecondsSinceEpoch}';
    final bgColor = backgroundColor?.toString() ?? '#323232';
    final durationMs = duration.inMilliseconds;

    return '''
      <div id="$id" style="
        position: fixed;
        bottom: 20px;
        left: 50%;
        transform: translateX(-50%) translateY(100px);
        background-color: $bgColor;
        color: white;
        padding: 14px 24px;
        border-radius: 4px;
        box-shadow: 0 3px 5px rgba(0,0,0,0.2);
        display: flex;
        align-items: center;
        gap: 16px;
        z-index: 9999;
        transition: transform 0.3s ease;
      ">
        <div style="flex: 1;">
          ${content.render(context)}
        </div>
        ${action != null ? action!.render(context) : ''}
      </div>
      <script>
        (function() {
          const snackbar = document.getElementById('$id');
          setTimeout(() => {
            snackbar.style.transform = 'translateX(-50%) translateY(0)';
          }, 100);
          setTimeout(() => {
            snackbar.style.transform = 'translateX(-50%) translateY(100px)';
            setTimeout(() => snackbar.remove(), 300);
          }, $durationMs);
        })();
      </script>
    ''';
  }
}
