import '../../../flartdart.dart';

/// A widget that embeds an iframe
class FDIframe extends Widget {
  final String src;
  final double? width;
  final double? height;
  final String? title;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  FDIframe({
    required this.src,
    this.width,
    this.height,
    this.title,
    this.cssStyle,
    this.rawCss,
  });

  @override
  String render(BuildContext context) {
    final style = {
      'border': 'none',
      if (width != null) 'width': '${width}px',
      if (height != null) 'height': '${height}px',
      if (width == null) 'width': '100%',
      if (height == null) 'height': '100%',
      ...?cssStyle,
    }.entries.map((e) => '${e.key}: ${e.value};').join(' ');

    return '''
      <iframe 
        src="$src" 
        title="${title ?? ''}" 
        style="$style ${rawCss ?? ''}"
        allowfullscreen
      ></iframe>
    ''';
  }
}

/// A wrapper for standard HTML anchor tags
class FDLink extends Widget {
  final String url;
  final Widget child;
  final bool openInNewTab;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  FDLink({
    required this.url,
    required this.child,
    this.openInNewTab = true,
    this.cssStyle,
    this.rawCss,
  });

  @override
  String render(BuildContext context) {
    final style = {
      'text-decoration': 'none',
      'color': 'inherit',
      'cursor': 'pointer',
      ...?cssStyle,
    }.entries.map((e) => '${e.key}: ${e.value};').join(' ');

    return '''
      <a 
        href="$url" 
        target="${openInNewTab ? '_blank' : '_self'}" 
        rel="${openInNewTab ? 'noopener noreferrer' : ''}"
        style="$style ${rawCss ?? ''}"
        allowfullscreen
      >
        ${child.render(context)}
      </a>
    ''';
  }
}
