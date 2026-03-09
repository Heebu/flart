import 'dart:html';
import '../../../flartdart.dart';

class Hero extends StatefulWidget {
  final Object tag;
  final Widget child;

  const Hero({
    required this.tag,
    required this.child,
    super.key,
  });

  @override
  State<Hero> createState() => _HeroState();
}

class _HeroState extends State<Hero> {
  static final Map<Object, Rectangle> _heroRects = {};

  @override
  Widget build(BuildContext context) {
    final heroId = 'hero_${widget.tag.hashCode}';

    // Capture rect after render
    Future.delayed(Duration.zero, () {
      final el = document.getElementById(heroId);
      if (el != null) {
        _heroRects[widget.tag] = el.getBoundingClientRect();
      }
    });

    return FDContainer(
      key: ValueKey(heroId),
      rawCss: 'id="$heroId"',
      cssStyle: {'display': 'inline-block'},
      child: widget.child,
    );
  }
}
