import 'dart:js_interop';
import 'package:web/web.dart' as web;
import 'package:flartdart/flartdart.dart';

import 'pages/basic_showcase.dart';
import 'pages/layout_showcase.dart';
import 'pages/text_showcase.dart';
import 'pages/button_showcase.dart';
import 'pages/input_showcase.dart';
import 'pages/animation_showcase.dart';
import 'pages/structure_showcase.dart';
import 'pages/media_showcase.dart';
import 'pages/utility_showcase.dart';

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
  int _selectedIndex = 8;
  JSFunction? _resizeListener;

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
      status: 'Fixed',
      page: TextShowcase(),
    ),
    _CategoryEntry(
      number: '5',
      title: 'Button & Interaction',
      status: 'Fixed',
      page: ButtonShowcase(),
    ),
    _CategoryEntry(
      number: '6',
      title: 'Input & Form',
      status: 'Fixed',
      page: const InputShowcasePage(),
    ),
    _CategoryEntry(
      number: '7',
      title: 'Animation & Effect',
      status: 'Fixed',
      page: const AnimationShowcasePage(),
    ),
    _CategoryEntry(
      number: '8',
      title: 'Media & Web',
      status: 'Fixed',
      page: const MediaShowcasePage(),
    ),
    _CategoryEntry(
      number: '9',
      title: 'Utility & Builders',
      status: 'Fixed',
      page: const UtilityShowcasePage(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _resizeListener = ((web.Event _) {
      if (mounted) {
        setState(() {});
      }
    }).toJS;
    web.window.addEventListener('resize', _resizeListener!);
  }

  @override
  void dispose() {
    if (_resizeListener != null) {
      web.window.removeEventListener('resize', _resizeListener!);
    }
    super.dispose();
  }

  void _selectCategory(int index, {bool closeDrawer = false}) {
    setState(() {
      _selectedIndex = index;
    });
    if (closeDrawer) {
      FDScaffold.closeDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final isSmall = mq.isSmall;
    final isMedium = mq.isMedium;
    final isLarge = mq.isLarge;
    final active = _categories[_selectedIndex];

    return FDMaterialApp(
      title: 'Flart 9 Categories Widget Catalog',
      home: FDScaffold(
        drawer: FDDrawer(
          width: isSmall ? 280 : 304,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: FlartColor('#1e40af'),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'FlartDart Catalog',
                          style: TextStyle(
                            color: FlartColors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        FDGestureDetector(
                          onTap: FDScaffold.closeDrawer,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            child: const Icon(
                              FDIcons.close,
                              color: FlartColors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'All 9 Categories Fixed',
                      style: TextStyle(
                        color: FlartColor('#bfdbfe'),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      final item = _categories[index];
                      return _SidebarCategoryItem(
                        number: item.number,
                        title: item.title,
                        status: item.status,
                        isSelected: _selectedIndex == index,
                        onTap: () => _selectCategory(index, closeDrawer: true),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),

        appBar: FDAppBar(
          leading: (isSmall || isMedium)
              ? FDGestureDetector(
                  onTap: FDScaffold.openDrawer,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: const Icon(
                      FDIcons.menu,
                      color: FlartColors.white,
                      size: 24,
                    ),
                  ),
                )
              : null,
          title: Row(
            spacing: isSmall ? 8 : 12,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                isSmall ? 'Flart 🚀' : 'FlartDart Framework 🚀',
                style: TextStyle(
                  color: const FlartColor('#ffffff'),
                  fontWeight: FontWeight.bold,
                  fontSize: isSmall ? 16 : 18,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isSmall ? 8 : 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const FlartColor('#1e40af'),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  isSmall
                      ? 'Cat ${active.number}'
                      : 'Reviewing: Cat ${active.number} - ${active.title}',
                  style: TextStyle(
                    color: FlartColors.white,
                    fontSize: isSmall ? 11 : 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: isSmall
                    ? const FlartColor('#0284c7')
                    : (isMedium
                        ? const FlartColor('#0d9488')
                        : const FlartColor('#047857')),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Text(
                    isSmall
                        ? '📱 Mobile View'
                        : (isMedium ? '📱 Tablet View' : '🖥️ Desktop View'),
                    style: const TextStyle(
                      color: FlartColors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
          backgroundColor: FlartColors.blue,
        ),

        body: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLarge)
              Container(
                width: 280,
                decoration: const BoxDecoration(
                  color: FlartColor('#ffffff'),
                  border: Border(
                    right: BorderSide(color: FlartColor('#e2e8f0'), width: 1),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: FlartColor('#f8fafc'),
                        border: Border(
                          bottom: BorderSide(color: FlartColor('#e2e8f0'), width: 1),
                        ),
                      ),
                      child: const Text(
                        '9 Widget Categories',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: FlartColor('#334155'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _categories.length,
                        itemBuilder: (context, index) {
                          final item = _categories[index];
                          return _SidebarCategoryItem(
                            number: item.number,
                            title: item.title,
                            status: item.status,
                            isSelected: _selectedIndex == index,
                            onTap: () => _selectCategory(index),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

            if (isMedium)
              Container(
                width: 72,
                decoration: const BoxDecoration(
                  color: FlartColor('#ffffff'),
                  border: Border(
                    right: BorderSide(color: FlartColor('#e2e8f0'), width: 1),
                  ),
                ),
                child: FDSingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: const Text(
                          'Cats',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: FlartColor('#64748b'),
                          ),
                        ),
                      ),
                      for (int i = 0; i < _categories.length; i++)
                        _NavigationRailItem(
                          number: _categories[i].number,
                          title: _categories[i].title,
                          isSelected: _selectedIndex == i,
                          onTap: () => _selectCategory(i),
                        ),
                    ],
                  ),
                ),
              ),

            Expanded(
              child: Container(
                padding: EdgeInsets.all(isSmall ? 14 : (isMedium ? 20 : 32)),
                decoration: const BoxDecoration(
                  color: FlartColor('#f1f5f9'),
                ),
                child: FDSingleChildScrollView(
                  child: active.page,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Navigation Rail Item for Medium View
class _NavigationRailItem extends StatelessWidget {
  final String number;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavigationRailItem({
    required this.number,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FDGestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: isSelected
              ? const FlartColor('#2563eb')
              : const FlartColor('#f1f5f9'),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: isSelected
                ? const FlartColor('#1d4ed8')
                : const FlartColor('#e2e8f0'),
            width: 1.5,
          ),
        ),
        child: Center(
          child: Text(
            number,
            style: TextStyle(
              color: isSelected ? FlartColors.white : const FlartColor('#1e293b'),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

/// Sidebar Category Item for Large View & Drawer
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
      child: Container(
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                spacing: 8,
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: FlartColor(isSelected ? '#2563eb' : '#e2e8f0'),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Center(
                      child: Text(
                        number,
                        style: TextStyle(
                          color: FlartColor(isSelected ? '#ffffff' : '#475569'),
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: isFixed
                    ? const FlartColor('#dcfce7')
                    : (isNext
                        ? const FlartColor('#fef3c7')
                        : const FlartColor('#f1f5f9')),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: isFixed
                      ? const FlartColor('#15803d')
                      : (isNext
                          ? const FlartColor('#b45309')
                          : const FlartColor('#94a3b8')),
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
