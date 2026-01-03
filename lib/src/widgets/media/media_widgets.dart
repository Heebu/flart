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
  final String? poster; // Thumbnail image
  final VoidCallback? onPlay;
  final VoidCallback? onPause;
  final VoidCallback? onEnded;

  VideoPlayer({
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
  });

  @override
  String render(BuildContext context) {
    final id = 'video_${DateTime.now().microsecondsSinceEpoch}';

    return '''
      <video
        id="$id"
        src="$src"
        ${width != null ? 'width="${width}"' : ''}
        ${height != null ? 'height="${height}"' : ''}
        ${autoplay ? 'autoplay' : ''}
        ${controls ? 'controls' : ''}
        ${loop ? 'loop' : ''}
        ${muted ? 'muted' : ''}
        ${poster != null ? 'poster="$poster"' : ''}
        style="
          max-width: 100%;
          border-radius: 8px;
          background-color: #000;
        "
      >
        Your browser does not support the video tag.
      </video>
      
      <script>
        (function() {
          const video = document.getElementById('$id');
          ${onPlay != null ? "video.addEventListener('play', () => console.log('Video playing'));" : ''}
          ${onPause != null ? "video.addEventListener('pause', () => console.log('Video paused'));" : ''}
          ${onEnded != null ? "video.addEventListener('ended', () => console.log('Video ended'));" : ''}
        })();
      </script>
    ''';
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

  AudioPlayer({
    required this.src,
    this.autoplay = false,
    this.controls = true,
    this.loop = false,
    this.muted = false,
    this.onPlay,
    this.onPause,
    this.onEnded,
  });

  @override
  String render(BuildContext context) {
    final id = 'audio_${DateTime.now().microsecondsSinceEpoch}';

    return '''
      <audio
        id="$id"
        src="$src"
        ${autoplay ? 'autoplay' : ''}
        ${controls ? 'controls' : ''}
        ${loop ? 'loop' : ''}
        ${muted ? 'muted' : ''}
        style="width: 100%;"
      >
        Your browser does not support the audio tag.
      </audio>
      
      <script>
        (function() {
          const audio = document.getElementById('$id');
          ${onPlay != null ? "audio.addEventListener('play', () => console.log('Audio playing'));" : ''}
          ${onPause != null ? "audio.addEventListener('pause', () => console.log('Audio paused'));" : ''}
          ${onEnded != null ? "audio.addEventListener('ended', () => console.log('Audio ended'));" : ''}
        })();
      </script>
    ''';
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

  IFrame({
    required this.src,
    this.width,
    this.height,
    this.title,
    this.allowFullscreen = true,
    this.sandbox,
    this.cssStyle,
  });

  @override
  String render(BuildContext context) {
    final styles = <String, String>{
      'border': 'none',
      'border-radius': '8px',
      if (width != null) 'width': '${width}px',
      if (height != null) 'height': '${height}px',
      ...?cssStyle,
    };

    final styleString =
        styles.entries.map((e) => '${e.key}: ${e.value};').join(' ');

    return '''
      <iframe
        src="$src"
        ${title != null ? 'title="$title"' : ''}
        ${allowFullscreen ? 'allowfullscreen' : ''}
        ${sandbox != null ? 'sandbox="$sandbox"' : ''}
        style="$styleString"
      ></iframe>
    ''';
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

  YouTubePlayer({
    required this.videoId,
    this.width,
    this.height,
    this.autoplay = false,
    this.controls = true,
    this.loop = false,
    this.muted = false,
  });

  @override
  String render(BuildContext context) {
    final w = width ?? 560;
    final h = height ?? 315;

    final params = <String>[];
    if (autoplay) params.add('autoplay=1');
    if (!controls) params.add('controls=0');
    if (loop) params.add('loop=1&playlist=$videoId');
    if (muted) params.add('mute=1');

    final paramString = params.isNotEmpty ? '?${params.join('&')}' : '';

    return '''
      <iframe
        width="$w"
        height="$h"
        src="https://www.youtube.com/embed/$videoId$paramString"
        title="YouTube video player"
        frameborder="0"
        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
        allowfullscreen
        style="border-radius: 8px;"
      ></iframe>
    ''';
  }
}

/// A widget to embed maps
class MapEmbed extends Widget {
  final String location;
  final double? width;
  final double? height;
  final int zoom;

  MapEmbed({
    required this.location,
    this.width,
    this.height,
    this.zoom = 15,
  });

  @override
  String render(BuildContext context) {
    final w = width ?? 600;
    final h = height ?? 450;
    final encodedLocation = Uri.encodeComponent(location);

    return '''
      <iframe
        width="$w"
        height="$h"
        style="border: 0; border-radius: 8px;"
        loading="lazy"
        allowfullscreen
        src="https://www.google.com/maps/embed/v1/place?key=YOUR_API_KEY&q=$encodedLocation&zoom=$zoom"
      ></iframe>
    ''';
  }
}
