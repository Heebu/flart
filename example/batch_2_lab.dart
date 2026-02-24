import 'package:flartdart/flartdart.dart';

class Batch2Lab extends StatefulWidget {
  const Batch2Lab({Key? key}) : super(key: key);

  @override
  State<Batch2Lab> createState() => _Batch2LabState();
}

class _Batch2LabState extends State<Batch2Lab> {
  int _tabIndex = 0;
  int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FDScaffold(
      appBar: FDAppBar(title: FDText('Batch 2: Lists & Navigation')),
      drawer: FDDrawer(
        child: FDListView(
          children: [
            FDContainer(
              padding: EdgeInsets.all(32),
              decoration: BoxDecoration(color: theme.primaryColor),
              child: FDText('Flart Menu',
                  style: TextStyle(color: FlartColors.white, fontSize: 24)),
            ),
            _drawerItem('Home', '🏠'),
            _drawerItem('Profile', '👤'),
            _drawerItem('Settings', '⚙️'),
          ],
        ),
      ),
      bottomNavigationBar: FDBottomNavigationBar(
        currentIndex: _navIndex,
        onTap: (index) => setState(() => _navIndex = index),
        items: [
          FDBottomNavigationBarItem(
              icon: FDIcon(icon: FDIcons.home), label: 'Home'),
          FDBottomNavigationBarItem(
              icon: FDIcon(icon: FDIcons.search), label: 'Search'),
          FDBottomNavigationBarItem(
            icon: FDIcon(icon: FDIcons.notifications),
            label: 'Alerts',
            badge: FDBadge(
              label: '3',
              child: FDSizedBox(),
            ),
          ),
          FDBottomNavigationBarItem(
              icon: FDIcon(icon: FDIcons.person), label: 'Profile'),
        ],
      ),
      body: FDColumn(
        children: [
          FDTabBar(
            currentIndex: _tabIndex,
            onTap: (index) => setState(() => _tabIndex = index),
            tabs: [
              FDText('Grid View'),
              FDText('Virtual List'),
              FDText('Raw Scroll'),
            ],
          ),
          FDExpanded(
            child: FDTabBarView(
              currentIndex: _tabIndex,
              children: [
                _buildGridLab(),
                _buildVirtualLab(),
                _buildScrollLab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridLab() {
    return FDGridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: List.generate(
          12,
          (index) => FDCard(
                elevation: 2,
                child: FDCenter(child: FDText('Item $index')),
              )),
    );
  }

  Widget _buildVirtualLab() {
    return FDVirtualizedListView(
      itemCount: 1000,
      itemHeight: 60,
      itemBuilder: (context, index) => FDContainer(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(color: Theme.of(context).dividerColor, width: 1)),
        ),
        child: FDRow(
          children: [
            FDText('📦', style: TextStyle(fontSize: 20)),
            FDSizedBox(width: 16),
            FDText('High Performance Row #$index'),
          ],
        ),
      ),
    );
  }

  Widget _buildScrollLab() {
    return FDSingleChildScrollView(
      child: FDColumn(
        children: [
          FDContainer(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(color: FlartColors.red.shade100),
              child: FDCenter(child: FDText('Top'))),
          FDContainer(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(color: FlartColors.blue.shade100),
              child: FDCenter(child: FDText('Middle'))),
          FDContainer(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(color: FlartColors.green.shade100),
              child: FDCenter(child: FDText('Bottom'))),
        ],
      ),
    );
  }

  Widget _drawerItem(String title, String icon) {
    return FDPadding(
      padding: EdgeInsets.all(16),
      child: FDRow(
        children: [
          FDText(icon),
          FDSizedBox(width: 16),
          FDText(title),
        ],
      ),
    );
  }
}
