import '../../helper/callback_manager.dart';
import '../../../flartdart.dart';

class FDTextButton extends Widget {
  final Widget? child;
  final String? label;
  final VoidCallback? onPressed;
  final TextStyle? style;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDTextButton({
    this.child,
    this.label,
    this.onPressed,
    this.style,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  @override
  String render(BuildContext context) {
    final id = 'text_btn_${DateTime.now().millisecondsSinceEpoch}';
    final pressId =
        onPressed != null ? FlartCallbackManager.register(onPressed!) : '';

    final styleMap = {
      'background': 'none',
      'border': 'none',
      'color': style?.color?.toString() ?? 'inherit',
      'font-size': style?.fontSize?.toString() ?? 'inherit',
      'cursor': 'pointer',
      'padding': '4px 8px',
      'transition': 'all 0.2s ease-in-out',
      'text-decoration': 'underline',
      ...?cssStyle,
    };
    final styleString =
        styleMap.entries.map((e) => '${e.key}: ${e.value};').join(' ');

    return '''
      <button id="$id" style="$styleString ${rawCss ?? ''}">
        ${child?.render(context) ?? label ?? ''}
      </button>
      <script>
        document.getElementById('$id').addEventListener('click', () => {
          ${onPressed != null ? "__flartHandleClick('$pressId')" : ''}
        });
      </script>
    ''';
  }
}
