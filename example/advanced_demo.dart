import 'package:flartdart/flartdart.dart';

void main() {
  Input.init();

  PageNavigator.registerRoutes({
    '/': const WelcomePage(),
    '/dashboard': const DashboardPage(),
    '/login': const LoginPage(),
    '/virtual-list': const VirtualListPage(),
  }, guard: (route) {
    if ((route == '/dashboard' || route == '/virtual-list') &&
        !Session.isLoggedIn) {
      return false;
    }
    return true;
  }, unauthorizedRoute: '/login');

  runApp(const AdvancedApp());
}

class Session {
  static bool isLoggedIn = false;
  static bool isDarkMode = false;
}

class AdvancedApp extends StatefulWidget {
  const AdvancedApp({Key? key}) : super(key: key);

  @override
  State<AdvancedApp> createState() => _AdvancedAppState();
}

class _AdvancedAppState extends State<AdvancedApp> {
  @override
  Widget build(BuildContext context) {
    print('Root rebuild: dark mode = ${Session.isDarkMode}');
    return FDMaterialApp(
      title: 'Flart Advanced Demo',
      darkMode: Session.isDarkMode,
      // theme: Session.isDarkMode ? ThemeData.dark() : ThemeData.light(),
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FDScaffold(
      appBar: FDAppBar(title: FDText('Flart Advanced')),
      body: FDCenter(
        child: FDColumn(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FDText('Welcome to Flart!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                )),
            FDSizedBox(height: 10),
            FDText('The perfect framework for Web & Games'),
            FDSizedBox(height: 30),
            FDElevatedButton(
              onPressed: () => PageNavigator.pushNamed('/dashboard'),
              child: FDText('Enter Dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FDScaffold(
      appBar: FDAppBar(title: FDText('Authentication')),
      body: FDCenter(
        child: FDColumn(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FDText('Restricted Area', style: TextStyle(fontSize: 20)),
            FDSizedBox(height: 20),
            FDElevatedButton(
              onPressed: () {
                Session.isLoggedIn = true;
                PageNavigator.replaceNamed('/dashboard');
              },
              child: FDText('Log In'),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Ticker _ticker;
  double _rotation = 0;

  @override
  void initState() {
    super.initState();
    _ticker = Ticker((elapsed) {
      setState(() {
        _rotation = (elapsed.inMilliseconds / 1000) * 45; // 45 deg per sec
      });
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isWPressed = Input.isKeyDown('w');

    return FDScaffold(
      appBar: FDAppBar(
        title: FDText('Dashboard'),
        actions: [
          FDElevatedButton(
            onPressed: () {
              Session.isDarkMode = !Session.isDarkMode;
              reRenderApp(); // Global repaint for theme
            },
            child: FDText(Session.isDarkMode ? '🌞' : '🌙'),
          ),
        ],
      ),
      body: FDListView(
        padding: EdgeInsets.all(24),
        children: [
          FDContainer(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: FlartColor('#000000'), // Fixed from rgba
                    blurRadius: 10,
                    offsetX: 0,
                    offsetY: 4)
              ],
            ),
            child: FDColumn(
              children: [
                FDText('System Status',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                FDSizedBox(height: 16),
                FDContainer(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color:
                        isWPressed ? FlartColor('#ff9800') : theme.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  rawCss:
                      'transform: rotate(${_rotation}deg); transition: background-color 0.2s;',
                  child: FDCenter(child: FDText('⚙️')),
                ),
                FDSizedBox(height: 12),
                FDText('Hold "W" to interact', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
          FDSizedBox(height: 24),
          FDElevatedButton(
            onPressed: () => PageNavigator.pushNamed('/virtual-list'),
            child: FDText('🚀 Test 10,000 Item Virtual List'),
          ),
          FDSizedBox(height: 24),
          FDElevatedButton(
            onPressed: () {
              Session.isLoggedIn = false;
              PageNavigator.replaceNamed('/');
            },
            child: FDText('Log Out'),
          ),
        ],
      ),
    );
  }
}

class VirtualListPage extends StatelessWidget {
  const VirtualListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FDScaffold(
      appBar: FDAppBar(title: FDText('Virtual List (10,000 Items)')),
      body: FDVirtualizedListView(
        itemCount: 10000,
        itemHeight: 70,
        itemBuilder: (context, index) {
          return FDContainer(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: index % 2 == 0
                  ? theme.cardColor
                  : theme.scaffoldBackgroundColor,
            ),
            child: FDRow(
              children: [
                FDContainer(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: FDCenter(
                      child: FDText('${index + 1}',
                          style: TextStyle(
                              color: FlartColors.white, fontSize: 12))),
                ),
                FDSizedBox(width: 16),
                FDColumn(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FDText('User Performance Node #$index',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    FDText('Data point collected and virtualized',
                        style: TextStyle(
                            fontSize: 12, color: FlartColor('#888888'))),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
