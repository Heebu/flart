import 'package:flartdart/flartdart.dart';
import '../widgets/showcase_card.dart';

class DialogShowcase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FDColumn(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FDText(
          'Dialog Widgets',
          style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: FlartColor('#1e293b')),
        ),
        FDSizedBox(height: 8),
        FDText(
          'Alerts, modals, and overlays.',
          style: TextStyle(fontSize: 16, color: FlartColor('#64748b')),
        ),
        FDSizedBox(height: 32),
        ShowcaseCard(
          title: 'FDDialog',
          description: 'A material design dialog.',
          child: FDElevatedButton(
            child: FDText('Show Dialog',
                style: TextStyle(color: FlartColor('#ffffff'))),
            onPressed: () {
              // Normally this is triggered by user interaction handled natively in HTML
              // Here we simulate the JS alert for showcase simplicity until DOM event system handles complex multi-roots
              print(
                  'Dialog button clicked! In a full DOM environment, this would call showDialog()');
            },
          ),
        ),
        FDContainer(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: FlartColor('#f8fafc'),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: FlartColor('#e2e8f0')),
          ),
          child: FDColumn(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FDText('Dialog Preview',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              FDSizedBox(height: 16),
              // Render the dialog inline for preview purposes
              FDContainer(
                height: 300,
                cssStyle: {
                  'position': 'relative',
                  'overflow': 'hidden',
                  'background-color': '#cbd5e1'
                },
                child: FDCenter(
                  child: FDDialog(
                    child: FDColumn(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FDText('Alert Dialog Title',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        FDSizedBox(height: 16),
                        FDText(
                            'This is the content of the dialog. It can contain any widget.',
                            style: TextStyle(color: FlartColor('#475569'))),
                        FDSizedBox(height: 24),
                        FDRow(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FDTextButton(
                              child: FDText('Cancel',
                                  style: TextStyle(color: FlartColors.blue)),
                              onPressed: () {},
                            ),
                            FDSizedBox(width: 8),
                            FDElevatedButton(
                              child: FDText('Confirm',
                                  style:
                                      TextStyle(color: FlartColor('#ffffff'))),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
