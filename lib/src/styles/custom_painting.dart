import '../../flartdart.dart';
import 'dart:html';

abstract class CustomPainter {
  void paint(CanvasRenderingContext2D context, num width, num height);
}

class FDCustomPaint extends Widget {
  final CustomPainter painter;
  final double width;
  final double height;

  FDCustomPaint({
    required this.painter,
    this.width = 300,
    this.height = 150,
  });

  @override
  String render(BuildContext context) {
    final id = 'canvas_${DateTime.now().millisecondsSinceEpoch}';

    // Inject canvas
    final canvasHtml =
        '<canvas id="$id" width="$width" height="$height"></canvas>';

    // After render, use Dart to draw
    Future.microtask(() {
      final canvas = document.getElementById(id) as CanvasElement?;
      if (canvas != null) {
        final ctx = canvas.context2D;
        painter.paint(ctx, width, height);
      }
    });

    return canvasHtml;
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(CanvasRenderingContext2D ctx, num width, num height) {
    ctx
      ..fillStyle = 'red'
      ..fillRect(10, 10, 100, 100);
  }
}

//useage

// FDCustomPaint(
// width: 500,
// height: 300,
// painter: MyPainter(),
// )



