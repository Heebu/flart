import 'package:flartdart/flartdart.dart';
import '../widgets/showcase_card.dart';

class StructureShowcase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FDColumn(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FDText(
          'Category 1: Structural & Layout Widgets',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: FlartColor('#1e293b'),
          ),
        ),
        const FDSizedBox(height: 8),
        FDText(
          'Complete showcase demonstrating all usage patterns and fixed box-model behaviors (no rawCss required).',
          style: TextStyle(fontSize: 16, color: FlartColor('#64748b')),
        ),
        const FDSizedBox(height: 32),

        ShowcaseCard(
          title: '1. FDContainer (Box-Sizing & Constraints)',
          description:
              'Demonstrating box-sizing: border-box (width includes padding without expansion), BoxConstraints, gradient decorations, and Clip.antiAlias.',
          child: FDColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FDRow(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FDContainer(
                    width: 180,
                    height: 100,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const FlartColor('#3b82f6'),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: const FDText(
                      '180x100 (pad 20)\nStays 180px!',
                      style: TextStyle(color: FlartColors.white, fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  FDContainer(
                    constraints: const BoxConstraints(
                      minWidth: 140,
                      maxWidth: 200,
                      minHeight: 100,
                    ),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const FlartColor('#10b981'),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: const FDText(
                      'BoxConstraints\n(min:140, max:200)',
                      style: TextStyle(color: FlartColors.white, fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  FDContainer(
                    width: 140,
                    height: 100,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const FlartColor('#ef4444'), width: 2),
                    ),
                    child: FDContainer(
                      width: 200,
                      height: 200,
                      color: const FlartColor('#fecaca'),
                      alignment: Alignment.center,
                      child: const FDText(
                        'Clipped Child',
                        style: TextStyle(color: FlartColor('#b91c1c'), fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        ShowcaseCard(
          title: '2. New Primitives: FDDecoratedBox & FDColoredBox',
          description:
              'Dedicated single-responsibility styling primitives built strictly on box-sizing: border-box.',
          child: FDRow(
            spacing: 20,
            children: [
              FDColoredBox(
                color: const FlartColor('#6366f1'),
                child: FDPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: const FDText(
                    'FDColoredBox (Pure solid color)',
                    style: TextStyle(color: FlartColors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              FDDecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [const FlartColor('#ec4899'), const FlartColor('#8b5cf6')],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const FlartColor('#ec4899').withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: FDPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: const FDText(
                    'FDDecoratedBox (Gradient + Shadow)',
                    style: TextStyle(color: FlartColors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),

        ShowcaseCard(
          title: '3. FDSizedBox (All Constructors)',
          description:
              'FDSizedBox.square, FDSizedBox.shrink, and fixed width/height empty spacers.',
          child: FDRow(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const FDSizedBox.square(
                dimension: 64,
                child: FDColoredBox(
                  color: FlartColor('#0284c7'),
                  child: FDCenter(
                    child: FDIcon(icon: FDIcons.star, color: FlartColors.white, size: 28),
                  ),
                ),
              ),
              const FDSizedBox(
                width: 120,
                height: 48,
                child: FDColoredBox(
                  color: FlartColor('#0f766e'),
                  child: FDCenter(
                    child: FDText('Fixed 120x48', style: TextStyle(color: FlartColors.white)),
                  ),
                ),
              ),
              const FDText('Spacing via FDSizedBox(width: 32) ->'),
              const FDSizedBox(width: 32),
              const FDText('<- Spaced!'),
            ],
          ),
        ),

        ShowcaseCard(
          title: '4. FDCard (Elevation, Borders, and Clipping)',
          description:
              'Cards with elevation shadows, custom borders, and Clip.antiAlias for rounded corners.',
          child: FDRow(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FDExpanded(
                child: FDCard(
                  elevation: 6,
                  padding: const EdgeInsets.all(20),
                  borderRadius: BorderRadius.circular(12),
                  child: const FDColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FDText('Elevated Card (elevation: 6)',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      FDSizedBox(height: 6),
                      FDText('Standard material depth with smooth elevation shadow.'),
                    ],
                  ),
                ),
              ),
              FDExpanded(
                child: FDCard(
                  elevation: 0,
                  border: Border.all(color: const FlartColor('#cbd5e1'), width: 1.5),
                  padding: const EdgeInsets.all(20),
                  borderRadius: BorderRadius.circular(12),
                  child: const FDColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FDText('Outlined Card (elevation: 0)',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      FDSizedBox(height: 6),
                      FDText('Clean border outline without elevation shadow.'),
                    ],
                  ),
                ),
              ),
              FDExpanded(
                child: FDCard(
                  elevation: 2,
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(16),
                  padding: EdgeInsets.zero,
                  child: FDColumn(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FDColoredBox(
                        color: const FlartColor('#f59e0b'),
                        child: const FDPadding(
                          padding: EdgeInsets.all(12),
                          child: FDText(
                            'Clipped Header (antiAlias)',
                            style: TextStyle(color: FlartColors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const FDPadding(
                        padding: EdgeInsets.all(16),
                        child: FDText('Header perfectly clipped to card corners.'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        ShowcaseCard(
          title: '5. FDFloatingActionButton (Standard, Mini, Extended)',
          description:
              'Fixed FAB positioning: standard 56px circular, mini 40px, and extended mode with icon + label.',
          child: FDRow(
            spacing: 24,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FDFloatingActionButton(
                onPressed: () {},
                backgroundColor: const FlartColor('#2563eb'),
                child: const FDIcon(icon: FDIcons.add, color: FlartColors.white),
              ),
              const FDFloatingActionButton(
                mini: true,
                backgroundColor: FlartColor('#059669'),
                child: FDIcon(icon: FDIcons.edit, color: FlartColors.white, size: 20),
              ),
              FDFloatingActionButton.extended(
                onPressed: () {},
                backgroundColor: const FlartColor('#7c3aed'),
                icon: const FDIcon(icon: FDIcons.send, color: FlartColors.white),
                label: const FDText('Compose Email', style: TextStyle(color: FlartColors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),

        ShowcaseCard(
          title: '6. FDDivider & FDVerticalDivider',
          description:
              'Dividers with indentation and vertical dividers stretching properly in flex rows without collapsing.',
          child: FDColumn(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const FDText('Horizontal divider with indent: 40 & endIndent: 40:'),
              const FDSizedBox(height: 8),
              const FDDivider(
                thickness: 2,
                indent: 40,
                endIndent: 40,
                color: FlartColor('#3b82f6'),
              ),
              const FDSizedBox(height: 16),
              const FDText('Vertical dividers in a row (align-self: stretch):'),
              const FDSizedBox(height: 8),
              const FDContainer(
                height: 48,
                child: FDRow(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FDText('Section A'),
                    FDVerticalDivider(thickness: 2, width: 32, color: FlartColor('#94a3b8')),
                    FDText('Section B'),
                    FDVerticalDivider(thickness: 2, width: 32, color: FlartColor('#94a3b8')),
                    FDText('Section C'),
                    FDVerticalDivider(thickness: 2, width: 32, color: FlartColor('#94a3b8')),
                    FDText('Section D'),
                  ],
                ),
              ),
            ],
          ),
        ),

        ShowcaseCard(
          title: '7. FDGridView (childAspectRatio in Action)',
          description:
              'Grid tiles with exact aspect ratios (1.5 width/height ratio) and crossAxisSpacing.',
          child: FDContainer(
            height: 140,
            child: FDGridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.5,
              children: [
                FDContainer(
                  color: const FlartColor('#e0f2fe'),
                  alignment: Alignment.center,
                  child: const FDText('Tile 1 (1.5 ratio)', style: TextStyle(color: FlartColor('#0369a1'))),
                ),
                FDContainer(
                  color: const FlartColor('#fef3c7'),
                  alignment: Alignment.center,
                  child: const FDText('Tile 2 (1.5 ratio)', style: TextStyle(color: FlartColor('#b45309'))),
                ),
                FDContainer(
                  color: const FlartColor('#f3e8ff'),
                  alignment: Alignment.center,
                  child: const FDText('Tile 3 (1.5 ratio)', style: TextStyle(color: FlartColor('#7e22ce'))),
                ),
              ],
            ),
          ),
        ),

        ShowcaseCard(
          title: '8. Display Primitives: FDAspectRatio & FDClipRRect',
          description:
              '16:9 AspectRatio container and ClipRRect rounding arbitrary block content.',
          child: FDRow(
            spacing: 20,
            children: [
              FDContainer(
                width: 200,
                child: FDAspectRatio(
                  aspectRatio: 16 / 9,
                  child: FDColoredBox(
                    color: const FlartColor('#1e293b'),
                    child: const FDCenter(
                      child: FDText('16 : 9 AspectRatio', style: TextStyle(color: FlartColors.white)),
                    ),
                  ),
                ),
              ),
              FDClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: FDContainer(
                  width: 160,
                  height: 90,
                  color: const FlartColor('#f43f5e'),
                  alignment: Alignment.center,
                  child: const FDText('FDClipRRect (24px)', style: TextStyle(color: FlartColors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),

        ShowcaseCard(
          title: '9. FDExpanded & FDSpacer',
          description:
              'Flex row with 1x Expanded, Spacer, and 2x Expanded with min-width: 0 protection.',
          child: FDRow(
            children: [
              FDExpanded(
                flex: 1,
                child: FDContainer(
                  padding: const EdgeInsets.all(12),
                  color: const FlartColor('#3b82f6'),
                  alignment: Alignment.center,
                  child: const FDText('Expanded (flex: 1)', style: TextStyle(color: FlartColors.white)),
                ),
              ),
              const FDSpacer(flex: 1),
              FDExpanded(
                flex: 2,
                child: FDContainer(
                  padding: const EdgeInsets.all(12),
                  color: const FlartColor('#1d4ed8'),
                  alignment: Alignment.center,
                  child: const FDText('Expanded (flex: 2)', style: TextStyle(color: FlartColors.white)),
                ),
              ),
            ],
          ),
        ),

        ShowcaseCard(
          title: '10. FDListTile & FDBadge',
          description:
              'Clean list rows with leading avatar, title, subtitle, badge, and trailing action.',
          child: FDCard(
            padding: EdgeInsets.zero,
            child: FDColumn(
              children: [
                FDListTile(
                  leading: const FDIcon(icon: FDIcons.inbox, color: FlartColors.blue),
                  title: const FDText('Inbox', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: const FDText('3 unread communications'),
                  trailing: const FDBadge(
                    label: '3',
                    backgroundColor: FlartColors.blue,
                    child: FDSizedBox.square(dimension: 24),
                  ),
                  onTap: () {},
                ),
                const FDDivider(margin: EdgeInsets.zero),
                FDListTile(
                  leading: const FDIcon(icon: FDIcons.star, color: FlartColors.orange),
                  title: const FDText('Starred Tasks', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: const FDText('Pinned priority items'),
                  trailing: const FDIcon(icon: FDIcons.chevron_right, color: FlartColors.grey),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
