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

class Path {
  final List<void Function(CanvasRenderingContext2D)> _ops = [];

  void moveTo(double x, double y) {
    _ops.add((ctx) => ctx.moveTo(x, y));
  }

  void lineTo(double x, double y) {
    _ops.add((ctx) => ctx.lineTo(x, y));
  }

  void close() {
    _ops.add((ctx) => ctx.closePath());
  }

  void apply(CanvasRenderingContext2D ctx) {
    for (final op in _ops) {
      op(ctx);
    }
  }
}

class Paint {
  FlartColor color = FlartColors.black;
  double strokeWidth = 1.0;
  String style = 'fill'; // 'fill' or 'stroke'
  String strokeCap = 'butt'; // 'butt', 'round', 'square'
  String strokeJoin = 'miter'; // 'miter', 'round', 'bevel'

  void apply(CanvasRenderingContext2D ctx) {
    if (style == 'fill') {
      ctx.fillStyle = color.toString();
    } else {
      ctx.strokeStyle = color.toString();
      ctx.lineWidth = strokeWidth;
      ctx.lineCap = strokeCap;
      ctx.lineJoin = strokeJoin;
    }
  }
}

abstract class Canvas {
  void drawRect(double x, double y, double w, double h, Paint paint);
  void drawCircle(double x, double y, double radius, Paint paint);
  void drawLine(double x1, double y1, double x2, double y2, Paint paint);
  void drawPath(Path path, Paint paint);
}

class _WebCanvas implements Canvas {
  final CanvasRenderingContext2D _ctx;
  _WebCanvas(this._ctx);

  @override
  void drawRect(double x, double y, double w, double h, Paint paint) {
    paint.apply(_ctx);
    if (paint.style == 'fill') {
      _ctx.fillRect(x, y, w, h);
    } else {
      _ctx.strokeRect(x, y, w, h);
    }
  }

  @override
  void drawCircle(double x, double y, double radius, Paint paint) {
    paint.apply(_ctx);
    _ctx.beginPath();
    _ctx.arc(x, y, radius, 0, 2 * math.pi);
    if (paint.style == 'fill') {
      _ctx.fill();
    } else {
      _ctx.stroke();
    }
  }

  @override
  void drawLine(double x1, double y1, double x2, double y2, Paint paint) {
    paint.apply(_ctx);
    _ctx.beginPath();
    _ctx.moveTo(x1, y1);
    _ctx.lineTo(x2, y2);
    _ctx.stroke();
  }

  @override
  void drawPath(Path path, Paint paint) {
    paint.apply(_ctx);
    _ctx.beginPath();
    path.apply(_ctx);
    if (paint.style == 'fill') {
      _ctx.fill();
    } else {
      _ctx.stroke();
    }
  }
}

abstract class CustomPainter {
  const CustomPainter();
  void paint(Canvas canvas, Size size);
  bool shouldRepaint(covariant CustomPainter oldDelegate);
}

class FDCustomPaint extends Widget {
  final CustomPainter painter;
  final Size size;
  final Widget? child;
  final String? rawCss;

  FDCustomPaint({
    required this.painter,
    this.size = const Size(300, 150),
    this.child,
    this.rawCss,
  });

  @override
  String render(BuildContext context) {
    final id =
        'custom_paint_${DateTime.now().microsecondsSinceEpoch}_${(math.Random().nextDouble() * 10000).toInt()}';

    Future.delayed(Duration.zero, () {
      final canvas = document.getElementById(id) as CanvasElement?;
      if (canvas != null) {
        final ctx = canvas.context2D;
        painter.paint(_WebCanvas(ctx), size);
      }
    });

    return '''
      <div style="position: relative; width: ${size.width}px; height: ${size.height}px; ${rawCss ?? ''}">
        <canvas id="$id" width="${size.width}" height="${size.height}" style="position: absolute; top: 0; left: 0;"></canvas>
        <div style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;">
          ${child?.render(context) ?? ''}
        </div>
      </div>
    ''';
  }
}
