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
  });
}
