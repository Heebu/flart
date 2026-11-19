import 'package:flartdart/flartdart.dart';
import 'pages/basic_showcase.dart';
import 'pages/layout_showcase.dart';
import 'pages/input_showcase.dart';
import 'pages/animation_showcase.dart';
import 'pages/structure_showcase.dart';
import 'pages/media_showcase.dart';
import 'pages/interactive_showcase.dart';
import 'pages/scrollable_showcase.dart';

void main() {
  runApp(CatalogApp());
}

class _CategoryEntry {
  final String number;
  final String title;
  final String status;
  final Widget page;

  const _CategoryEntry({
    required this.number,
    required this.title,
    required this.status,
    required this.page,
  });
}

class CatalogApp extends StatefulWidget {
  @override
  State<CatalogApp> createState() => _CatalogAppState();
}

class _CatalogAppState extends State<CatalogApp> {
  // Default to Category 3 (Display & Leaf Primitives)
  int _selectedIndex = 2;

  final List<_CategoryEntry> _categories = [
    _CategoryEntry(
      number: '1',
      title: 'Structure & Layout',
      status: 'Fixed',
      page: StructureShowcase(),
    ),
    _CategoryEntry(
      number: '2',
      title: 'Arrangement & Positioning',
      status: 'Fixed',
      page: LayoutShowcase(),
    ),
    _CategoryEntry(
      number: '3',
      title: 'Display & Leaf Primitives',
      status: 'Fixed',
      page: BasicShowcase(),
    ),
    _CategoryEntry(
      number: '4',
      title: 'Text Widgets',
      status: 'Next',
      page: InteractiveShowcase(),
    ),
    _CategoryEntry(
      number: '5',
      title: 'Button & Interaction',
      status: 'Pending',
      page: InteractiveShowcase(),
    ),
    _CategoryEntry(
      number: '6',
      title: 'Input & Form',
      status: 'Pending',
      page: InputShowcase(),
    ),
    _CategoryEntry(
      number: '7',
      title: 'Animation & Effect',
      status: 'Pending',
      page: AnimationShowcase(),
    ),
    _CategoryEntry(
      number: '8',
      title: 'Media & Web',
      status: 'Pending',
      page: MediaShowcase(),
    ),
    _CategoryEntry(
      number: '9',
      title: 'Utility & Builders',
      status: 'Pending',
      page: ScrollableShowcase(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final active = _categories[_selectedIndex];

    return FDMaterialApp(
      title: 'Flart 9 Categories Widget Catalog',
      home: FDScaffold(
        appBar: FDAppBar(
          title: FDRow(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const FDText(
                'FlartDart Framework 🚀',
                style: TextStyle(
                  color: FlartColor('#ffffff'),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              FDContainer(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const FlartColor('#1e40af'),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: FDText(
                  'Reviewing: Cat ${active.number} - ${active.title}',
                  style: const TextStyle(
                    color: FlartColors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: FlartColors.blue,
        ),
        body: FDRow(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Sidebar with 9 Categories
            FDContainer(
              width: 290,
              decoration: BoxDecoration(
                color: const FlartColor('#ffffff'),
                border: const Border(
                  right: BorderSide(color: FlartColor('#e2e8f0'), width: 1),
                ),
              ),
              child: FDColumn(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FDContainer(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const FlartColor('#f8fafc'),
                      border: const Border(
                        bottom: BorderSide(color: FlartColor('#e2e8f0'), width: 1),
                      ),
                    ),
                    child: const FDText(
                      '9 Widget Categories',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: FlartColor('#334155'),
                      ),
                    ),
                  ),
                  FDExpanded(
                    child: FDContainer(
                      child: FDListView.builder(
                        itemCount: _categories.length,
                        itemBuilder: (context, index) {
                          final item = _categories[index];
                          final isSelected = _selectedIndex == index;
                          return _SidebarCategoryItem(
                            number: item.number,
                            title: item.title,
                            status: item.status,
                            isSelected: isSelected,
                            onTap: () {
                              setState(() {
                                _selectedIndex = index;
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Main Content Area
            FDExpanded(
              child: FDContainer(
                padding: const EdgeInsets.all(32),
                decoration: const BoxDecoration(
                  color: FlartColor('#f1f5f9'),
                ),
                child: active.page,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SidebarCategoryItem extends StatelessWidget {
  final String number;
  final String title;
  final String status;
  final bool isSelected;
  final VoidCallback onTap;

  const _SidebarCategoryItem({
    required this.number,
    required this.title,
    required this.status,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isFixed = status == 'Fixed';
    final isNext = status == 'Next';

    return FDGestureDetector(
      onTap: onTap,
      child: FDContainer(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: FlartColor(isSelected ? '#eff6ff' : '#ffffff'),
          border: Border(
            left: BorderSide(
              color: FlartColor(isSelected ? '#2563eb' : 'transparent'),
              width: 4,
            ),
            bottom: const BorderSide(color: FlartColor('#f1f5f9'), width: 1),
          ),
        ),
        child: FDRow(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FDExpanded(
              child: FDRow(
                spacing: 8,
                children: [
                  FDContainer(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: FlartColor(isSelected ? '#2563eb' : '#e2e8f0'),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    alignment: Alignment.center,
                    child: FDText(
                      number,
                      style: TextStyle(
                        color: FlartColor(isSelected ? '#ffffff' : '#475569'),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  FDExpanded(
                    child: FDText(
                      title,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        color: FlartColor(isSelected ? '#1d4ed8' : '#334155'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FDContainer(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: isFixed
                    ? const FlartColor('#dcfce7')
                    : (isNext ? const FlartColor('#fef3c7') : const FlartColor('#f1f5f9')),
                borderRadius: BorderRadius.circular(10),
              ),
              child: FDText(
                status,
                style: TextStyle(
                  color: isFixed
                      ? const FlartColor('#15803d')
                      : (isNext ? const FlartColor('#b45309') : const FlartColor('#94a3b8')),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
