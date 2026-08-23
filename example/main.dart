import 'package:flartdart/flartdart.dart';
import 'pages/basic_showcase.dart';
import 'pages/layout_showcase.dart';
import 'pages/input_showcase.dart';
import 'pages/animation_showcase.dart';
import 'pages/structure_showcase.dart';
import 'pages/navigation_showcase.dart';
import 'pages/media_showcase.dart';
import 'pages/interactive_showcase.dart';
import 'pages/scrollable_showcase.dart';
import 'pages/dialog_showcase.dart';

void main() {
  runApp(CatalogApp());
}

class CatalogApp extends StatefulWidget {
  @override
  State<CatalogApp> createState() => _CatalogAppState();
}

class _CatalogAppState extends State<CatalogApp> {
  int _selectedIndex = 0;

  final List<String> _menuItems = [
    'Basic Widgets',
    'Layout Widgets',
    'Input Widgets',
    'Animation Widgets',
    'Structure Widgets',
    'Navigation Widgets',
    'Media Widgets',
    'Interactive Widgets',
    'Scrollable Widgets',
    'Dialog Widgets',
  ];

  final List<Widget> _pages = [
    BasicShowcase(),
    LayoutShowcase(),
    InputShowcase(),
    AnimationShowcase(),
    StructureShowcase(),
    NavigationShowcase(),
    MediaShowcase(),
    InteractiveShowcase(),
    ScrollableShowcase(),
    DialogShowcase(),
  ];

  @override
  Widget build(BuildContext context) {
    return FDMaterialApp(
      title: 'FlartDart Catalog',
      home: FDScaffold(
        appBar: FDAppBar(
          title: FDText(
            'FlartDart Widget Catalog 🚀',
            style: TextStyle(
                color: FlartColor('#ffffff'), fontWeight: FontWeight.bold),
          ),
          backgroundColor: FlartColors.blue,
        ),
        body: FDRow(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Sidebar
            FDContainer(
              width: 250,
              decoration: BoxDecoration(
                color: FlartColor('#ffffff'),
                border: Border(
                    right: BorderSide(color: FlartColor('#e2e8f0'), width: 1)),
              ),
              child: FDColumn(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(_menuItems.length, (index) {
                  final isSelected = _selectedIndex == index;
                  return _SidebarItem(
                    title: _menuItems[index],
                    isSelected: isSelected,
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                  );
                }),
              ),
            ),

            // Main Content Area
            FDExpanded(
              child: FDContainer(
                padding: EdgeInsets.all(40),
                cssStyle: {
                  'overflow-y': 'auto',
                  'background-color': '#f1f5f9',
                },
                child: _pages[_selectedIndex],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  _SidebarItem({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FDGestureDetector(
      onTap: onTap,
      child: FDContainer(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: FlartColor(isSelected ? '#eff6ff' : '#ffffff'),
          border: Border(
            left: BorderSide(
              color: FlartColor(isSelected ? '#3b82f6' : 'transparent'),
              width: 4,
            ),
          ),
        ),
        child: FDText(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: FlartColor(isSelected ? '#1d4ed8' : '#475569'),
          ),
        ),
        cssStyle: {
          'cursor': 'pointer',
          'transition': 'all 0.2s ease',
        },
      ),
    );
  }
}
