import 'package:flartdart/flartdart.dart';
import '../widgets/showcase_card.dart';

class StructureShowcase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FDColumn(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FDText(
          'Structure Widgets',
          style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: FlartColor('#1e293b')),
        ),
        FDSizedBox(height: 8),
        FDText(
          'Widgets used for structuring and presenting content blocks.',
          style: TextStyle(fontSize: 16, color: FlartColor('#64748b')),
        ),
        FDSizedBox(height: 32),
        ShowcaseCard(
          title: 'FDCard',
          description:
              'A material design card with a subtle shadow and rounded corners.',
          child: FDCard(
            padding: EdgeInsets.all(20),
            child: FDColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FDText('Card Title',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                FDSizedBox(height: 8),
                FDText(
                    'This is the content inside the card. It looks nice and elevated.',
                    style: TextStyle(color: FlartColor('#475569'))),
              ],
            ),
          ),
        ),
        ShowcaseCard(
          title: 'FDDivider',
          description: 'A thin horizontal line used to separate content.',
          child: FDColumn(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FDText('Item 1'),
              FDDivider(),
              FDText('Item 2'),
              FDDivider(color: FlartColors.blue, thickness: 2),
              FDText('Item 3 (Blue divider)'),
            ],
          ),
        ),
        ShowcaseCard(
          title: 'FDSkeleton',
          description: 'A placeholder skeleton for loading states.',
          child: FDColumn(
            children: [
              FDSkeleton(
                  width: 200,
                  height: 20,
                  borderRadius: BorderRadius.circular(4)),
              FDSizedBox(height: 12),
              FDSkeleton(
                  width: 300,
                  height: 16,
                  borderRadius: BorderRadius.circular(4)),
              FDSizedBox(height: 8),
              FDSkeleton(
                  width: 250,
                  height: 16,
                  borderRadius: BorderRadius.circular(4)),
            ],
          ),
        ),
        ShowcaseCard(
          title: 'FDListTile',
          description: 'A single fixed-height row that typically contains some text as well as a leading or trailing icon.',
          child: FDCard(
            padding: EdgeInsets.zero,
            child: FDColumn(
              children: [
                FDListTile(
                  leading: FDIcon(icon: Icons.inbox, color: FlartColors.blue),
                  title: FDText('Inbox', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: FDText('Check your recent messages'),
                  trailing: FDBadge(child: FDText('3'), backgroundColor: FlartColors.blue),
                  onTap: () {},
                ),
                FDDivider(margin: EdgeInsets.zero),
                FDListTile(
                  leading: FDIcon(icon: Icons.star, color: FlartColors.orange),
                  title: FDText('Starred', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: FDText('Important pinned items'),
                  trailing: FDIcon(icon: Icons.chevron_right, color: FlartColors.grey),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
        ShowcaseCard(
          title: 'FDProgressIndicator',
          description: 'A circular loading indicator.',
          child: FDCircularProgressIndicator(
            color: FlartColors.blue,
            size: 40,
            strokeWidth: 4,
          ),
        ),
      ],
    );
  }
}
