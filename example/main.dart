import 'package:flartdart/flartdart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return FDMaterialApp(
      title: 'Flart Intro',
      home: FDScaffold(
        appBar: FDAppBar(
          title: FDText('Welcome to Flart 🚀', style: TextStyle(color: FlartColor('#ffffff'))),
          backgroundColor: FlartColors.blue,
        ),
        body: FDContainer(
          decoration: BoxDecoration(
            gradient: Gradient(
              direction: 'to bottom right',
              colors: [FlartColor('#e0c3fc'), FlartColor('#8ec5fc')],
            ),
          ),
          child: FDCenter(
            child: FDColumn(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FDText(
                  'Flart',
                  style: TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                    color: FlartColor('#333333'),
                  ),
                ),
                FDSizedBox(height: 16),
                FDText(
                  'A Flutter-inspired UI framework for the Web',
                  style: TextStyle(
                    fontSize: 24,
                    color: FlartColor('#555555'),
                  ),
                ),
                FDSizedBox(height: 48),
                FDContainer(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: FlartColor('#ffffff'),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: FlartColor('#000000').withOpacity(0.1),
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: FDColumn(
                    children: [
                      FDText(
                        'Features:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      FDSizedBox(height: 16),
                      _FeatureItem(icon: FDIcons.widgets, text: 'Flutter-like Widget Composition'),
                      FDSizedBox(height: 8),
                      _FeatureItem(icon: FDIcons.bolt, text: 'Dart-only Development'),
                      FDSizedBox(height: 8),
                      _FeatureItem(icon: FDIcons.storage, text: 'Real HTML/CSS/DOM Output'),
                    ],
                  ),
                ),
                FDSizedBox(height: 48),
                FDElevatedButton(
                  onPressed: () {
                    // Action could go here
                  },
                  child: FDRow(
                    children: [
                      FDText('Get Started', style: TextStyle(color: FlartColor('#ffffff'))),
                      FDSizedBox(width: 8),
                      FDIcon(icon: FDIcons.arrow_forward, color: FlartColor('#ffffff')),
                    ],
                  ),
                  cssStyle: {
                    'background-color': '#6366f1',
                    'color': '#ffffff',
                    'padding': '16px 32px',
                    'border-radius': '30px',
                    'font-size': '18px',
                    'font-weight': 'bold',
                    'border': 'none',
                    'cursor': 'pointer',
                    'box-shadow': '0 4px 14px 0 rgba(99, 102, 241, 0.39)',
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String icon;
  final String text;

  _FeatureItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return FDRow(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FDIcon(icon: icon, color: FlartColors.blue),
        FDSizedBox(width: 12),
        FDText(text, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
