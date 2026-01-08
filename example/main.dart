import 'package:flartdart/flartdart.dart';

void main() {
  runApp(const ShowcaseApp());
}

class ShowcaseApp extends Widget {
  const ShowcaseApp();

  @override
  String render(BuildContext context) {
    return FDMaterialApp(
      context: context,
      title: 'Flart Premium Showcase',
      home: const HomePage(),
      darkMode: false,
    ).render(context);
  }
}

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;
  bool _showEffects = true;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FDScaffold(
      // Gradient FDAppBar using rawCss
      appBar: FDAppBar(
        title: FDText(
          'Flart Premium',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        rawCss:
            'background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); box-shadow: 0 4px 15px rgba(0,0,0,0.1);',
      ),
      drawer: FDDrawer(
        child: FDColumn(
          children: [
            // Header with GradientShader
            GradientShader(
              height: 180,
              width: double.infinity,
              colors: ['#a18cd1', '#fbc2eb'],
              direction: 'diagonal',
              child: FDCenter(
                child: FDColumn(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FDIcon(
                        icon: FDIcons.person,
                        size: 60,
                        color: FlartColors.white),
                    FDSizedBox(height: 10),
                    FDText('User Profile',
                        style: TextStyle(
                            color: FlartColors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            // Menu Items with rawCss hover effects
            _buildMenuItem(FDIcons.home, 'Home'),
            _buildMenuItem(FDIcons.settings, 'Settings'),
            _buildMenuItem(FDIcons.info, 'About'),
          ],
        ),
      ),
      body: FDSingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: FDColumn(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Hero Section using Raw CSS & FDStack
            FDStack(
              children: [
                FDContainer(
                  height: 250,
                  rawCss: '''
                    background: linear-gradient(120deg, #84fab0 0%, #8fd3f4 100%);
                    border-radius: 20px;
                    box-shadow: 0 10px 25px rgba(132, 250, 176, 0.4);
                  ''',
                ),
                FDPositioned(
                  top: 40,
                  left: 30,
                  child: FDColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FDText(
                        'Next Gen Web UI',
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: FlartColors.white),
                      ),
                      FDSizedBox(height: 10),
                      FDText(
                        'Built with pure Dart & love',
                        style:
                            TextStyle(fontSize: 18, color: FlartColors.white),
                      ),
                      FDSizedBox(height: 20),
                      FDElevatedButton(
                        child: FDText('Get Started ✨'),
                        onPressed: _incrementCounter,
                        cssStyle: {
                          'background': 'white',
                          'color': '#333',
                          'font-weight': 'bold',
                        },
                        rawCss:
                            'border-radius: 30px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); transition: transform 0.2s;',
                      )
                    ],
                  ),
                ),
                FDPositioned(
                  right: 30,
                  bottom: -20,
                  child: FDSvgPicture.asset(
                    'assets/hero_image.svg',
                    width: 150,
                    height: 150,
                    rawCss:
                        'filter: drop-shadow(0 10px 10px rgba(0,0,0,0.2)); transform: rotate(-10deg);',
                  ),
                  // Note: In a real app ensure asset exists or use a fallback
                ),
              ],
            ),

            FDSizedBox(height: 40),

            _buildSectionHeader('Interactive Shaders'),

            // 2. Interactive Shader Playground
            FDCard(
              padding: EdgeInsets.all(0),
              rawCss:
                  'overflow: hidden; border-radius: 16px; border: none; box-shadow: 0 10px 30px rgba(0,0,0,0.05);',
              child: FDColumn(
                children: [
                  FDRow(
                    children: [
                      // Plasma Shader
                      FDExpanded(
                        child: FDContainer(
                          height: 200,
                          child: PlasmaShader(
                            speed: 1.5,
                            child: FDCenter(
                              child: FDText(
                                'Plasma',
                                style: TextStyle(
                                    color: FlartColors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Wave Shader with rawCss overlay
                      FDExpanded(
                        child: FDContainer(
                          height: 200,
                          child: WaveShader(
                            color: '#4facfe',
                            amplitude: 0.2,
                            speed: 2.0,
                            child: FDCenter(
                              child: FDContainer(
                                padding: EdgeInsets.all(10),
                                rawCss:
                                    'background: rgba(255,255,255,0.2); backdrop-filter: blur(5px); border-radius: 10px;',
                                child: FDText(
                                  'Waves & Glass',
                                  style: TextStyle(
                                      color: FlartColors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            FDSizedBox(height: 40),

            _buildSectionHeader('Standard vs Raw CSS'),

            // 3. Comparison Section
            FDRow(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDemoCard(
                  'Standard Widget',
                  FDElevatedButton(
                    child: FDText('Click Me'),
                    onPressed: () {},
                    cssStyle: {'background-color': '#2196F3'}, // Standard way
                  ),
                ),
                FDSizedBox(width: 20),
                _buildDemoCard(
                  'Raw CSS Enhanced',
                  FDElevatedButton(
                    child: FDText('Hover Me!'),
                    onPressed: () {},
                    // Raw CSS for advanced effects like gradients, shadows, and transforms
                    rawCss: '''
                      background: linear-gradient(45deg, #FE6B8B 30%, #FF8E53 90%);
                      border: 0;
                      box-shadow: 0 3px 5px 2px rgba(255, 105, 135, .3);
                      color: white;
                      border-radius: 3px;
                      transition: transform 0.3s;
                    ''',
                  ),
                ),
              ],
            ),

            FDSizedBox(height: 40),

            _buildSectionHeader('Web Integration'),

            // 4. Web Component (Iframe)
            FDContainer(
              height: 300,
              rawCss:
                  'border-radius: 12px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.1); border: 1px solid #eee;',
              child: FDIframe(
                src: 'https://flutter.dev',
                title: 'Flutter Website',
                rawCss:
                    'filter: grayscale(100%); transition: filter 0.5s;', // Start grayscale
              ),
            ),
            FDText(
              '* Hover logic could remove grayscale via JS, or just use rawCss for initial styling.',
              style: TextStyle(fontSize: 12, color: FlartColors.grey),
            ),
          ],
        ),
      ),
      floatingActionButton: FDFloatingActionButton(
        onPressed: _incrementCounter,
        child: FDIcon(icon: FDIcons.add),
        rawCss:
            'background: #ff512f; background: -webkit-linear-gradient(to right, #dd2476, #ff512f); background: linear-gradient(to right, #dd2476, #ff512f);', // Instagram-like gradient
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return FDContainer(
      margin: EdgeInsets.only(bottom: 15),
      child: FDRow(
        children: [
          FDContainer(
              width: 4,
              height: 24,
              rawCss: 'background: #667eea; border-radius: 2px;'),
          FDSizedBox(width: 10),
          FDText(
            title,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: '#2d3748'),
          ),
        ],
      ),
    );
  }

  Widget _buildDemoCard(String title, Widget content) {
    return FDExpanded(
      child: FDContainer(
        padding: EdgeInsets.all(20),
        rawCss:
            'background: white; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); border: 1px solid #f0f0f0;',
        child: FDColumn(
          children: [
            FDText(title,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: '#718096')),
            FDSizedBox(height: 15),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(String icon, String title) {
    return FDGestureDetector(
      onTap: () => print('$title tapped'),
      rawCss: 'cursor: pointer;',
      child: FDContainer(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        rawCss:
            'border-bottom: 1px solid #f7fafc; transition: background 0.2s;',
        child: FDRow(
          children: [
            FDIcon(icon: icon, color: FlartColors.grey, size: 20),
            FDSizedBox(width: 15),
            FDText(title, style: TextStyle(color: '#4a5568', fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
