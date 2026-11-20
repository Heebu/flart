import 'package:flartdart/flartdart.dart';
import '../widgets/showcase_card.dart';

class DemoCanvasPainter extends CustomPainter {
  const DemoCanvasPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()
      ..color = const FlartColor('#0f172a')
      ..style = PaintingStyle.fill;
    canvas.drawRRect(0, 0, size.width, size.height, 12, bgPaint);

    final circlePaint = Paint()
      ..color = const FlartColor('#3b82f6')
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawCircle(50, 48, 28, circlePaint);

    final innerPaint = Paint()
      ..color = const FlartColor('#10b981')
      ..style = PaintingStyle.fill;
    canvas.drawCircle(50, 48, 14, innerPaint);

    final arcPaint = Paint()
      ..color = const FlartColor('#f59e0b')
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(130, 48, 26, 0, 3.14159 * 1.5, false, arcPaint);

    final linePaint = Paint()
      ..color = const FlartColor('#ec4899')
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(190, 30, 225, 65, linePaint);
    canvas.drawLine(225, 65, 265, 25, linePaint);

    canvas.drawText('Custom Paint Engine (HTML5 Canvas)', 20, 95,
        font: 'bold 12px sans-serif', color: FlartColors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BasicShowcase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FDColumn(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FDText(
          'Category 3: Display & Painting Primitives',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: FlartColor('#1e293b'),
          ),
        ),
        const FDSizedBox(height: 8),
        FDText(
          'Complete showcase of visual leaf widgets, painting engines, clipping, scaling, and graphical primitives (no rawCss required).',
          style: TextStyle(fontSize: 16, color: FlartColor('#64748b')),
        ),
        const FDSizedBox(height: 32),

        ShowcaseCard(
          title: '1. FDCircleAvatar (Avatars & Badges)',
          description:
              'A circular avatar representing a user, icon, or placeholder image with configurable radius, background, and foreground colors.',
          child: FDRow(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const FDCircleAvatar(
                radius: 18,
                backgroundColor: FlartColor('#3b82f6'),
                child: FDText('SM', style: TextStyle(color: FlartColors.white, fontSize: 11, fontWeight: FontWeight.bold)),
              ),
              const FDCircleAvatar(
                radius: 26,
                backgroundColor: FlartColor('#10b981'),
                child: FDText('MD', style: TextStyle(color: FlartColors.white, fontSize: 14, fontWeight: FontWeight.bold)),
              ),
              const FDCircleAvatar(
                radius: 36,
                backgroundColor: FlartColor('#8b5cf6'),
                child: FDText('LG', style: TextStyle(color: FlartColors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const FDCircleAvatar(
                radius: 26,
                backgroundColor: FlartColor('#ef4444'),
                child: FDIcon(icon: FDIcons.favorite, size: 24, color: FlartColors.white),
              ),
              const FDCircleAvatar(
                radius: 26,
                backgroundColor: FlartColor('#f59e0b'),
                child: FDIcon(icon: FDIcons.star, size: 24, color: FlartColors.white),
              ),
            ],
          ),
        ),

        ShowcaseCard(
          title: '2. FDIcon (Material Icons with IconData & Tooltips)',
          description:
              'Renders crisp Material Design icon glyphs. Supports IconData, size scaling, and tooltips without jumping line heights.',
          child: FDRow(
            spacing: 24,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const FDIcon(icon: FDIcons.home, size: 28, color: FlartColor('#2563eb'), tooltip: 'Home'),
              const FDIcon(icon: FDIcons.search, size: 32, color: FlartColor('#059669'), tooltip: 'Search'),
              const FDIcon(icon: FDIcons.settings, size: 36, color: FlartColor('#7c3aed'), tooltip: 'Settings'),
              const FDIcon(icon: FDIcons.notifications, size: 40, color: FlartColor('#d97706'), tooltip: 'Alerts'),
              const FDIcon(icon: FDIcons.security, size: 44, color: FlartColor('#dc2626'), tooltip: 'Security'),
              const FDIcon(icon: FDIcons.bolt, size: 48, color: FlartColor('#0891b2'), tooltip: 'Performance'),
            ],
          ),
        ),

        ShowcaseCard(
          title: '3. FDImage (Asset & Network with BoxFit & BorderRadius)',
          description:
              'Displays images with object-fit scaling, border-radius clipping, and strict border-box sizing.',
          child: FDRow(
            spacing: 24,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FDColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMiniLabel('BoxFit.cover + borderRadius 16:'),
                  FDSizedBox(height: 8),
                  FDImage.network(
                    'https://images.unsplash.com/photo-1579546929518-9e396f3cc809?w=300',
                    width: 140,
                    height: 100,
                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ],
              ),
              FDColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMiniLabel('BoxFit.contain (framed):'),
                  FDSizedBox(height: 8),
                  FDContainer(
                    width: 140,
                    height: 100,
                    decoration: BoxDecoration(
                      color: FlartColor('#0f172a'),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: FDImage.network(
                      'https://images.unsplash.com/photo-1579546929518-9e396f3cc809?w=300',
                      width: 140,
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        ShowcaseCard(
          title: '4. FDSvgPicture (Vector Graphics & Color Fill)',
          description:
              'Renders vector SVGs via inline markup or external source with vector scaling and fill colors.',
          child: FDRow(
            spacing: 24,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FDSvgPicture.string(
                '''<svg viewBox="0 0 100 100" width="80" height="80">
                  <polygon points="50,5 95,95 5,95" fill="#3b82f6" />
                  <circle cx="50" cy="65" r="14" fill="#ffffff" />
                </svg>''',
                width: 80,
                height: 80,
              ),
              FDSvgPicture.string(
                '''<svg viewBox="0 0 100 100" width="80" height="80">
                  <circle cx="50" cy="50" r="45" fill="#10b981" />
                  <path d="M30 50 L45 65 L70 35" stroke="#ffffff" stroke-width="8" fill="none" stroke-linecap="round"/>
                </svg>''',
                width: 80,
                height: 80,
              ),
              FDSvgPicture.string(
                '''<svg viewBox="0 0 100 100" width="80" height="80">
                  <rect x="10" y="10" width="80" height="80" rx="16" fill="#8b5cf6" />
                  <path d="M50 25 L60 45 L82 45 L64 58 L71 80 L50 67 L29 80 L36 58 L18 45 L40 45 Z" fill="#fbbf24" />
                </svg>''',
                width: 80,
                height: 80,
              ),
            ],
          ),
        ),

        ShowcaseCard(
          title: '5. FDCustomPaint (HTML5 Canvas Drawing Engine)',
          description:
              'Direct 2D Canvas drawing using standard Flutter-like CustomPainter, Canvas, Paint, PaintingStyle, and StrokeCap.',
          child: const FDCustomPaint(
            painter: DemoCanvasPainter(),
            size: Size(320, 115),
          ),
        ),

        ShowcaseCard(
          title: '6. FDAspectRatio (Proportional Media Ratios)',
          description:
              'Constrains child to a target aspect ratio (e.g. 16:9, 4:3, 1:1) while adapting to available container width.',
          child: FDRow(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FDContainer(
                width: 200,
                child: FDAspectRatio(
                  aspectRatio: 16 / 9,
                  child: FDContainer(
                    decoration: BoxDecoration(
                      color: FlartColor('#1e40af'),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: const FDText(
                      '16 : 9 Widescreen',
                      style: TextStyle(color: FlartColors.white, fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ),
                ),
              ),
              FDContainer(
                width: 120,
                child: FDAspectRatio(
                  aspectRatio: 1 / 1,
                  child: FDContainer(
                    decoration: BoxDecoration(
                      color: FlartColor('#047857'),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: const FDText(
                      '1 : 1\nSquare',
                      style: TextStyle(color: FlartColors.white, fontWeight: FontWeight.bold, fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        ShowcaseCard(
          title: '7. FDClipRRect & FDClipOval (Anti-Aliased Geometry Clipping)',
          description:
              'Clips underlying children using smooth GPU anti-aliased rounded rectangles or circular ovals.',
          child: FDRow(
            spacing: 24,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FDClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FDContainer(
                  width: 140,
                  height: 90,
                  decoration: const BoxDecoration(
                    color: FlartColor('#d946ef'),
                  ),
                  alignment: Alignment.center,
                  child: const FDText(
                    'ClipRRect\n(radius 20)',
                    style: TextStyle(color: FlartColors.white, fontWeight: FontWeight.bold, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              FDClipOval(
                child: FDContainer(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: FlartColor('#0284c7'),
                  ),
                  alignment: Alignment.center,
                  child: const FDText(
                    'ClipOval',
                    style: TextStyle(color: FlartColors.white, fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
              ),
            ],
          ),
        ),

        ShowcaseCard(
          title: '8. FDOpacity (Alpha Blending & Pointer Protection)',
          description:
              'Controls layer opacity from 1.0 down to 0.0, automatically disabling pointer events at 0.0.',
          child: FDRow(
            spacing: 12,
            children: [
              _buildOpacityBox(1.0, '#3b82f6'),
              _buildOpacityBox(0.75, '#3b82f6'),
              _buildOpacityBox(0.5, '#3b82f6'),
              _buildOpacityBox(0.25, '#3b82f6'),
              _buildOpacityBox(0.1, '#3b82f6'),
            ],
          ),
        ),

        ShowcaseCard(
          title: '9. FDRotatedBox (Quarter-Turn Rotations)',
          description:
              'Rotates its child by integral number of 90-degree quarter turns.',
          child: FDRow(
            spacing: 32,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FDRotatedBox(
                quarterTurns: 0,
                child: _buildRotatedPill('0° (Normal)', '#059669'),
              ),
              FDRotatedBox(
                quarterTurns: 1,
                child: _buildRotatedPill('90° CW', '#2563eb'),
              ),
              FDRotatedBox(
                quarterTurns: 2,
                child: _buildRotatedPill('180° Inverted', '#7c3aed'),
              ),
              FDRotatedBox(
                quarterTurns: 3,
                child: _buildRotatedPill('270° CCW', '#d97706'),
              ),
            ],
          ),
        ),

        ShowcaseCard(
          title: '10. FDPlaceholder (Visual Wireframe Stub)',
          description:
              'Draws a crisp X-inscribed wireframe box representing space reserved for future components.',
          child: FDRow(
            spacing: 24,
            children: [
              const FDPlaceholder(
                fallbackWidth: 140,
                fallbackHeight: 80,
                color: FlartColor('#64748b'),
                strokeWidth: 2,
              ),
              const FDPlaceholder(
                fallbackWidth: 180,
                fallbackHeight: 80,
                color: FlartColor('#3b82f6'),
                strokeWidth: 2,
                child: FDText(
                  'Reserved Space',
                  style: TextStyle(color: FlartColor('#1e40af'), fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMiniLabel(String text) {
    return FDText(
      text,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: FlartColor('#475569'),
      ),
    );
  }

  Widget _buildOpacityBox(double opacity, String colorHex) {
    return FDOpacity(
      opacity: opacity,
      child: FDContainer(
        width: 65,
        height: 60,
        decoration: BoxDecoration(
          color: FlartColor(colorHex),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: FDText(
          '${(opacity * 100).toInt()}%',
          style: const TextStyle(
            color: FlartColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildRotatedPill(String text, String colorHex) {
    return FDContainer(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: FlartColor(colorHex),
        borderRadius: BorderRadius.circular(16),
      ),
      child: FDText(
        text,
        style: const TextStyle(
          color: FlartColors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
