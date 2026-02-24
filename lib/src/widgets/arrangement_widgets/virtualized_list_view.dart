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
        final newScrollTop = (e.target as Element).scrollTop.toDouble();
        // Only update if moved significantly to avoid over-rendering
        if ((newScrollTop - _scrollTop).abs() > widget.itemHeight / 2) {
          setState(() {
            _scrollTop = newScrollTop;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewportHeight = 600.0; // Assume a default or we could try to measure
    final totalHeight = widget.itemCount * widget.itemHeight;

    // Calculate visible range
    final firstVisibleIndex =
        math.max(0, (_scrollTop / widget.itemHeight).floor() - 2);
    final lastVisibleIndex = math.min(widget.itemCount - 1,
        ((_scrollTop + viewportHeight) / widget.itemHeight).ceil() + 2);

    final visibleItems = <Widget>[];
    for (int i = firstVisibleIndex; i <= lastVisibleIndex; i++) {
      final item = widget.itemBuilder(context, i);
      // Wrap each item in a positioned container
      visibleItems.add(FDContainer(
        cssStyle: {
          'position': 'absolute',
          'top': '${i * widget.itemHeight}px',
          'left': '0',
          'right': '0',
          'height': '${widget.itemHeight}px',
        },
        child: item,
      ));
    }

    return FDContainer(
      key: ValueKey(_containerId),
      cssStyle: {
        'position': 'relative',
        'height': '100%',
        'width': '100%',
        'overflow-y': 'auto',
        'overflow-x': 'hidden',
      },
      rawCss: 'id="$_containerId"',
      child: FDStack(
        cssStyle: {
          'height': '${totalHeight}px',
          'width': '100%',
        },
        children: visibleItems,
      ),
    );
  }
}
