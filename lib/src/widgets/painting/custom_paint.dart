import 'dart:html';
import 'dart:async';
import 'dart:math' as math;
import '../../../flartdart.dart';

class Size {
  final double width;
  final double height;
  const Size(this.width, this.height);

  static const Size zero = Size(0, 0);
}

abstract class CustomPainter {
  const CustomPainter();
  void paint(CanvasRenderingContext2D canvas, Size size);
  bool shouldRepaint(covariant CustomPainter oldDelegate);
}

class FDCustomPaint extends Widget {
  final CustomPainter painter;
  final Size size;
  final Widget? child;

  FDCustomPaint({
    required this.painter,
    this.size = const Size(300, 150),
    this.child,
  });

  @override
  String render(BuildContext context) {
    final id =
        'custom_paint_${DateTime.now().microsecondsSinceEpoch}_${(math.Random().nextDouble() * 10000).toInt()}';

    Future.delayed(Duration.zero, () {
      final canvas = document.getElementById(id) as CanvasElement?;
      if (canvas != null) {
        final ctx = canvas.context2D;
        painter.paint(ctx, size);
      }
    });

    return '''
      <div style="position: relative; width: ${size.width}px; height: ${size.height}px;">
        <canvas id="$id" width="${size.width}" height="${size.height}" style="position: absolute; top: 0; left: 0;"></canvas>
        <div style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;">
          ${child?.render(context) ?? ''}
        </div>
      </div>
    ''';
  }
}



