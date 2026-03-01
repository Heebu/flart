import 'package:flartdart/flartdart.dart';

void main() {
  runApp(const PainterApp());
}

class PainterApp extends StatelessWidget {
  const PainterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FDMaterialApp(
      title: 'Advanced Custom Painting',
      home: FDScaffold(
        appBar: FDAppBar(title: FDText('Custom Painting v2')),
        body: FDCenter(
          child: FDCustomPaint(
            painter: ModernPainter(),
            size: Size(300, 300),
          ),
        ),
      ),
    );
  }
}

class ModernPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // 1. Draw Background Rect with fill
    final bgPaint = Paint()
      ..color = FlartColors.grey[100]!
      ..style = 'fill';
    canvas.drawRect(0, 0, size.width, size.height, bgPaint);

    // 2. Draw Outlined Rect
    final borderPaint = Paint()
      ..color = FlartColors.blue
      ..style = 'stroke'
      ..strokeWidth = 4.0;
    canvas.drawRect(5, 5, size.width - 10, size.height - 10, borderPaint);

    // 3. Draw Circle
    final circlePaint = Paint()
      ..color = FlartColors.amber
      ..style = 'fill';
    canvas.drawCircle(centerX, centerY, 60, circlePaint);

    // 4. Draw Lines
    final linePaint = Paint()
      ..color = FlartColors.red
      ..strokeWidth = 5.0
      ..strokeCap = 'round'
      ..style = 'stroke';
    canvas.drawLine(50, 50, size.width - 50, size.height - 50, linePaint);
    canvas.drawLine(size.width - 50, 50, 50, size.height - 50, linePaint);

    // 5. Draw Path (Triangle)
    final path = Path();
    path.moveTo(centerX, 20);
    path.lineTo(centerX - 30, 80);
    path.lineTo(centerX + 30, 80);
    path.close();

    final pathPaint = Paint()
      ..color = FlartColors.purple
      ..style = 'fill';
    canvas.drawPath(path, pathPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
