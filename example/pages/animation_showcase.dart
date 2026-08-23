import 'package:flartdart/flartdart.dart';
import '../widgets/showcase_card.dart';

class AnimationShowcase extends StatefulWidget {
  @override
  State<AnimationShowcase> createState() => _AnimationShowcaseState();
}

class _AnimationShowcaseState extends State<AnimationShowcase> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return FDColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FDText(
          'Animation Widgets',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: FlartColor('#0f172a'),
          ),
        ),
        FDSizedBox(height: 8),
        FDText(
          'Widgets that animate properties over time.',
          style: TextStyle(
            fontSize: 16,
            color: FlartColor('#64748b'),
          ),
        ),
        FDSizedBox(height: 32),

        // AnimatedContainer Showcase
        ShowcaseCard(
          title: 'FDAnimatedContainer',
          description:
              'A container that gradually changes its values over a period of time.',
          child: FDColumn(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FDContainer(
                cssStyle: {
                  'transition': 'all 0.5s ease-in-out',
                  'width': '${_isExpanded ? 300 : 100}px',
                  'height': '${_isExpanded ? 150 : 100}px',
                  'background-color': _isExpanded ? '#10b981' : '#3b82f6',
                  'border-radius': '${_isExpanded ? 30 : 8}px',
                  if (_isExpanded)
                    'box-shadow': '0 10px 20px rgba(16, 185, 129, 0.5)',
                },
                child: FDCenter(
                  child: FDText(
                    _isExpanded ? 'Expanded!' : 'Tap Button',
                    style: TextStyle(
                        color: FlartColor('#ffffff'),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              FDSizedBox(height: 24),
              FDElevatedButton(
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: FDIcon(
                    icon: FDIcons.favorite,
                    color: FlartColor('#ffffff'),
                    size: 40),
                cssStyle: {
                  'background-color': '#0f172a',
                  'padding': '10px 20px',
                  'border-radius': '6px',
                  'border': 'none',
                  'cursor': 'pointer',
                },
              ),
            ],
          ),
        ),

        // Hero Showcase
        ShowcaseCard(
          title: 'FDHero',
          description:
              'A widget that flies from one screen to another. (Requires navigation to fully demonstrate, but here is the base structure)',
          child: Hero(
            tag: 'showcase-hero',
            child: FDContainer(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: FlartColor('#f59e0b'),
                borderRadius: BorderRadius.circular(50),
              ),
              child: FDCenter(
                child: FDIcon(
                  icon: FDIcons.favorite,
                  color: FlartColor('#ffffff'),
                  size: 40,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
