import '../../../flartdart.dart';

/// A video player widget
class VideoPlayer extends Widget {
  final String src;
  final double? width;
  final double? height;
  final bool autoplay;
  final bool controls;
  final bool loop;
  final bool muted;
  final String? poster;
  final VoidCallback? onPlay;
  final VoidCallback? onPause;
  final VoidCallback? onEnded;

  const VideoPlayer({
    required this.src,
    this.width,
    this.height,
    this.autoplay = false,
    this.controls = true,
    this.loop = false,
    this.muted = false,
    this.poster,
    this.onPlay,
    this.onPause,
    this.onEnded,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final styles = <String, String>{
      'max-width': '100%',
      'border-radius': '8px',
      'background-color': '#000',
    };

    final attributes = <String, String>{
      'src': src,
      if (width != null) 'width': width.toString(),
      if (height != null) 'height': height.toString(),
      if (autoplay) 'autoplay': 'true',
      if (controls) 'controls': 'true',
      if (loop) 'loop': 'true',
      if (muted) 'muted': 'true',
      if (poster != null) 'poster': poster!,
    };

    return FlartElementNode(
      'video',
      id: key?.toString(),
      attributes: attributes,
      styles: styles,
      events: {
        if (onPlay != null) 'play': (_) => onPlay!(),
        if (onPause != null) 'pause': (_) => onPause!(),
        if (onEnded != null) 'ended': (_) => onEnded!(),
      },
    );
  }
}

/// An audio player widget
class AudioPlayer extends Widget {
  final String src;
  final bool autoplay;
  final bool controls;
  final bool loop;
  final bool muted;
  final VoidCallback? onPlay;
  final VoidCallback? onPause;
  final VoidCallback? onEnded;

  const AudioPlayer({
    required this.src,
    this.autoplay = false,
    this.controls = true,
    this.loop = false,
    this.muted = false,
    this.onPlay,
    this.onPause,
    this.onEnded,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final attributes = <String, String>{
      'src': src,
      if (autoplay) 'autoplay': 'true',
      if (controls) 'controls': 'true',
      if (loop) 'loop': 'true',
      if (muted) 'muted': 'true',
    };

    return FlartElementNode(
      'audio',
      id: key?.toString(),
      attributes: attributes,
      styles: {'width': '100%'},
      events: {
        if (onPlay != null) 'play': (_) => onPlay!(),
        if (onPause != null) 'pause': (_) => onPause!(),
        if (onEnded != null) 'ended': (_) => onEnded!(),
      },
    );
  }
}

/// An iframe widget for embedding external content
class IFrame extends Widget {
  final String src;
  final double? width;
  final double? height;
  final String? title;
  final bool allowFullscreen;
  final String? sandbox;
  final Map<String, String>? cssStyle;

  const IFrame({
    required this.src,
    this.width,
    this.height,
    this.title,
    this.allowFullscreen = true,
    this.sandbox,
    this.cssStyle,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final styles = <String, String>{
      'border': 'none',
      'border-radius': '8px',
      if (width != null) 'width': '${width}px',
      if (height != null) 'height': '${height}px',
      ...?cssStyle,
    };

    final attributes = <String, String>{
      'src': src,
      if (title != null) 'title': title!,
      if (allowFullscreen) 'allowfullscreen': 'true',
      if (sandbox != null) 'sandbox': sandbox!,
    };

    return FlartElementNode(
      'iframe',
      id: key?.toString(),
      attributes: attributes,
      styles: styles,
    );
  }
}

/// A YouTube video embed widget
class YouTubePlayer extends Widget {
  final String videoId;
  final double? width;
  final double? height;
  final bool autoplay;
  final bool controls;
  final bool loop;
  final bool muted;

  const YouTubePlayer({
    required this.videoId,
    this.width,
    this.height,
    this.autoplay = false,
    this.controls = true,
    this.loop = false,
    this.muted = false,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final w = width ?? 560;
    final h = height ?? 315;

    final params = <String>[];
    if (autoplay) params.add('autoplay=1');
    if (!controls) params.add('controls=0');
    if (loop) params.add('loop=1&playlist=$videoId');
    if (muted) params.add('mute=1');

    final paramString = params.isNotEmpty ? '?${params.join('&')}' : '';

    return FlartElementNode(
      'iframe',
      id: key?.toString(),
      attributes: {
        'width': w.toString(),
        'height': h.toString(),
        'src': 'https://www.youtube.com/embed/$videoId$paramString',
        'title': 'YouTube video player',
        'frameborder': '0',
        'allow': 'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture',
        'allowfullscreen': 'true',
      },
      styles: {'border-radius': '8px'},
    );
  }
}

/// A widget to embed maps
class MapEmbed extends Widget {
  final String location;
  final double? width;
  final double? height;
  final int zoom;

  const MapEmbed({
    required this.location,
    this.width,
    this.height,
    this.zoom = 15,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final w = width ?? 600;
    final h = height ?? 450;
    final encodedLocation = Uri.encodeComponent(location);

    return FlartElementNode(
      'iframe',
      id: key?.toString(),
      attributes: {
        'width': w.toString(),
        'height': h.toString(),
        'loading': 'lazy',
        'allowfullscreen': 'true',
        'src': 'https://www.google.com/maps/embed/v1/place?key=YOUR_API_KEY&q=$encodedLocation&zoom=$zoom',
      },
      styles: {
        'border': '0',
        'border-radius': '8px',
      },
    );
  }
}
