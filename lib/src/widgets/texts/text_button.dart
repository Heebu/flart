import '../../helper/callback_manager.dart';
import '../../../flart.dart';

class TextButton extends Widget {
  final String label;
  final VoidCallback? onPressed;
  final VoidCallback? onHover;
  final VoidCallback? onLongPress;
  final TextStyle? style;
  final Map<String, String>? cssStyle;

  TextButton({
    required this.label,
    this.onPressed,
    this.onHover,
    this.onLongPress,
    this.style,
    this.cssStyle,
  });

  @override
  String render(BuildContext context) {
    final id = 'text_btn_${DateTime.now().millisecondsSinceEpoch}';
    final pressId =
        onPressed != null ? FlartCallbackManager.register(onPressed!) : '';
    final hoverId =
        onHover != null ? FlartCallbackManager.register(onHover!) : '';
    final longPressId =
        onLongPress != null ? FlartCallbackManager.register(onLongPress!) : '';

    final styleMap = {
      'background': 'none',
      'border': 'none',
      'color': style?.color?.toString() ?? '#007BFF',
      'font-size': style?.fontSize?.toString() ?? '16px',
      'cursor': 'pointer',
      'padding': '4px 8px',
      'transition': 'all 0.2s ease-in-out',
      'text-decoration': 'underline',
      ...?cssStyle,
    };
    final styleString =
        styleMap.entries.map((e) => '${e.key}: ${e.value};').join(' ');

    return '''
      <button id="$id" style="$styleString">
        $label
      </button>
      <script>
        const btn = document.getElementById('$id');
        
        ${onPressed != null ? "btn.addEventListener('click', () => __flartHandleClick('$pressId'));" : ''}
        ${onHover != null ? "btn.addEventListener('mouseover', () => __flartHandleClick('$hoverId'));" : ''}
        ${onLongPress != null ? """
          let longPressTimer;
          btn.addEventListener('mousedown', () => {
            longPressTimer = setTimeout(() => __flartHandleClick('$longPressId'), 600);
          });
          btn.addEventListener('mouseup', () => clearTimeout(longPressTimer));
          btn.addEventListener('mouseleave', () => clearTimeout(longPressTimer));
        """ : ''}
      </script>
    ''';
  }
}


//TextButton(
//   text: 'Submit',
//   onPressed: () => print('TextButton pressed'),
//   onHover: () => print('Hovered over TextButton'),
//   onLongPress: () => print('Long-pressed TextButton'),
//   style: TextStyle(
//     fontSize: 14,
//     color: FlartColor('#ffffff'),
//   ),
//   backgroundColor: FlartColor('#007acc'),
// )