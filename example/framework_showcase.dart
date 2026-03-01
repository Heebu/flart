import 'package:flartdart/flartdart.dart';

void main() {
  runApp(const FrameworkShowcase());
}

class UserProfile {
  final String name;
  final String email;
  UserProfile(this.name, this.email);
}

class FrameworkShowcase extends StatelessWidget {
  const FrameworkShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 1. Using FDProvider for DI
    return FDProvider<UserProfile>(
      value: UserProfile('Antigravity User', 'user@antigravity.ai'),
      child: FDMaterialApp(
        title: 'Framework Improvements',
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 2. Using Extension methods for theme and layout
    final theme = context.theme;
    final isMobile = context.isMobile;

    // 3. Dependency Injection retrieval
    final user = FDProvider.of<UserProfile>(context);

    return FDScaffold(
      appBar: FDAppBar(
        title: FDText('Framework Updates'),
        backgroundColor: theme.primaryColor,
      ),
      body: FDListView(
        padding: EdgeInsets.all(isMobile ? 12 : 32),
        children: [
          FDCard(
            padding: EdgeInsets.all(24),
            child: FDColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FDText('Welcome, ${user.name}',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor)),
                FDSizedBox(height: 8),
                FDText('Email: ${user.email}'),
                FDDivider(margin: EdgeInsets.symmetric(vertical: 24)),
                _infoRow('Screen Width', '${context.width}px'),
                _infoRow(
                    'Device Category',
                    isMobile
                        ? 'Mobile'
                        : (context.isTablet ? 'Tablet' : 'Desktop')),
                _infoRow('Theme Mode', theme.isDark ? 'Dark 🌙' : 'Light ☀️'),
              ],
            ),
          ),
          FDSizedBox(height: 24),
          const ResponsiveBox(),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return FDPadding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: FDRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FDText(label, style: TextStyle(fontWeight: FontWeight.w600)),
          FDText(value),
        ],
      ),
    );
  }
}

class ResponsiveBox extends StatelessWidget {
  const ResponsiveBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Using extensions to build responsive UI without manual MediaQuery.of checks
    return FDContainer(
      height: 100,
      width: context.isMobile ? double.infinity : 400,
      decoration: BoxDecoration(
        color: context.theme.accentColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: FDCenter(
        child: FDText(
          context.isMobile ? 'Mobile Layout' : 'Desktop Layout',
          style:
              TextStyle(color: FlartColors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
