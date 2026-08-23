import 'package:flartdart/flartdart.dart';
import '../widgets/showcase_card.dart';

class BasicShowcase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FDColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FDText(
          'Basic Widgets',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: FlartColor('#0f172a'),
          ),
        ),
        FDSizedBox(height: 8),
        FDText(
          'The fundamental building blocks for creating user interfaces.',
          style: TextStyle(
            fontSize: 16,
            color: FlartColor('#64748b'),
          ),
        ),
        FDSizedBox(height: 32),

        // Text Showcase
        ShowcaseCard(
          title: 'FDText',
          description: 'A run of text with a single style.',
          child: FDText(
            'This is an example of FDText widget in FlartDart!',
            style: TextStyle(
              fontSize: 18,
              color: FlartColor('#3b82f6'),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // Container Showcase
        ShowcaseCard(
          title: 'FDContainer',
          description:
              'A convenience widget that combines common painting, positioning, and sizing widgets.',
          child: FDContainer(
            width: 200,
            height: 100,
            decoration: BoxDecoration(
              color: FlartColor('#ec4899'),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: FlartColor('#ec4899').withOpacity(0.4),
                  blurRadius: 15,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: FDCenter(
              child: FDText(
                'Container',
                style: TextStyle(
                    color: FlartColor('#ffffff'), fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),

        // Icon Showcase
        ShowcaseCard(
          title: 'FDIcon',
          description:
              'A graphical icon widget drawn with a glyph from a font described in an IconData.',
          child: FDRow(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FDIcon(
                  icon: FDIcons.home, color: FlartColor('#10b981'), size: 48),
              FDSizedBox(width: 24),
              FDIcon(
                  icon: FDIcons.favorite,
                  color: FlartColor('#ef4444'),
                  size: 48),
              FDSizedBox(width: 24),
              FDIcon(
                  icon: FDIcons.settings,
                  color: FlartColor('#64748b'),
                  size: 48),
            ],
          ),
        ),
      ],
    );
  }
}
