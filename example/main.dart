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
      // Adding global keyframe animations
      rawCss: '''
        body { font-family: 'Segoe UI', sans-serif; }
        
        @keyframes fadeIn {
          from { opacity: 0; }
          to { opacity: 1; }
        }
        
        @keyframes slideUp {
          from { transform: translateY(30px); opacity: 0; }
          to { transform: translateY(0); opacity: 1; }
        }
        
        @keyframes float {
          0% { transform: translateY(0px); }
          50% { transform: translateY(-15px); }
          100% { transform: translateY(0px); }
        }
        
        @keyframes pulse-glow {
          0% { box-shadow: 0 4px 15px rgba(98, 0, 234, 0.4); }
          50% { box-shadow: 0 4px 25px rgba(98, 0, 234, 0.7); }
          100% { box-shadow: 0 4px 15px rgba(98, 0, 234, 0.4); }
        }
      ''',
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
      // Background using BoxDecoration and Gradient instead of rawCss
      body: FDContainer(
        cssStyle: {
          'width': '100%',
          'height': '100%',
          'overflow': 'hidden',
        },
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: Gradient(
            direction: '135deg',
            colors: [FlartColor('#e0c3fc'), FlartColor('#8ec5fc')],
          ),
        ),
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
              child: FDContainer(
                rawCss: 'animation: float 4s ease-in-out infinite;',
                child: FDIcon(
                  icon: FDIcons.favorite,
                  size: 64.0,
                  color: FlartColors.red,
                ),
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
              rawCss:
                  'animation: slideUp 0.8s ease-out forwards; opacity: 0;', // opacity 0 start for animation
            ),

            FDSizedBox(height: 16.0),

            // Subtitle
            FDText(
              'A Flutter-inspired UI framework for the Web.',
              style: TextStyle(
                fontSize: 18.0,
                color: FlartColor('#555555'),
              ),
              rawCss:
                  'animation: slideUp 0.8s ease-out 0.2s forwards; opacity: 0;',
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
                'color': 'black',
                'padding': '15px 40px',
                'border-radius': '30px',
                'font-size': '18px',
                'font-weight': 'bold',
                'border': 'none',
                'cursor': 'pointer',
                // 'box-shadow': '0 4px 15px rgba(98, 0, 234, 0.4)', // Moved to rawCss for animation
                'transition': 'all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1)',
              },
              rawCss: '''
                animation: slideUp 0.8s ease-out 0.4s forwards, pulse-glow 3s infinite;
                opacity: 0;
                box-shadow: 0 4px 15px rgba(98, 0, 234, 0.4);
              ''',

              // Using hoverStyle property correctly instead of rawCss pseudo-selectors which are not nested properly
              hoverStyle: {
                'transform': 'scale(1.08) translateY(-2px)',
                'background-color': '#7c4dff',
                'box-shadow': '0 10px 30px rgba(98, 0, 234, 0.6)',
              },
            ),

            FDSizedBox(height: 30.0),

            // Link
            FDLinkText(
              label: 'View Documentation',
              href: 'https://github.com/Heebu/flart',
              style: TextStyle(
                color: FlartColor('#6200ea'),
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
              rawCss: 'animation: fadeIn 1s ease-out 1s forwards; opacity: 0;',
            ),
          ],
        ),
      ),
    );
  }
}
