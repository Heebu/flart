import '../../../flartdart.dart';

typedef ItemWidgetBuilder = Widget Function(BuildContext context, int index);
typedef SeparatorWidgetBuilder = Widget Function(
    BuildContext context, int index);

enum ListViewType { static, builder, separated }

class FDListView extends Widget {
  final Axis scrollDirection;
  final EdgeInsets? padding;
  final List<Widget>? children;
  final int? itemCount;
  final ItemWidgetBuilder? itemBuilder;
  final SeparatorWidgetBuilder? separatorBuilder;
  final ListViewType type;
  final String? rawCss;

  FDListView._({
    this.scrollDirection = Axis.vertical,
    this.padding,
    this.children,
    this.itemCount,
    this.itemBuilder,
    this.separatorBuilder,
    required this.type,
    this.rawCss,
  });

  /// Regular children list
  factory FDListView({
    Axis scrollDirection = Axis.vertical,
    EdgeInsets? padding,
    required List<Widget> children,
    String? rawCss,
  }) {
    return FDListView._(
      scrollDirection: scrollDirection,
      padding: padding,
      children: children,
      type: ListViewType.static,
      rawCss: rawCss,
    );
  }

  /// Builder variant
  factory FDListView.builder({
    Axis scrollDirection = Axis.vertical,
    EdgeInsets? padding,
    required int itemCount,
    required ItemWidgetBuilder itemBuilder,
    String? rawCss,
  }) {
    return FDListView._(
      scrollDirection: scrollDirection,
      padding: padding,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      type: ListViewType.builder,
      rawCss: rawCss,
    );
  }

  /// Separated variant
  factory FDListView.separated({
    Axis scrollDirection = Axis.vertical,
    EdgeInsets? padding,
    required int itemCount,
    required ItemWidgetBuilder itemBuilder,
    required SeparatorWidgetBuilder separatorBuilder,
    String? rawCss,
  }) {
    return FDListView._(
      scrollDirection: scrollDirection,
      padding: padding,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      separatorBuilder: separatorBuilder,
      type: ListViewType.separated,
      rawCss: rawCss,
    );
  }

  @override
  FlartNode buildNode(BuildContext context) {
    final styles = <String, String>{
      'display': 'flex',
      'flex-direction': scrollDirection == Axis.vertical ? 'column' : 'row',
      'overflow': scrollDirection == Axis.vertical ? 'auto' : 'auto hidden',
    };

    if (padding != null) {
      styles['padding'] = padding!.toCss();
    }

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
      styles: styles,
      children: childrenNodes,
    );
  }
}
