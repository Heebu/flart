import '../../../flart.dart';
import '../../enums/indexed_widget_bulder.dart';

enum GridViewType { count, extent, builder }

class GridView extends Widget {
  final GridViewType type;
  final int? crossAxisCount;       // for count
  final double? maxCrossAxisExtent; // for extent
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final List<Widget>? children;     // count/extent
  final IndexedWidgetBuilder? itemBuilder; // builder
  final int? itemCount;             // builder
  final double? childAspectRatio;
  final Map<String, String>? cssStyle;

  GridView.count({
    required this.crossAxisCount,
    required this.children,
    this.crossAxisSpacing = 0,
    this.mainAxisSpacing = 0,
    this.childAspectRatio,
    this.cssStyle,
  })  : type = GridViewType.count,
        itemBuilder = null,
        itemCount = null,
        maxCrossAxisExtent = null;

  GridView.extent({
    required this.maxCrossAxisExtent,
    required this.children,
    this.crossAxisSpacing = 0,
    this.mainAxisSpacing = 0,
    this.childAspectRatio,
    this.cssStyle,
  })  : type = GridViewType.extent,
        itemBuilder = null,
        itemCount = null,
        crossAxisCount = null;

  GridView.builder({
    required this.itemBuilder,
    required this.itemCount,
    this.crossAxisCount = 2,
    this.crossAxisSpacing = 0,
    this.mainAxisSpacing = 0,
    this.childAspectRatio,
    this.cssStyle,
  })  : type = GridViewType.builder,
        children = null,
        maxCrossAxisExtent = null;

  @override
  String render(BuildContext context) {
    int resolvedCount = crossAxisCount ?? 2;
    List<Widget> builtChildren = [];

    switch (type) {
      case GridViewType.count:
      case GridViewType.extent:
        builtChildren = children ?? [];
        break;
      case GridViewType.builder:
        if (itemBuilder != null && itemCount != null) {
          for (int i = 0; i < itemCount!; i++) {
            builtChildren.add(itemBuilder!(i));
          }
        }
        break;
    }

    final styleMap = <String, String>{
      'display': 'grid',
      if (type == GridViewType.extent)
        'grid-template-columns':
        'repeat(auto-fit, minmax(${maxCrossAxisExtent!.toInt()}px, 1fr))'
      else
        'grid-template-columns': 'repeat($resolvedCount, 1fr)',
      'gap': '${mainAxisSpacing}px ${crossAxisSpacing}px',
      if (cssStyle != null) ...cssStyle!,
    };

    final styleString =
    styleMap.entries.map((e) => '${e.key}: ${e.value};').join(' ');

    final childrenHtml = builtChildren
        .map((child) => '<div>${child.render(context)}</div>')
        .join();

    return '<div style="$styleString">$childrenHtml</div>';
  }
}
