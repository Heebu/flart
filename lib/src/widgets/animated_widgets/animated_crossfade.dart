import '../../../flartdart.dart';

/// The state of an [AnimatedCrossFade] widget.
enum CrossFadeState {
  showFirst,
  showSecond,
}

/// Flutter compatibility typedefs
typedef FDAnimatedCrossFade = AnimatedCrossFade;

/// A widget that cross-fades between two given children and animates itself between their sizes.
/// Follows Flutter's [AnimatedCrossFade] specification.
class AnimatedCrossFade extends Widget {
  final Widget firstChild;
  final Widget secondChild;
  final CrossFadeState crossFadeState;
  final Duration duration;
  final Duration? reverseDuration;
  final Curve firstCurve;
  final Curve secondCurve;
  final Alignment alignment;

  AnimatedCrossFade({
    required this.firstChild,
    required this.secondChild,
    CrossFadeState? crossFadeState,
    bool? showFirst,
    required this.duration,
    this.reverseDuration,
    this.firstCurve = Curves.linear,
    this.secondCurve = Curves.linear,
    this.alignment = Alignment.topCenter,
    super.key,
  }) : crossFadeState = crossFadeState ??
            ((showFirst ?? true)
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond);

  @override
  FlartNode buildNode(BuildContext context) {
    final isFirst = crossFadeState == CrossFadeState.showFirst;
    final durationMs = duration.inMilliseconds;
    final firstCurveCss = firstCurve.toCss();
    final secondCurveCss = secondCurve.toCss();

    return FlartElementNode(
      'div',
      id: key?.toString(),
      key: key?.toString(),
      styles: {
        'position': 'relative',
        'display': 'inline-block',
      },
      children: [
        FlartElementNode(
          'div',
          styles: {
            'opacity': isFirst ? '1' : '0',
            'transition': 'opacity ${durationMs}ms $firstCurveCss',
            if (!isFirst) ...{
              'position': 'absolute',
              'top': '0',
              'left': '0',
              'pointer-events': 'none',
            },
          },
          children: [firstChild.buildNode(context)],
        ),
        FlartElementNode(
          'div',
          styles: {
            'opacity': isFirst ? '0' : '1',
            'transition': 'opacity ${durationMs}ms $secondCurveCss',
            if (isFirst) ...{
              'position': 'absolute',
              'top': '0',
              'left': '0',
              'pointer-events': 'none',
            },
          },
          children: [secondChild.buildNode(context)],
        ),
      ],
    );
  }

  @override
  String render(BuildContext context) {
    return buildNode(context).toHtml();
  }
}
