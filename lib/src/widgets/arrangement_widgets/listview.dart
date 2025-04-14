import '../../enums/axis.dart';
import '../../styles/build_context.dart';
import '../widget.dart';
import '../../styles/edge_insets.dart';

typedef ItemWidgetBuilder = Widget Function(BuildContext context, int index);
typedef SeparatorWidgetBuilder = Widget Function(BuildContext context, int index);

enum ListViewType { static, builder, separated }

class ListView extends Widget {
  final Axis scrollDirection;
  final EdgeInsets? padding;
  final List<Widget>? children;
  final int? itemCount;
  final ItemWidgetBuilder? itemBuilder;
  final SeparatorWidgetBuilder? separatorBuilder;
  final ListViewType type;

  ListView._({
    this.scrollDirection = Axis.vertical,
    this.padding,
    this.children,
    this.itemCount,
    this.itemBuilder,
    this.separatorBuilder,
    required this.type,
  });

  /// Regular children list
  factory ListView({
    Axis scrollDirection = Axis.vertical,
    EdgeInsets? padding,
    required List<Widget> children,
  }) {
    return ListView._(
      scrollDirection: scrollDirection,
      padding: padding,
      children: children,
      type: ListViewType.static,
    );
  }

  /// Builder variant
  factory ListView.builder({
    Axis scrollDirection = Axis.vertical,
    EdgeInsets? padding,
    required int itemCount,
    required ItemWidgetBuilder itemBuilder,
  }) {
    return ListView._(
      scrollDirection: scrollDirection,
      padding: padding,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      type: ListViewType.builder,
    );
  }

  /// Separated variant
  factory ListView.separated({
    Axis scrollDirection = Axis.vertical,
    EdgeInsets? padding,
    required int itemCount,
    required ItemWidgetBuilder itemBuilder,
    required SeparatorWidgetBuilder separatorBuilder,
  }) {
    return ListView._(
      scrollDirection: scrollDirection,
      padding: padding,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      separatorBuilder: separatorBuilder,
      type: ListViewType.separated,
    );
  }

  @override
  String render() {
    final styleMap = <String, String>{
      'display': 'flex',
      'flex-direction': scrollDirection == Axis.vertical ? 'column' : 'row',
      'overflow': scrollDirection == Axis.vertical ? 'auto' : 'auto hidden',
      if (padding != null) 'padding': padding!.toCss(),
    };

    final styleString = styleMap.entries.map((e) => '${e.key}: ${e.value};').join(' ');

    String content = '';

    switch (type) {
      case ListViewType.static:
        content = children!.map((c) => c.render()).join();
        break;

      case ListViewType.builder:
        content = List.generate(itemCount!, (i) => itemBuilder!(BuildContext(), i).render()).join();
        break;

      case ListViewType.separated:
        final buffer = StringBuffer();
        for (int i = 0; i < itemCount!; i++) {
          buffer.write(itemBuilder!(BuildContext(), i).render());
          if (i < itemCount! - 1) {
            buffer.write(separatorBuilder!(BuildContext(), i).render());
          }
        }
        content = buffer.toString();
        break;
    }

    return '<div style="$styleString">$content</div>';
  }
}
