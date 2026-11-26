import 'package:web/web.dart' as web;
import 'dart:js_interop';
import 'dart:async';
import 'dart:math' as math;
import '../../../flartdart.dart';

typedef CustomPaint = FDCustomPaint;

enum PaintingStyle {
  fill,
  stroke,
}

enum StrokeCap {
  butt,
  round,
  square,
}

enum StrokeJoin {
  miter,
  round,
  bevel,
}

class Size {
  final double width;
  final double height;
  const Size(this.width, this.height);

  static const Size zero = Size(0, 0);

  bool get isEmpty => width <= 0.0 || height <= 0.0;
  double get shortestSide => math.min(width.abs(), height.abs());
  double get longestSide => math.max(width.abs(), height.abs());
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

  void arc(
      double x, double y, double radius, double startAngle, double endAngle,
      [bool counterclockwise = false]) {
    _ops.add(
        (ctx) => ctx.arc(x, y, radius, startAngle, endAngle, counterclockwise));
  }

  void addRect(double x, double y, double w, double h) {
    _ops.add((ctx) => ctx.rect(x, y, w, h));
  }

  void addOval(double x, double y, double radiusX, double radiusY) {
    _ops.add((ctx) => ctx.ellipse(x, y, radiusX, radiusY, 0, 0, 2 * math.pi));
  }

  void apply(web.CanvasRenderingContext2D ctx) {
    for (final op in _ops) {
      op(ctx);
    }
  }
}

class Paint {
  FlartColor color;
  double strokeWidth;
  PaintingStyle _style;
  StrokeCap _strokeCap;
  StrokeJoin _strokeJoin;

  Paint({
    this.color = FlartColors.black,
    this.strokeWidth = 1.0,
    PaintingStyle style = PaintingStyle.fill,
    StrokeCap strokeCap = StrokeCap.butt,
    StrokeJoin strokeJoin = StrokeJoin.miter,
  })  : _style = style,
        _strokeCap = strokeCap,
        _strokeJoin = strokeJoin;

  PaintingStyle get style => _style;
  set style(dynamic val) {
    if (val is PaintingStyle) {
      _style = val;
    } else if (val == 'stroke') {
      _style = PaintingStyle.stroke;
    } else {
      _style = PaintingStyle.fill;
    }
  }

  StrokeCap get strokeCap => _strokeCap;
  set strokeCap(dynamic val) {
    if (val is StrokeCap) {
      _strokeCap = val;
    } else if (val == 'round') {
      _strokeCap = StrokeCap.round;
    } else if (val == 'square') {
      _strokeCap = StrokeCap.square;
    } else {
      _strokeCap = StrokeCap.butt;
    }
  }

  StrokeJoin get strokeJoin => _strokeJoin;
  set strokeJoin(dynamic val) {
    if (val is StrokeJoin) {
      _strokeJoin = val;
    } else if (val == 'round') {
      _strokeJoin = StrokeJoin.round;
    } else if (val == 'bevel') {
      _strokeJoin = StrokeJoin.bevel;
    } else {
      _strokeJoin = StrokeJoin.miter;
    }
  }

  void apply(web.CanvasRenderingContext2D ctx) {
    if (_style == PaintingStyle.fill) {
      ctx.fillStyle = color.toString().toJS;
    } else {
      ctx.strokeStyle = color.toString().toJS;
      ctx.lineWidth = strokeWidth;
      ctx.lineCap = _strokeCap.name;
      ctx.lineJoin = _strokeJoin.name;
    }
  }
}

abstract class Canvas {
  void drawRect(double x, double y, double w, double h, Paint paint);
  void drawCircle(double x, double y, double radius, Paint paint);
  void drawLine(double x1, double y1, double x2, double y2, Paint paint);
  void drawPath(Path path, Paint paint);
  void drawOval(
      double x, double y, double radiusX, double radiusY, Paint paint);
  void drawArc(double x, double y, double radius, double startAngle,
      double sweepAngle, bool useCenter, Paint paint);
  void drawRRect(
      double x, double y, double w, double h, double radius, Paint paint);
  void drawText(String text, double x, double y,
      {String? font, FlartColor? color, String? textAlign});
  void clearRect(double x, double y, double w, double h);
  void save();
  void restore();
  void translate(double dx, double dy);
  void rotate(double radians);
  void scale(double sx, [double? sy]);
  void clipRect(double x, double y, double w, double h);
  void clipPath(Path path);
  void drawColor(FlartColor color);
}

class _WebCanvas implements Canvas {
  final web.CanvasRenderingContext2D _ctx;
  _WebCanvas(this._ctx);

  @override
  void drawRect(double x, double y, double w, double h, Paint paint) {
    paint.apply(_ctx);
    if (paint.style == PaintingStyle.fill) {
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
    if (paint.style == PaintingStyle.fill) {
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
    if (paint.style == PaintingStyle.fill) {
      _ctx.fill();
    } else {
      _ctx.stroke();
    }
  }

  @override
  void drawOval(
      double x, double y, double radiusX, double radiusY, Paint paint) {
    paint.apply(_ctx);
    _ctx.beginPath();
    _ctx.ellipse(x, y, radiusX, radiusY, 0, 0, 2 * math.pi);
    if (paint.style == PaintingStyle.fill) {
      _ctx.fill();
    } else {
      _ctx.stroke();
    }
  }

  @override
  void drawArc(double x, double y, double radius, double startAngle,
      double sweepAngle, bool useCenter, Paint paint) {
    paint.apply(_ctx);
    _ctx.beginPath();
    if (useCenter) {
      _ctx.moveTo(x, y);
    }
    _ctx.arc(x, y, radius, startAngle, startAngle + sweepAngle);
    if (useCenter) {
      _ctx.closePath();
    }
    if (paint.style == PaintingStyle.fill) {
      _ctx.fill();
    } else {
      _ctx.stroke();
    }
  }

  @override
  void drawRRect(
      double x, double y, double w, double h, double radius, Paint paint) {
    paint.apply(_ctx);
    _ctx.beginPath();
    _ctx.roundRect(x, y, w, h, radius.toJS);
    if (paint.style == PaintingStyle.fill) {
      _ctx.fill();
    } else {
      _ctx.stroke();
    }
  }

  @override
  void drawText(String text, double x, double y,
      {String? font, FlartColor? color, String? textAlign}) {
    if (font != null) _ctx.font = font;
    if (color != null) _ctx.fillStyle = color.toString().toJS;
    if (textAlign != null) _ctx.textAlign = textAlign;
    _ctx.fillText(text, x, y);
  }

  @override
  void clearRect(double x, double y, double w, double h) {
    _ctx.clearRect(x, y, w, h);
  }

  @override
  void save() {
    _ctx.save();
  }

  @override
  void restore() {
    _ctx.restore();
  }

  @override
  void translate(double dx, double dy) {
    _ctx.translate(dx, dy);
  }

  @override
  void rotate(double radians) {
    _ctx.rotate(radians);
  }

  @override
  void scale(double sx, [double? sy]) {
    _ctx.scale(sx, sy ?? sx);
  }

  @override
  void clipRect(double x, double y, double w, double h) {
    _ctx.beginPath();
    _ctx.rect(x, y, w, h);
    _ctx.clip();
  }

  @override
  void clipPath(Path path) {
    _ctx.beginPath();
    path.apply(_ctx);
    _ctx.clip();
  }

  @override
  void drawColor(FlartColor color) {
    _ctx.fillStyle = color.toString().toJS;
    _ctx.fillRect(
        0, 0, _ctx.canvas.width.toDouble(), _ctx.canvas.height.toDouble());
  }
}

abstract class CustomPainter {
  const CustomPainter();
  void paint(Canvas canvas, Size size);
  bool shouldRepaint(covariant CustomPainter oldDelegate);
}

class FDCustomPaint extends Widget {
  final CustomPainter? painter;
  final CustomPainter? foregroundPainter;
  final Size size;
  final Widget? child;
  final String? rawCss;

  const FDCustomPaint({
    this.painter,
    this.foregroundPainter,
    this.size = const Size(300, 150),
    this.child,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final canvasId =
        'custom_paint_${DateTime.now().microsecondsSinceEpoch}_${(math.Random().nextDouble() * 10000).toInt()}';

    scheduleMicrotask(() {
      final canvas =
          web.document.getElementById(canvasId) as web.HTMLCanvasElement?;
      if (canvas != null) {
        final ctx = canvas.context2D;
        final webCanvas = _WebCanvas(ctx);
        if (painter != null) {
          painter!.paint(webCanvas, size);
        }
        if (foregroundPainter != null) {
          foregroundPainter!.paint(webCanvas, size);
        }
      }
    });

    final styles = <String, String>{
      'box-sizing': 'border-box',
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
