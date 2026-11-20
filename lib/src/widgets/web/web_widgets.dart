import 'package:web/web.dart' as web;
import '../../../flartdart.dart';

typedef Link = FDLink;

/// An interactive hyperlink widget wrapping any child in an anchor tag.
class FDLink extends Widget {
  final String url;
  final Widget child;
  final bool openInNewTab;
  final TextStyle? style;
  final VoidCallback? onTap;

  const FDLink({
    required this.url,
    required this.child,
    this.openInNewTab = true,
    this.style,
    this.onTap,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final styles = <String, String>{
      'text-decoration': 'none',
      'color': style?.color?.toString() ?? 'inherit',
      'cursor': 'pointer',
      if (style != null) ...style!.toCss(),
    };

    final attributes = <String, String>{
      'href': url,
      'target': openInNewTab ? '_blank' : '_self',
      if (openInNewTab) 'rel': 'noopener noreferrer',
    };

    final events = <String, void Function(web.Event)>{};
    if (onTap != null) {
      events['click'] = (e) => onTap!();
    }

    return FlartElementNode(
      'a',
      id: key?.toString(),
      key: key?.toString(),
      attributes: attributes,
      styles: styles,
      events: events.isNotEmpty ? events : null,
      children: [child.buildNode(context)],
    );
  }

  @override
  String render(BuildContext context) {
    return buildNode(context).toHtml();
  }
}
