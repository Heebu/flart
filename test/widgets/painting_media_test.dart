@TestOn('browser')

import 'package:flartdart/flartdart.dart';
import 'package:test/test.dart';
import 'package:web/web.dart' as web;
import '../test_utils.dart';

class TestPainter extends CustomPainter {
  bool didPaint = false;

  @override
  void paint(Canvas canvas, Size size) {
    didPaint = true;
    final paint = Paint()
      ..color = FlartColors.blue
      ..style = 'fill';
    canvas.drawRect(0, 0, size.width, size.height, paint);
    canvas.drawCircle(50, 50, 25, paint);
    canvas.drawRRect(10, 10, 80, 40, 8, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

void main() {
  group('Painting & Media Widgets', () {
    tearDown(() {
      TestUtils.unmountWidget();
    });

    test('FDCustomPaint mounts canvas and invokes painter', () async {
      final painter = TestPainter();
      final widget = FDCustomPaint(
        painter: painter,
        size: const Size(200, 100),
        child: FDText('Overlay text'),
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      final canvas = root.querySelector('canvas') as web.HTMLCanvasElement?;
      expect(canvas, isNotNull);
      expect(canvas!.width, equals(200));
      expect(canvas.height, equals(100));
      expect(root.textContent, contains('Overlay text'));

      // Microtask runs paint
      await TestUtils.pump(30);
      expect(painter.didPaint, isTrue);
    });

    test('FDSvgPicture renders inline SVG', () {
      const svgCode = '<svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/></svg>';
      final widget = FDSvgPicture.string(
        svgCode,
        width: 32,
        height: 32,
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.getElementsByTagName('svg').length, equals(1));
    });

    test('VideoPlayer mounts video tag and responds to events', () {
      bool played = false;
      final widget = VideoPlayer(
        src: 'https://example.com/video.mp4',
        width: 320,
        height: 240,
        controls: true,
        onPlay: () {
          played = true;
        },
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.tagName.toLowerCase(), equals('video'));
      expect(root.getAttribute('src'), equals('https://example.com/video.mp4'));

      root.dispatchEvent(web.Event('play'));
      expect(played, isTrue);
    });

    test('AudioPlayer mounts audio tag and responds to events', () {
      bool paused = false;
      final widget = AudioPlayer(
        src: 'https://example.com/audio.mp3',
        onPause: () {
          paused = true;
        },
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.tagName.toLowerCase(), equals('audio'));
      expect(root.getAttribute('src'), equals('https://example.com/audio.mp3'));

      root.dispatchEvent(web.Event('pause'));
      expect(paused, isTrue);
    });

    test('IFrame mounts iframe element with attributes', () {
      final widget = const IFrame(
        src: 'https://example.com/embed',
        title: 'Embedded Page',
        width: 400,
        height: 300,
        allowFullscreen: true,
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.tagName.toLowerCase(), equals('iframe'));
      expect(root.getAttribute('src'), equals('https://example.com/embed'));
      expect(root.getAttribute('title'), equals('Embedded Page'));
      expect(root.getAttribute('allowfullscreen'), equals('true'));
      expect(root.style.width, equals('400px'));
      expect(root.style.height, equals('300px'));
    });

    test('YouTubePlayer formats embed URL with autoplay and loop params', () {
      final widget = const YouTubePlayer(
        videoId: 'dQw4w9WgXcQ',
        autoplay: true,
        muted: true,
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.tagName.toLowerCase(), equals('iframe'));
      final src = root.getAttribute('src') ?? '';
      expect(src, contains('https://www.youtube.com/embed/dQw4w9WgXcQ'));
      expect(src, contains('autoplay=1'));
      expect(src, contains('mute=1'));
    });

    test('FDLink renders anchor tag with target, rel, and tap handler', () {
      bool tapped = false;
      final widget = FDLink(
        url: 'https://flutter.dev',
        openInNewTab: true,
        onTap: () {
          tapped = true;
        },
        child: const FDText('Flutter Official Site'),
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.tagName.toLowerCase(), equals('a'));
      expect(root.getAttribute('href'), equals('https://flutter.dev'));
      expect(root.getAttribute('target'), equals('_blank'));
      expect(root.getAttribute('rel'), equals('noopener noreferrer'));
      expect(root.textContent, contains('Flutter Official Site'));

      TestUtils.click(root);
      expect(tapped, isTrue);
    });

    test('FDElement renders custom native HTML tags and handles events', () {
      bool clicked = false;
      final widget = FDElement(
        tag: 'button',
        attributes: {'aria-label': 'Custom Native Button'},
        styles: {'padding': '8px 16px', 'background-color': '#10b981'},
        textContent: 'Custom Action',
        events: {
          'click': (e) {
            clicked = true;
          },
        },
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.tagName.toLowerCase(), equals('button'));
      expect(root.getAttribute('aria-label'), equals('Custom Native Button'));
      expect(root.textContent, equals('Custom Action'));

      TestUtils.click(root);
      expect(clicked, isTrue);
    });

    test('FDRawHTML injects raw HTML into the VDOM hierarchy', () {
      final widget = const FDRawHTML(
        '<div class="raw-badge" style="color: purple;"><strong>Bold Content</strong></div>',
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.textContent, contains('Bold Content'));
      final strong = root.querySelector('strong');
      expect(strong, isNotNull);
      expect(strong!.textContent, equals('Bold Content'));
    });
  });
}
