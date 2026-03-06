import 'dart:html';
import '../../../flartdart.dart';

/// A scroll-responsive app bar that expands and collapses.
class FDSliverAppBar extends StatefulWidget {
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final FlartColor? backgroundColor;
  final double expandedHeight;
  final Widget? flexibleSpace;
  final bool pinned;
  final double elevation;

  const FDSliverAppBar({
    this.title,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.expandedHeight = 200.0,
    this.flexibleSpace,
    this.pinned = true,
    this.elevation = 4.0,
    super.key,
  });

  @override
  State<FDSliverAppBar> createState() => _FDSliverAppBarState();
}

class _FDSliverAppBarState extends State<FDSliverAppBar> {
  double _scrollOffset = 0;
  String _scrollListenerId = '';

  @override
  void initState() {
    super.initState();
    _scrollListenerId = 'sliver_app_bar_$hashCode';

    // We need to listen to the nearest scrollable parent
    // In Flart's current architecture, this is often the body or a ScrollView
    Future.delayed(Duration.zero, () {
      final scrollable = _findScrollableParent();
      scrollable?.onScroll.listen((event) {
        final scrollTop = (event.target as Element).scrollTop.toDouble();
        if ((scrollTop - _scrollOffset).abs() > 2) {
          setState(() {
            _scrollOffset = scrollTop;
          });
        }
      });
    });
  }

  Element? _findScrollableParent() {
    // Look for parent with overflow auto/scroll
    Element? parent = document.getElementById(_scrollListenerId)?.parent;
    while (parent != null) {
      final style = parent.getComputedStyle();
      if (style.overflowY == 'auto' || style.overflowY == 'scroll') {
        return parent;
      }
      parent = parent.parent;
    }
    return document.body;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final bg = widget.backgroundColor ?? theme.primaryColor;

    // Calculate current height based on scroll
    // height ranges from expandedHeight down to 56 (default appbar height)
    final topPadding =
        0.0; // In web we don't usually have status bar padding like mobile
    final minHeight = 56.0 + topPadding;
    final currentHeight = (widget.expandedHeight - _scrollOffset)
        .clamp(minHeight, widget.expandedHeight);

    // Calculate opacity for title and flexible space
    // Title usually fades in as we collapse, flexible space fades out
    final collapseRatio = ((widget.expandedHeight - currentHeight) /
            (widget.expandedHeight - minHeight))
        .clamp(0.0, 1.0);
    final titleOpacity = collapseRatio;
    final flexibleOpacity = 1.0 - collapseRatio;

    return FDContainer(
      rawCss: 'id="$_scrollListenerId"',
      cssStyle: {
        'position': widget.pinned ? 'sticky' : 'relative',
        'top': '0',
        'left': '0',
        'right': '0',
        'height': '${currentHeight}px',
        'background-color': bg.toString(),
        'z-index': '100',
        'overflow': 'hidden',
        'transition': 'box-shadow 0.2s',
        'box-shadow': _scrollOffset > 0
            ? '0 ${widget.elevation}px ${widget.elevation * 2}px rgba(0,0,0,0.15)'
            : 'none',
      },
      child: FDStack(
        children: [
          // Flexible Space
          if (widget.flexibleSpace != null)
            FDPositioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: FDContainer(
                cssStyle: {'opacity': flexibleOpacity.toString()},
                child: widget.flexibleSpace!,
              ),
            ),

          // App Bar Content (pinned part)
          FDPositioned(
            top: 0,
            left: 0,
            right: 0,
            child: FDContainer(
              height: 56,
              padding: EdgeInsets.symmetric(horizontal: 16),
              cssStyle: {
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'space-between',
              },
              child: FDRow(
                children: [
                  // Leading
                  if (widget.leading != null)
                    FDPadding(
                      padding: EdgeInsets.only(right: 16),
                      child: widget.leading!,
                    ),

                  // Title (fades in)
                  FDExpanded(
                    child: FDContainer(
                      cssStyle: {
                        'opacity': titleOpacity.toString(),
                        'font-size': '20px',
                        'font-weight': '500',
                        'color': 'white',
                      },
                      child: widget.title ?? FDSizedBox(),
                    ),
                  ),

                  // Actions
                  if (widget.actions != null)
                    FDRow(
                      children: widget.actions!
                          .map((a) => FDPadding(
                                padding: EdgeInsets.only(left: 8),
                                child: a,
                              ))
                          .toList(),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
