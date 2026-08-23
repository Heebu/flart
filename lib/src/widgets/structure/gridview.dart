import '../../../flartdart.dart';

enum GridViewType { count, extent, builder }

class FDGridView extends Widget {
  final GridViewType type;
  final int? crossAxisCount; // for count
  final double? maxCrossAxisExtent; // for extent
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final List<Widget>? children; // count/extent
  final IndexedWidgetBuilder? itemBuilder; // builder
  final int? itemCount; // builder
  final double? childAspectRatio;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  FDGridView.count({
    required this.crossAxisCount,
    required this.children,
    this.crossAxisSpacing = 0,
    this.mainAxisSpacing = 0,
    this.childAspectRatio,
    this.cssStyle,
    this.rawCss,
  })  : type = GridViewType.count,
        itemBuilder = null,
        itemCount = null,
        maxCrossAxisExtent = null;

  FDGridView.extent({
    required this.maxCrossAxisExtent,
    required this.children,
    this.crossAxisSpacing = 0,
    this.mainAxisSpacing = 0,
    this.childAspectRatio,
    this.cssStyle,
    this.rawCss,
  })  : type = GridViewType.extent,
        itemBuilder = null,
        itemCount = null,
        crossAxisCount = null;

  FDGridView.builder({
    required this.itemBuilder,
    required this.itemCount,
    this.crossAxisCount = 2,
    this.crossAxisSpacing = 0,
    this.mainAxisSpacing = 0,
    this.childAspectRatio,
    this.cssStyle,
    this.rawCss,
  })  : type = GridViewType.builder,
        children = null,
        maxCrossAxisExtent = null;

  @override
  FlartNode buildNode(BuildContext context) {
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

    final styles = <String, String>{
      'display': 'grid',
      'grid-template-columns': type == GridViewType.extent
          ? 'repeat(auto-fit, minmax(${maxCrossAxisExtent!.toInt()}px, 1fr))'
          : 'repeat($resolvedCount, 1fr)',
      'gap': '${mainAxisSpacing}px ${crossAxisSpacing}px',
    };

    if (cssStyle != null) {
      styles.addAll(cssStyle!);
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

    final childrenNodes = builtChildren
        .map((child) => FlartElementNode(
              'div',
              children: [child.buildNode(context)],
            ))
        .toList();

    return FlartElementNode(
      'div',
      styles: styles,
      children: childrenNodes,
    );
  }
}
