import 'package:web/web.dart' as web;
import 'dart:js_interop';
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
  final List<void Function(web.CanvasRenderingContext2D)> _ops = [];

  void moveTo(double x, double y) {
    _ops.add((ctx) => ctx.moveTo(x, y));
  }

  void lineTo(double x, double y) {
    _ops.add((ctx) => ctx.lineTo(x, y));
  }

  void close() {
    _ops.add((ctx) => ctx.closePath());
  }

  void arc(double x, double y, double radius, double startAngle, double endAngle, [bool counterclockwise = false]) {
    _ops.add((ctx) => ctx.arc(x, y, radius, startAngle, endAngle, counterclockwise));
  }

  void apply(web.CanvasRenderingContext2D ctx) {
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

  void apply(web.CanvasRenderingContext2D ctx) {
    if (style == 'fill') {
      ctx.fillStyle = color.toString().toJS;
    } else {
      ctx.strokeStyle = color.toString().toJS;
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
  void drawOval(double x, double y, double radiusX, double radiusY, Paint paint);
  void drawArc(double x, double y, double radius, double startAngle, double sweepAngle, bool useCenter, Paint paint);
  void drawRRect(double x, double y, double w, double h, double radius, Paint paint);
  void drawText(String text, double x, double y, {String? font, FlartColor? color, String? textAlign});
  void clearRect(double x, double y, double w, double h);
}

class _WebCanvas implements Canvas {
  final web.CanvasRenderingContext2D _ctx;
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

  @override
  void drawOval(double x, double y, double radiusX, double radiusY, Paint paint) {
    paint.apply(_ctx);
    _ctx.beginPath();
    _ctx.ellipse(x, y, radiusX, radiusY, 0, 0, 2 * math.pi);
    if (paint.style == 'fill') {
      _ctx.fill();
    } else {
      _ctx.stroke();
    }
  }

  @override
  void drawArc(double x, double y, double radius, double startAngle, double sweepAngle, bool useCenter, Paint paint) {
    paint.apply(_ctx);
    _ctx.beginPath();
    if (useCenter) {
      _ctx.moveTo(x, y);
    }
    _ctx.arc(x, y, radius, startAngle, startAngle + sweepAngle);
    if (useCenter) {
      _ctx.closePath();
    }
    if (paint.style == 'fill') {
      _ctx.fill();
    } else {
      _ctx.stroke();
    }
  }

  @override
  void drawRRect(double x, double y, double w, double h, double radius, Paint paint) {
    paint.apply(_ctx);
    _ctx.beginPath();
    _ctx.roundRect(x, y, w, h, radius.toJS);
    if (paint.style == 'fill') {
      _ctx.fill();
    } else {
      _ctx.stroke();
    }
  }

  @override
  void drawText(String text, double x, double y, {String? font, FlartColor? color, String? textAlign}) {
    if (font != null) _ctx.font = font;
    if (color != null) _ctx.fillStyle = color.toString().toJS;
    if (textAlign != null) _ctx.textAlign = textAlign;
    _ctx.fillText(text, x, y);
  }

  @override
  void clearRect(double x, double y, double w, double h) {
    _ctx.clearRect(x, y, w, h);
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

  const FDCustomPaint({
    required this.painter,
    this.size = const Size(300, 150),
    this.child,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final canvasId = 'custom_paint_${DateTime.now().microsecondsSinceEpoch}_${(math.Random().nextDouble() * 10000).toInt()}';

    // Trigger painting after mount
    scheduleMicrotask(() {
      final canvas = web.document.getElementById(canvasId) as web.HTMLCanvasElement?;
      if (canvas != null) {
        final ctx = canvas.context2D;
        painter.paint(_WebCanvas(ctx), size);
      }
    });

    final styles = <String, String>{
      'position': 'relative',
      'width': '${size.width}px',
      'height': '${size.height}px',
    };

    if (rawCss != null && rawCss!.isNotEmpty) {
      final pairs = rawCss!.split(';');
      for (var pair in pairs) {
        if (pair.trim().isEmpty) continue;
        final parts = pair.split(':');
        if (parts.length >= 2) {
          styles[parts[0].trim()] = parts.sublist(1).join(':').trim();
        }
      }
    }

    final children = <FlartNode>[
      FlartElementNode(
        'canvas',
        id: canvasId,
        attributes: {
          'width': '${size.width}',
          'height': '${size.height}',
        },
        styles: {
          'position': 'absolute',
          'top': '0',
          'left': '0',
          'width': '${size.width}px',
          'height': '${size.height}px',
        },
      ),
      if (child != null)
        FlartElementNode(
          'div',
          styles: {
            'position': 'absolute',
            'top': '0',
            'left': '0',
            'width': '100%',
            'height': '100%',
          },
          children: [child!.buildNode(context)],
        ),
    ];

    return FlartElementNode(
      'div',
      id: key?.toString(),
      styles: styles,
      children: children,
    );
  }
}
