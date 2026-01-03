import 'dart:html';
import '../../../flartdart.dart';

/// A widget that animates between two children with a crossfade effect
class AnimatedCrossFade extends Widget {
  final Widget firstChild;
  final Widget secondChild;
  final bool showFirst;
  final Duration duration;
  final Curve firstCurve;
  final Curve secondCurve;

  AnimatedCrossFade({
    required this.firstChild,
    required this.secondChild,
    required this.showFirst,
    required this.duration,
    this.firstCurve = Curves.linear,
    this.secondCurve = Curves.linear,
  });

  @override
  String render(BuildContext context) {
    final id = 'animated_crossfade_${DateTime.now().microsecondsSinceEpoch}';
    final durationMs = duration.inMilliseconds;

    return '''
      <div id="$id" style="position: relative;">
        <div style="
          opacity: ${showFirst ? 1 : 0};
          transition: opacity ${durationMs}ms;
          ${!showFirst ? 'position: absolute; top: 0; left: 0; pointer-events: none;' : ''}
        ">
          ${firstChild.render(context)}
        </div>
        <div style="
          opacity: ${showFirst ? 0 : 1};
          transition: opacity ${durationMs}ms;
          ${showFirst ? 'position: absolute; top: 0; left: 0; pointer-events: none;' : ''}
        ">
          ${secondChild.render(context)}
        </div>
      </div>
    ''';
  }
}
