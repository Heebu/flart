import 'package:flartdart/flartdart.dart';
import '../widgets/showcase_card.dart';

class NavigationShowcase extends StatefulWidget {
  @override
  State<NavigationShowcase> createState() => _NavigationShowcaseState();
}

class _NavigationShowcaseState extends State<NavigationShowcase> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FDColumn(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FDText(
          'Navigation Widgets',
          style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: FlartColor('#1e293b')),
        ),
        FDSizedBox(height: 8),
        FDText(
          'Widgets for navigating between views.',
          style: TextStyle(fontSize: 16, color: FlartColor('#64748b')),
        ),
        FDSizedBox(height: 32),
        ShowcaseCard(
          title: 'FDTabBar & FDTabBarView',
          description: 'A tabbed interface for switching between content.',
          child: FDContainer(
            decoration: BoxDecoration(
              color: FlartColor('#ffffff'),
              border: Border.all(color: FlartColor('#e2e8f0'), width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: FDColumn(
              children: [
                FDTabBar(
                  currentIndex: _tabIndex,
                  onTap: (index) {
                    setState(() {
                      _tabIndex = index;
                    });
                  },
                  tabs: [
                    FDText('Home'),
                    FDText('Settings'),
                    FDText('Profile'),
                  ],
                ),
                FDTabBarView(
                  currentIndex: _tabIndex,
                  children: [
                    FDCenter(
                        child: FDText('Welcome to the Home Tab!',
                            style: TextStyle(color: FlartColor('#64748b')))),
                    FDCenter(
                        child: FDText('Settings Configuration goes here.',
                            style: TextStyle(color: FlartColor('#64748b')))),
                    FDCenter(
                        child: FDText('User Profile Information.',
                            style: TextStyle(color: FlartColor('#64748b')))),
                  ],
                ),
              ],
            ),
          ),
        ),
        ShowcaseCard(
          title: 'FDDrawer',
          description: 'A navigation drawer sliding in from the edge.',
          child: FDContainer(
            height: 300,
            cssStyle: {'position': 'relative', 'overflow': 'hidden'},
            child: FDScaffold(
              appBar: FDAppBar(
                title: FDText('App with Drawer',
                    style: TextStyle(color: FlartColor('#ffffff'))),
                backgroundColor: FlartColors.blue,
              ),
              drawer: FDDrawer(
                child: FDColumn(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FDContainer(
                      height: 100,
                      decoration: BoxDecoration(color: FlartColors.blue),
                      child: FDCenter(
                          child: FDText('Menu',
                              style: TextStyle(
                                  color: FlartColor('#ffffff'), fontSize: 24))),
                    ),
                    FDText('Item 1'),
                    FDText('Item 2'),
                  ],
                ),
              ),
              body: FDCenter(
                  child: FDText('Click the menu icon to open the drawer.',
                      style: TextStyle(color: FlartColor('#475569')))),
            ),
          ),
        ),
      ],
    );
  }
}
