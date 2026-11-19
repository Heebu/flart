import 'package:flartdart/flartdart.dart';
import '../widgets/showcase_card.dart';

class DialogShowcase extends StatefulWidget {
  @override
  State<DialogShowcase> createState() => _DialogShowcaseState();
}

class _DialogShowcaseState extends State<DialogShowcase> {
  String _status = 'No dialog action yet';

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
          child: FDColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FDElevatedButton(
                child: FDText('Show Dialog',
                    style: TextStyle(color: FlartColor('#ffffff'))),
                style: FDElevatedButton.styleFrom(
                  backgroundColor: FlartColor('#3b82f6'),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: BorderRadius.circular(8),
                ),
                onPressed: () async {
                  final result = await showDialog<String>(
                    builder: FDAlertDialog(
                      title: FDText('Interactive Alert Dialog'),
                      content: FDText(
                          'This is an interactive alert dialog. Click Cancel or Confirm to close the overlay.'),
                      actions: [
                        FDTextButton(
                          child: FDText('Cancel',
                              style: TextStyle(color: FlartColor('#64748b'))),
                          onPressed: () {
                            closeDialog('Cancelled');
                          },
                        ),
                        FDElevatedButton(
                          child: FDText('Confirm',
                              style: TextStyle(color: FlartColor('#ffffff'))),
                          style: FDElevatedButton.styleFrom(
                            backgroundColor: FlartColor('#3b82f6'),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            shape: BorderRadius.circular(6),
                          ),
                          onPressed: () {
                            closeDialog('Confirmed');
                          },
                        ),
                      ],
                    ),
                  );
                  if (result != null) {
                    setState(() {
                      _status = 'Dialog closed with: $result';
                    });
                  } else {
                    setState(() {
                      _status = 'Dialog dismissed (barrier clicked)';
                    });
                  }
                },
              ),
              FDSizedBox(height: 12),
              FDText(
                'Status: $_status',
                style: TextStyle(
                  fontSize: 14,
                  color: FlartColor('#3b82f6'),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
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
