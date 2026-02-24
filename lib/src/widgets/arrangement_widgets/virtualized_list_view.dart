import 'dart:html';
import 'dart:math' as math;
import '../../../flartdart.dart';

class FDVirtualizedListView extends StatefulWidget {
  final int itemCount;
  final double itemHeight;
  final ItemWidgetBuilder itemBuilder;
  final Axis scrollDirection;
  final EdgeInsets? padding;

  const FDVirtualizedListView({
    required this.itemCount,
    required this.itemHeight,
    required this.itemBuilder,
    this.scrollDirection = Axis.vertical,
    this.padding,
    Key? key,
  }) : super(key: key);

  @override
  State<FDVirtualizedListView> createState() => _FDVirtualizedListViewState();
}

class _FDVirtualizedListViewState extends State<FDVirtualizedListView> {
  double _scrollTop = 0;
  late String _containerId;

  @override
  void initState() {
    super.initState();
    _containerId = 'v-list-${hashCode}';

    // We need to listen to scroll events after the first render
    Future.delayed(Duration.zero, () {
      final container = document.getElementById(_containerId);
      container?.onScroll.listen((e) {
        final el = e.target as Element;
        final newScrollTop = widget.scrollDirection == Axis.vertical
            ? el.scrollTop.toDouble()
            : el.scrollLeft.toDouble();

        // Only update if moved significantly to avoid over-rendering
        if ((newScrollTop - _scrollTop).abs() > widget.itemHeight / 3) {
          setState(() {
            _scrollTop = newScrollTop;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Attempt to use window height if we're full screen, otherwise default
    final viewportSize = widget.scrollDirection == Axis.vertical
        ? (window.innerHeight?.toDouble() ?? 800.0)
        : (window.innerWidth?.toDouble() ?? 1200.0);

    final totalSize = widget.itemCount * widget.itemHeight;
    final isVertical = widget.scrollDirection == Axis.vertical;

    // Calculate visible range with buffer
    final firstVisibleIndex =
        math.max(0, (_scrollTop / widget.itemHeight).floor() - 3);
    final lastVisibleIndex = math.min(widget.itemCount - 1,
        ((_scrollTop + viewportSize) / widget.itemHeight).ceil() + 3);

    final visibleItems = <Widget>[];
    for (int i = firstVisibleIndex; i <= lastVisibleIndex; i++) {
      final item = widget.itemBuilder(context, i);
      visibleItems.add(FDContainer(
        cssStyle: {
          'position': 'absolute',
          if (isVertical)
            'top': '${i * widget.itemHeight}px'
          else
            'left': '${i * widget.itemHeight}px',
          if (isVertical) 'left': '0' else 'top': '0',
          if (isVertical) 'right': '0' else 'bottom': '0',
          if (isVertical)
            'height': '${widget.itemHeight}px'
          else
            'width': '${widget.itemHeight}px',
        },
        child: item,
      ));
    }

    return FDContainer(
      key: ValueKey(_containerId),
      padding: widget.padding,
      cssStyle: {
        'position': 'relative',
        'height': '100%',
        'width': '100%',
        'overflow-y': isVertical ? 'auto' : 'hidden',
        'overflow-x': isVertical ? 'hidden' : 'auto',
      },
      rawCss: 'id="$_containerId"',
      child: FDStack(
        cssStyle: {
          if (isVertical)
            'height': '${totalSize}px'
          else
            'width': '${totalSize}px',
          if (isVertical) 'width': '100%' else 'height': '100%',
        },
        children: visibleItems,
      ),
    );
  }
}
