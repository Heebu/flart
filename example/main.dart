import 'package:flartdart/flartdart.dart';

void main() {
  runApp(const IntroApp());
}

class IntroApp extends Widget {
  const IntroApp();

  @override
  String render(BuildContext context) {
    return FDMaterialApp(
      title: 'Flart Intro',
      home: const IntroPage(),
      backgroundColor: FlartColors.blue,
      //  rawCss: '''
      //   body { font-family: sans-serif; }
      // ''',
    ).render(context);
  }
}

class IntroPage extends StatelessWidget {
  const IntroPage();

  @override
  Widget build(BuildContext context) {
    return FDScaffold(
      // App Bar
      appBar: FDAppBar(
        title: FDText('Welcome to Flart'),
        backgroundColor: FlartColors.blue,
        elevation: 0.0,
      ),
      // Background with gradient using rawCss
      body: FDContainer(
        width: double.infinity,
        height: double.infinity,
        rawCss:
            'background: linear-gradient(135deg, #e0c3fc 0%, #8ec5fc 100%); width: 100vw; height: 100vh; display: flex; align-items: center; justify-content: center;',
        child: FDColumn(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo Icon with Shadow
            FDContainer(
              padding: EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                color: FlartColors.white,
                borderRadius: BorderRadius.circular(50.0),
                boxShadow: [
                  BoxShadow(
                    color: FlartColors.black,
                    blurRadius: 20.0,
                    offsetX: 0.0,
                    offsetY: 10.0,
                  ),
                ],
              ),
              child: FDIcon(
                icon: FDIcons.favorite,
                size: 64.0,
                color: FlartColors.red,
              ),
            ),

            FDSizedBox(height: 40.0),

            // Main Title
            FDText(
              'Hello, Flart!',
              style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
                color: FlartColor('#333333'),
              ),
            ),

            FDSizedBox(height: 16.0),

            // Subtitle
            FDText(
              'A Flutter-inspired UI framework for the Web.',
              style: TextStyle(
                fontSize: 18.0,
                color: FlartColor('#555555'),
              ),
            ),

            FDSizedBox(height: 40.0),

            // Action Button
            FDElevatedButton(
              onPressed: () {
                print('Get Started Clicked!');
              },
              child: FDText('Get Started'),
              cssStyle: {
                'background-color': '#6200ea',
                'color': 'white',
                'padding': '15px 40px',
                'border-radius': '30px',
                'font-size': '18px',
                'font-weight': 'bold',
                'border': 'none',
                'cursor': 'pointer',
                'box-shadow': '0 4px 15px rgba(98, 0, 234, 0.4)',
                'transition': 'transform 0.2s ease',
              },
              rawCss: ':hover { transform: scale(1.05); }',
            ),

            FDSizedBox(height: 30.0),

            // Link
            FDLinkText(
              label: 'View Documentation',
              href: 'https://github.com/Heebu/flart',
              style: TextStyle(
                color: FlartColor('#6200ea'),
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
