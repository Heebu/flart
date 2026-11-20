import 'package:flartdart/flartdart.dart';
import '../widgets/showcase_card.dart';

class LayoutShowcase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FDColumn(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FDText(
          'Category 2: Arrangement & Positioning Widgets',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: FlartColor('#1e293b'),
          ),
        ),
        const FDSizedBox(height: 8),
        FDText(
          'Complete showcase demonstrating multi-child arrangement, alignment, stacking, wrapping, and list scrolling (no rawCss required).',
          style: TextStyle(fontSize: 16, color: FlartColor('#64748b')),
        ),
        const FDSizedBox(height: 32),
        ShowcaseCard(
          title:
              '1. FDRow (MainAxisAlignment, CrossAxisAlignment & MainAxisSize)',
          description:
              'Arranges children horizontally. Demonstrates MainAxisSize.min (content-tight width) vs MainAxisSize.max (full width), spacing, and alignment options.',
          child: FDColumn(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSectionLabel(
                  'MainAxisSize.max with MainAxisAlignment.spaceBetween:'),
              FDSizedBox(height: 8),
              FDContainer(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: FlartColor('#f8fafc'),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: FlartColor('#cbd5e1')),
                ),
                child: FDRow(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildPill('Start Item', '#3b82f6'),
                    _buildPill('Middle Item', '#10b981'),
                    _buildPill('End Item', '#8b5cf6'),
                  ],
                ),
              ),
              FDSizedBox(height: 16),
              _buildSectionLabel('MainAxisSize.min (fit-content width):'),
              FDSizedBox(height: 8),
              FDContainer(
                alignment: Alignment.centerLeft,
                child: FDContainer(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: FlartColor('#e0e7ff'),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: FlartColor('#818cf8')),
                  ),
                  child: FDRow(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 8,
                    children: [
                      _buildPill('Tight', '#4f46e5'),
                      _buildPill('Content', '#4f46e5'),
                      _buildPill('Row', '#4f46e5'),
                    ],
                  ),
                ),
              ),
              FDSizedBox(height: 16),
              _buildSectionLabel(
                  'CrossAxisAlignment.center with varying heights & spacing:'),
              FDSizedBox(height: 8),
              FDContainer(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: FlartColor('#f8fafc'),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: FlartColor('#cbd5e1')),
                ),
                child: FDRow(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 12,
                  children: [
                    _buildBlock('Tall', '#f43f5e', width: 60, height: 70),
                    _buildBlock('Medium', '#0ea5e9', width: 60, height: 50),
                    _buildBlock('Short', '#10b981', width: 60, height: 35),
                  ],
                ),
              ),
            ],
          ),
        ),
        ShowcaseCard(
          title: '2. FDColumn (MainAxisAlignment & CrossAxisAlignment)',
          description:
              'Arranges children vertically. Demonstrates MainAxisSize.min vs max, CrossAxisAlignment.stretch, and CrossAxisAlignment.end.',
          child: FDRow(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 24,
            children: [
              FDExpanded(
                child: FDColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionLabel('MainAxisSize.min (tight):'),
                    FDSizedBox(height: 8),
                    FDContainer(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: FlartColor('#f1f5f9'),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: FlartColor('#cbd5e1')),
                      ),
                      child: FDColumn(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 8,
                        children: [
                          _buildPill('Task 1: Design Phase', '#2563eb'),
                          _buildPill('Task 2: Implementation', '#059669'),
                          _buildPill('Task 3: Production Deploy', '#7c3aed'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              FDExpanded(
                child: FDColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionLabel('CrossAxisAlignment.stretch:'),
                    FDSizedBox(height: 8),
                    FDContainer(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: FlartColor('#f1f5f9'),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: FlartColor('#cbd5e1')),
                      ),
                      child: FDColumn(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: 8,
                        children: [
                          _buildPill('Full Width 1', '#0284c7'),
                          _buildPill('Full Width 2', '#d97706'),
                          _buildPill('Full Width 3', '#dc2626'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        ShowcaseCard(
          title: '3. FDStack & FDPositioned (Multi-layer Composition)',
          description:
              'Layers widgets on top of each other. Demonstrates absolute positioning, Positioned.fill background, and Clip.antiAlias clipping.',
          child: FDRow(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 24,
            children: [
              FDContainer(
                width: 240,
                height: 180,
                decoration: BoxDecoration(
                  color: FlartColor('#ffffff'),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: FlartColor('#000000').withOpacity(0.08),
                      blurRadius: 16,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: FDStack(
                  children: [
                    FDPositioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: 80,
                      child: FDContainer(
                        decoration: BoxDecoration(
                          color: FlartColor('#3b82f6'),
                        ),
                      ),
                    ),
                    FDPositioned(
                      top: 50,
                      left: 20,
                      child: FDContainer(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: FlartColor('#10b981'),
                          borderRadius: BorderRadius.circular(28),
                          border:
                              Border.all(color: FlartColors.white, width: 3),
                        ),
                        alignment: Alignment.center,
                        child: const FDText(
                          'FD',
                          style: TextStyle(
                            color: FlartColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    FDPositioned(
                      top: 12,
                      right: 12,
                      child: FDContainer(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: FlartColor('#000000').withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const FDText(
                          'Active',
                          style:
                              TextStyle(color: FlartColors.white, fontSize: 11),
                        ),
                      ),
                    ),
                    FDPositioned(
                      bottom: 16,
                      left: 20,
                      right: 20,
                      child: FDColumn(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const FDText(
                            'Flart Stack Engine',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          const FDText(
                            'Pure Dart CSS Positioned',
                            style: TextStyle(
                                color: FlartColor('#64748b'), fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              FDContainer(
                width: 240,
                height: 180,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: FlartColor('#1e293b'),
                ),
                child: FDStack(
                  children: [
                    FDPositioned.fill(
                      child: FDContainer(
                        decoration: BoxDecoration(
                          color: FlartColor('#0f172a'),
                        ),
                        alignment: Alignment.center,
                        child: const FDText(
                          'Background Layer',
                          style: TextStyle(
                              color: FlartColor('#475569'), fontSize: 13),
                        ),
                      ),
                    ),
                    FDPositioned(
                      top: 40,
                      left: 40,
                      right: 40,
                      bottom: 40,
                      child: FDContainer(
                        decoration: BoxDecoration(
                          color: FlartColor('#8b5cf6').withOpacity(0.85),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: const FDText(
                          'Centered Glass Layer',
                          style: TextStyle(
                              color: FlartColors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        ShowcaseCard(
          title: '4. FDAlign (Alignment Anchors & Factor Sizing)',
          description:
              'Positions a child within itself and sizes itself based on widthFactor and heightFactor if specified.',
          child: FDColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionLabel(
                  '9-point Alignment Matrix inside a bounded box:'),
              FDSizedBox(height: 8),
              FDContainer(
                width: 480,
                height: 160,
                decoration: BoxDecoration(
                  color: FlartColor('#f8fafc'),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: FlartColor('#cbd5e1')),
                ),
                child: FDStack(
                  children: [
                    FDAlign(
                        alignment: Alignment.topLeft,
                        child: _buildMiniAnchor('Top-Left')),
                    FDAlign(
                        alignment: Alignment.topCenter,
                        child: _buildMiniAnchor('Top-Center')),
                    FDAlign(
                        alignment: Alignment.topRight,
                        child: _buildMiniAnchor('Top-Right')),
                    FDAlign(
                        alignment: Alignment.centerLeft,
                        child: _buildMiniAnchor('Center-Left')),
                    FDAlign(
                        alignment: Alignment.center,
                        child: _buildMiniAnchor('Center', highlight: true)),
                    FDAlign(
                        alignment: Alignment.centerRight,
                        child: _buildMiniAnchor('Center-Right')),
                    FDAlign(
                        alignment: Alignment.bottomLeft,
                        child: _buildMiniAnchor('Bottom-Left')),
                    FDAlign(
                        alignment: Alignment.bottomCenter,
                        child: _buildMiniAnchor('Bottom-Center')),
                    FDAlign(
                        alignment: Alignment.bottomRight,
                        child: _buildMiniAnchor('Bottom-Right')),
                  ],
                ),
              ),
              FDSizedBox(height: 16),
              _buildSectionLabel(
                  'FDAlign with widthFactor (2.0) and heightFactor (1.5):'),
              FDSizedBox(height: 8),
              FDContainer(
                decoration: BoxDecoration(
                  color: FlartColor('#fef3c7'),
                  border: Border.all(color: FlartColor('#f59e0b')),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: FDAlign(
                  alignment: Alignment.bottomRight,
                  widthFactor: 2.0,
                  heightFactor: 1.5,
                  child: FDContainer(
                    width: 120,
                    height: 50,
                    decoration: BoxDecoration(
                      color: FlartColor('#d97706'),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    alignment: Alignment.center,
                    child: const FDText(
                      'Child (120x50)\nAlign sizes to 240x75',
                      style: TextStyle(color: FlartColors.white, fontSize: 11),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        ShowcaseCard(
          title: '5. FDCenter (Dedicated Center Primitive)',
          description:
              'Specialized subclass of FDAlign that centers its child both horizontally and vertically.',
          child: FDRow(
            spacing: 16,
            children: [
              FDContainer(
                width: 200,
                height: 120,
                decoration: BoxDecoration(
                  color: FlartColor('#ecfdf5'),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: FlartColor('#10b981')),
                ),
                child: FDCenter(
                  child: _buildPill('Centered in 200x120', '#059669'),
                ),
              ),
              FDContainer(
                decoration: BoxDecoration(
                  color: FlartColor('#eff6ff'),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: FlartColor('#3b82f6')),
                ),
                child: FDCenter(
                  widthFactor: 1.8,
                  heightFactor: 2.0,
                  child: _buildPill(
                      'widthFactor: 1.8, heightFactor: 2.0', '#2563eb'),
                ),
              ),
            ],
          ),
        ),
        ShowcaseCard(
          title: '6. FDWrap (Responsive Tag Cloud & Flow Runs)',
          description:
              'Breaks children onto new lines when horizontal space is filled. Configurable spacing, runSpacing, and WrapCrossAlignment.',
          child: FDColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionLabel(
                  'Flowing Tags with spacing: 10, runSpacing: 10:'),
              FDSizedBox(height: 8),
              FDWrap(
                spacing: 10,
                runSpacing: 10,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  _buildTag('Dart', '#3b82f6'),
                  _buildTag('Web', '#06b6d4'),
                  _buildTag('Virtual DOM', '#10b981'),
                  _buildTag('Box-Sizing', '#f59e0b'),
                  _buildTag('Flutter Parity', '#ec4899'),
                  _buildTag('Zero rawCss', '#8b5cf6'),
                  _buildTag('High Performance', '#14b8a6'),
                  _buildTag('Clean Architecture', '#6366f1'),
                  _buildTag('Declarative UI', '#ef4444'),
                  _buildTag('Reactive State', '#84cc16'),
                ],
              ),
            ],
          ),
        ),
        ShowcaseCard(
          title: '7. FDListView (Standard, Builder, Separated & Horizontal)',
          description:
              'A scrollable list of widgets arranged linearly. Demonstrates shrinkWrap, reverse, separated builders, and horizontal orientation.',
          child: FDColumn(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSectionLabel('FDListView.separated (shrinkWrap: true):'),
              FDSizedBox(height: 8),
              FDContainer(
                decoration: BoxDecoration(
                  color: FlartColor('#ffffff'),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: FlartColor('#cbd5e1')),
                ),
                child: FDListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return FDContainer(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: FDRow(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FDText(
                            'Item #${index + 1}: Category 2 Feature',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          _buildPill('Status: Fixed', '#10b981'),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const FDDivider(
                        color: FlartColor('#e2e8f0'), height: 1);
                  },
                ),
              ),
              FDSizedBox(height: 16),
              _buildSectionLabel(
                  'FDListView (scrollDirection: Axis.horizontal, shrinkWrap: true):'),
              FDSizedBox(height: 8),
              FDContainer(
                height: 100,
                decoration: BoxDecoration(
                  color: FlartColor('#f8fafc'),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: FlartColor('#cbd5e1')),
                ),
                child: FDListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(12),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return FDContainer(
                      width: 140,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: index.isEven
                            ? const FlartColor('#3b82f6')
                            : const FlartColor('#6366f1'),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color:
                                const FlartColor('#000000').withOpacity(0.08),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: FDText(
                        'Card #${index + 1}',
                        style: const TextStyle(
                          color: FlartColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionLabel(String label) {
    return FDText(
      label,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: FlartColor('#475569'),
      ),
    );
  }

  Widget _buildPill(String text, String hexColor) {
    return FDContainer(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: FlartColor(hexColor),
        borderRadius: BorderRadius.circular(16),
      ),
      child: FDText(
        text,
        style: const TextStyle(
          color: FlartColors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildBlock(String text, String hexColor,
      {required double width, required double height}) {
    return FDContainer(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: FlartColor(hexColor),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: FDText(
        text,
        style: const TextStyle(
          color: FlartColors.white,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );
  }

  Widget _buildMiniAnchor(String text, {bool highlight = false}) {
    return FDContainer(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: highlight
            ? const FlartColor('#ef4444')
            : const FlartColor('#334155'),
        borderRadius: BorderRadius.circular(4),
      ),
      child: FDText(
        text,
        style: const TextStyle(
          color: FlartColors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTag(String text, String hexColor) {
    return FDContainer(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: FlartColor(hexColor).withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: FlartColor(hexColor)),
      ),
      child: FDText(
        text,
        style: TextStyle(
          color: FlartColor(hexColor),
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
