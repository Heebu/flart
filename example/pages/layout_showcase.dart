import 'package:flartdart/flartdart.dart';
import '../widgets/showcase_card.dart';

class LayoutShowcase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FDColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FDText(
          'Layout Widgets',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: FlartColor('#0f172a'),
          ),
        ),
        FDSizedBox(height: 8),
        FDText(
          'Widgets used to arrange other widgets in horizontal, vertical, or layered layouts.',
          style: TextStyle(
            fontSize: 16,
            color: FlartColor('#64748b'),
          ),
        ),
        FDSizedBox(height: 32),

        // Row Showcase
        ShowcaseCard(
          title: 'FDRow',
          description:
              'A widget that displays its children in a horizontal array.',
          child: FDRow(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildColorBox('#3b82f6'),
              _buildColorBox('#10b981'),
              _buildColorBox('#f59e0b'),
            ],
          ),
        ),

        // Column Showcase
        ShowcaseCard(
          title: 'FDColumn',
          description:
              'A widget that displays its children in a vertical array.',
          child: FDColumn(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildColorBox('#ef4444'),
              FDSizedBox(height: 10),
              _buildColorBox('#8b5cf6'),
              FDSizedBox(height: 10),
              _buildColorBox('#06b6d4'),
            ],
          ),
        ),

        // Stack Showcase
        ShowcaseCard(
          title: 'FDStack & FDPositioned',
          description:
              'A widget that positions its children relative to the edges of its box. Useful for overlapping widgets.',
          child: FDContainer(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: FlartColor('#e2e8f0'),
              borderRadius: BorderRadius.circular(16),
            ),
            child: FDStack(
              children: [
                FDPositioned(
                  top: 20,
                  left: 20,
                  child: _buildColorBox('#3b82f6', size: 100),
                ),
                FDPositioned(
                  bottom: 20,
                  right: 20,
                  child: _buildColorBox('#10b981', size: 100),
                ),
                FDPositioned(
                  top: 100,
                  left: 100,
                  child: FDContainer(
                    cssStyle: {'transform': 'translate(-50%, -50%)'},
                    child: _buildColorBox('#f59e0b', size: 80),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Wrap Showcase
        ShowcaseCard(
          title: 'FDWrap',
          description:
              'A widget that displays its children in multiple horizontal or vertical runs.',
          child: FDWrap(
            spacing: 16,
            runSpacing: 16,
            children: List.generate(
                8,
                (index) => _buildColorBox(
                    index % 2 == 0 ? '#6366f1' : '#ec4899',
                    size: 60)),
          ),
        ),
      ],
    );
  }

  Widget _buildColorBox(String hexColor, {double size = 50}) {
    return FDContainer(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: FlartColor(hexColor),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: FlartColor(hexColor).withOpacity(0.4),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
    );
  }
}
