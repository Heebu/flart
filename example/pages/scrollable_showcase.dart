import 'package:flartdart/flartdart.dart';
import '../widgets/showcase_card.dart';

class ScrollableShowcase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FDColumn(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FDText(
          'Scrollable Widgets',
          style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: FlartColor('#1e293b')),
        ),
        FDSizedBox(height: 8),
        FDText(
          'Widgets that allow scrolling through content.',
          style: TextStyle(fontSize: 16, color: FlartColor('#64748b')),
        ),
        FDSizedBox(height: 32),
        ShowcaseCard(
          title: 'FDSingleChildScrollView',
          description: 'A box in which a single widget can be scrolled.',
          child: FDContainer(
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(color: FlartColor('#cbd5e1'), width: 1),
              borderRadius: BorderRadius.circular(8),
              color: FlartColor('#ffffff'),
            ),
            child: FDSingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: FDColumn(
                children: List.generate(
                    10,
                    (index) => FDContainer(
                          margin: EdgeInsets.only(bottom: 8),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: FlartColor('#eff6ff'),
                              borderRadius: BorderRadius.circular(4)),
                          child: FDText('Scrollable Item ${index + 1}'),
                        )),
              ),
            ),
          ),
        ),
        ShowcaseCard(
          title: 'FDGridView',
          description: 'A scrollable, 2D array of widgets.',
          child: FDContainer(
            height: 250,
            decoration: BoxDecoration(
              border: Border.all(color: FlartColor('#cbd5e1'), width: 1),
              borderRadius: BorderRadius.circular(8),
              color: FlartColor('#ffffff'),
            ),
            child: FDSingleChildScrollView(
              child: FDGridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                cssStyle: {'padding': '16px'},
                children: List.generate(
                    12,
                    (index) => FDContainer(
                          height: 60,
                          decoration: BoxDecoration(
                              color: FlartColor('#dbeafe'),
                              borderRadius: BorderRadius.circular(4)),
                          child: FDCenter(child: FDText('${index + 1}')),
                        )),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
