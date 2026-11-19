import '../../../flartdart.dart';

/// Flutter compatibility typedefs
typedef FDVideoPlayer = VideoPlayer;
typedef Video = VideoPlayer;
typedef FDAudioPlayer = AudioPlayer;
typedef Audio = AudioPlayer;
typedef FDIframe = IFrame;
typedef FDYouTubePlayer = YouTubePlayer;
typedef FDMapEmbed = MapEmbed;

/// A video player widget.
class VideoPlayer extends Widget {
  final String src;
  final double? width;
  final double? height;
  final bool autoplay;
  final bool controls;
  final bool loop;
  final bool muted;
  final String? poster;
  final BorderRadius? borderRadius;
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
    this.borderRadius,
    this.onPlay,
    this.onPause,
    this.onEnded,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final radius = borderRadius?.topLeft ?? 8.0;

    final styles = <String, String>{
      'max-width': '100%',
      'border-radius': '${radius}px',
      'background-color': '#000000',
      if (width != null) 'width': '${width}px',
      if (height != null) 'height': '${height}px',
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

/// An audio player widget.
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

/// An iframe widget for embedding external web content.
class IFrame extends Widget {
  final String src;
  final double? width;
  final double? height;
  final String? title;
  final bool allowFullscreen;
  final String? sandbox;
  final BorderRadius? borderRadius;
  final Border? border;

  const IFrame({
    required this.src,
    this.width,
    this.height,
    this.title,
    this.allowFullscreen = true,
    this.sandbox,
    this.borderRadius,
    this.border,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final radius = borderRadius?.topLeft ?? 8.0;

    final styles = <String, String>{
      'border': border != null ? border!.toCss()['border'] ?? 'none' : 'none',
      'border-radius': '${radius}px',
      'width': width != null ? '${width}px' : '100%',
      if (height != null) 'height': '${height}px',
      'box-sizing': 'border-box',
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

/// A YouTube video embed widget.
class YouTubePlayer extends Widget {
  final String videoId;
  final double? width;
  final double? height;
  final bool autoplay;
  final bool controls;
  final bool loop;
  final bool muted;
  final BorderRadius? borderRadius;

  const YouTubePlayer({
    required this.videoId,
    this.width,
    this.height,
    this.autoplay = false,
    this.controls = true,
    this.loop = false,
    this.muted = false,
    this.borderRadius,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final w = width ?? 560;
    final h = height ?? 315;
    final radius = borderRadius?.topLeft ?? 8.0;

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
        'allow':
            'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture',
        'allowfullscreen': 'true',
      },
      styles: {
        'border-radius': '${radius}px',
        'border': 'none',
      },
    );
  }
}

/// A widget to embed interactive maps.
class MapEmbed extends Widget {
  final String location;
  final double? width;
  final double? height;
  final int zoom;
  final BorderRadius? borderRadius;

  const MapEmbed({
    required this.location,
    this.width,
    this.height,
    this.zoom = 15,
    this.borderRadius,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final w = width ?? 600;
    final h = height ?? 450;
    final radius = borderRadius?.topLeft ?? 8.0;
    final encodedLocation = Uri.encodeComponent(location);

    return FlartElementNode(
      'iframe',
      id: key?.toString(),
      attributes: {
        'width': w.toString(),
        'height': h.toString(),
        'loading': 'lazy',
        'allowfullscreen': 'true',
        'src':
            'https://maps.google.com/maps?q=$encodedLocation&z=$zoom&output=embed',
      },
      styles: {
        'border': '0',
        'border-radius': '${radius}px',
      },
    );
  }
}
