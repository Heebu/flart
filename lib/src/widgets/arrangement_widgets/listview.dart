import '../../../flartdart.dart';

typedef ItemWidgetBuilder = Widget Function(BuildContext context, int index);
typedef SeparatorWidgetBuilder = Widget Function(
    BuildContext context, int index);

typedef ListView = FDListView;

enum ListViewType { static, builder, separated }

class FDListView extends Widget {
  final Axis scrollDirection;
  final EdgeInsets? padding;
  final bool shrinkWrap;
  final bool reverse;
  final List<Widget>? children;
  final int? itemCount;
  final ItemWidgetBuilder? itemBuilder;
  final SeparatorWidgetBuilder? separatorBuilder;
  final ListViewType type;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  FDListView._({
    this.scrollDirection = Axis.vertical,
    this.padding,
    this.shrinkWrap = false,
    this.reverse = false,
    this.children,
    this.itemCount,
    this.itemBuilder,
    this.separatorBuilder,
    required this.type,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  factory FDListView({
    Axis scrollDirection = Axis.vertical,
    EdgeInsets? padding,
    bool shrinkWrap = false,
    bool reverse = false,
    required List<Widget> children,
    Map<String, String>? cssStyle,
    String? rawCss,
    Key? key,
  }) {
    return FDListView._(
      key: key,
      scrollDirection: scrollDirection,
      padding: padding,
      shrinkWrap: shrinkWrap,
      reverse: reverse,
      children: children,
      type: ListViewType.static,
      cssStyle: cssStyle,
      rawCss: rawCss,
    );
  }

  factory FDListView.builder({
    Axis scrollDirection = Axis.vertical,
    EdgeInsets? padding,
    bool shrinkWrap = false,
    bool reverse = false,
    required int itemCount,
    required ItemWidgetBuilder itemBuilder,
    Map<String, String>? cssStyle,
    String? rawCss,
    Key? key,
  }) {
    return FDListView._(
      key: key,
      scrollDirection: scrollDirection,
      padding: padding,
      shrinkWrap: shrinkWrap,
      reverse: reverse,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      type: ListViewType.builder,
      cssStyle: cssStyle,
      rawCss: rawCss,
    );
  }

  factory FDListView.separated({
    Axis scrollDirection = Axis.vertical,
    EdgeInsets? padding,
    bool shrinkWrap = false,
    bool reverse = false,
    required int itemCount,
    required ItemWidgetBuilder itemBuilder,
    required SeparatorWidgetBuilder separatorBuilder,
    Map<String, String>? cssStyle,
    String? rawCss,
    Key? key,
  }) {
    return FDListView._(
      key: key,
      scrollDirection: scrollDirection,
      padding: padding,
      shrinkWrap: shrinkWrap,
      reverse: reverse,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      separatorBuilder: separatorBuilder,
      type: ListViewType.separated,
      cssStyle: cssStyle,
      rawCss: rawCss,
    );
  }

  @override
  FlartNode buildNode(BuildContext context) {
    final isVertical = scrollDirection == Axis.vertical;

    final flexDir = isVertical
        ? (reverse ? 'column-reverse' : 'column')
        : (reverse ? 'row-reverse' : 'row');

    final styles = <String, String>{
      'box-sizing': 'border-box',
      'display': 'flex',
      'flex-direction': flexDir,
      if (shrinkWrap) ...{
        'height': 'auto',
        'overflow': 'visible',
      } else ...{
        'height': '100%',
        'overflow-y': isVertical ? 'auto' : 'hidden',
        'overflow-x': isVertical ? 'hidden' : 'auto',
      },
      if (padding != null) 'padding': padding!.toCss(),
      ...?cssStyle,
    };

    if (rawCss != null && rawCss!.isNotEmpty) {
      final pairs = rawCss!.split(';');
      for (var pair in pairs) {
        if (pair.trim().isEmpty) continue;
        final parts = pair.split(':');
        if (parts.length >= 2) {
          styles[parts[0].trim()] = parts.sublist(1).join(':').trim();
        }
      }
    }

    final childrenNodes = <FlartNode>[];

    switch (type) {
      case ListViewType.static:
        if (children != null) {
          childrenNodes.addAll(children!.map((c) => c.buildNode(context)));
        }
        break;

      case ListViewType.builder:
        if (itemBuilder != null && itemCount != null) {
          for (int i = 0; i < itemCount!; i++) {
            childrenNodes.add(itemBuilder!(context, i).buildNode(context));
          }
        }
        break;

      case ListViewType.separated:
        if (itemBuilder != null && separatorBuilder != null && itemCount != null) {
          for (int i = 0; i < itemCount!; i++) {
            childrenNodes.add(itemBuilder!(context, i).buildNode(context));
            if (i < itemCount! - 1) {
              childrenNodes.add(separatorBuilder!(context, i).buildNode(context));
            }
          }
        }
        break;
    }

    return FlartElementNode(
      'div',
      id: key?.toString(),
      styles: styles,
      children: childrenNodes,
    );
  }
}
