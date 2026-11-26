import 'package:web/web.dart';
import 'dart:js_interop';
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
    super.key,
  });

  @override
  State<FDVirtualizedListView> createState() => _FDVirtualizedListViewState();
}

class _FDVirtualizedListViewState extends State<FDVirtualizedListView> {
  double _scrollTop = 0;
  late String _containerId;

  @override
  void initState() {
    super.initState();
    _containerId = 'v-list-$hashCode';

    Future.delayed(Duration.zero, () {
      final container = document.getElementById(_containerId);
      container?.addEventListener(
          'scroll',
          ((Event e) {
            final el = e.target as Element;
            final newScrollTop = widget.scrollDirection == Axis.vertical
                ? el.scrollTop.toDouble()
                : el.scrollLeft.toDouble();

            // Throttle re-renders until scroll delta exceeds threshold.
            if ((newScrollTop - _scrollTop).abs() > widget.itemHeight / 3) {
              setState(() {
                _scrollTop = newScrollTop;
              });
            }
          }).toJS);
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewportSize = widget.scrollDirection == Axis.vertical
        ? window.innerHeight.toDouble()
        : window.innerWidth.toDouble();

    final totalSize = widget.itemCount * widget.itemHeight;
    final isVertical = widget.scrollDirection == Axis.vertical;

    // Compute visible bounds with overscan buffer.
    final firstVisibleIndex =
        math.max(0, (_scrollTop / widget.itemHeight).floor() - 3);
    final lastVisibleIndex = math.min(widget.itemCount - 1,
        ((_scrollTop + viewportSize) / widget.itemHeight).ceil() + 3);

    final visibleItems = <Widget>[];
    for (int i = firstVisibleIndex; i <= lastVisibleIndex; i++) {
      final item = widget.itemBuilder(context, i);
      visibleItems.add(FDPositioned(
        top: isVertical ? (i * widget.itemHeight).toDouble() : 0,
        left: isVertical ? 0 : (i * widget.itemHeight).toDouble(),
        right: isVertical ? 0 : null,
        bottom: isVertical ? null : 0,
        height: isVertical ? widget.itemHeight.toDouble() : null,
        width: isVertical ? null : widget.itemHeight.toDouble(),
        child: item,
      ));
    }

    return FDContainer(
      id: _containerId,
      key: ValueKey(_containerId),
      padding: widget.padding,
      clipBehavior: Clip.hardEdge,
      child: FDStack(
        children: [
          FDSizedBox(
            height: isVertical ? totalSize.toDouble() : null,
            width: isVertical ? null : totalSize.toDouble(),
          ),
          ...visibleItems,
        ],
      ),
    );
  }
}
