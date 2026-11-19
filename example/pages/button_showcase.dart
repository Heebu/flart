import 'package:flartdart/flartdart.dart';
import '../widgets/showcase_card.dart';

class ButtonShowcase extends StatefulWidget {
  @override
  State<ButtonShowcase> createState() => _ButtonShowcaseState();
}

class _ButtonShowcaseState extends State<ButtonShowcase> {
  int _clickCount = 0;
  String _lastAction = 'None';
  String _gestureLog = 'Waiting for gesture on target box...';
  bool _isHoveringInkWell = false;

  void _recordAction(String action) {
    setState(() {
      _clickCount++;
      _lastAction = '$action (at ${DateTime.now().toIso8601String().substring(11, 19)})';
    });
  }

  @override
  Widget build(BuildContext context) {
    return FDColumn(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FDText(
          'Category 5: Button & Interaction Widgets',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: FlartColor('#0f172a'),
          ),
        ),
        FDSizedBox(height: 8),
        FDText(
          'Exhaustive demonstration of all Category 5 widgets: FDElevatedButton, FDOutlinedButton, FDTextButton, FDIconButton, FDInkWell, and FDGestureDetector — configured with pure ButtonStyle and zero raw CSS.',
          style: TextStyle(
            fontSize: 16,
            color: FlartColor('#64748b'),
            height: 1.5,
          ),
        ),
        FDSizedBox(height: 20),

        // Live Action Status Dashboard
        FDContainer(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          margin: EdgeInsets.only(bottom: 24),
          decoration: BoxDecoration(
            color: FlartColor('#f8fafc'),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: FlartColor('#cbd5e1')),
          ),
          child: FDRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FDText(
                'Total Button Clicks: $_clickCount',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: FlartColor('#0f172a'),
                ),
              ),
              FDText(
                'Last Action: $_lastAction',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: FlartColor('#2563eb'),
                ),
              ),
            ],
          ),
        ),

        // 1. ElevatedButton Showcase
        ShowcaseCard(
          title: '1. Elevated Buttons (FDElevatedButton)',
          description: 'Solid filled buttons with depth shadow, custom ButtonStyle, icon variants, and disabled states.',
          child: FDWrap(
            spacing: 16,
            runSpacing: 14,
            children: [
              FDElevatedButton(
                onPressed: () => _recordAction('Default Elevated Button'),
                child: FDText('Primary Action'),
              ),
              FDElevatedButton.icon(
                onPressed: () => _recordAction('ElevatedButton.icon (Send)'),
                icon: FDIcon(icon: FDIcons.send, size: 16, color: FlartColors.white),
                label: FDText('Send Message'),
              ),
              FDElevatedButton(
                onPressed: () => _recordAction('Custom Purple Pill Button'),
                style: FDElevatedButton.styleFrom(
                  backgroundColor: FlartColor('#7c3aed'),
                  foregroundColor: FlartColors.white,
                  elevation: 6,
                  shape: BorderRadius.circular(24),
                  padding: EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                ),
                child: FDText('Custom Pill (Elevation 6)'),
              ),
              FDElevatedButton(
                onPressed: () => _recordAction('Emerald Success Button'),
                style: FDElevatedButton.styleFrom(
                  backgroundColor: FlartColor('#059669'),
                  foregroundColor: FlartColors.white,
                  shape: BorderRadius.circular(8),
                ),
                child: FDText('Confirm Success'),
              ),
              FDElevatedButton(
                onPressed: null,
                child: FDText('Disabled Elevated'),
              ),
            ],
          ),
        ),

        // 2. OutlinedButton Showcase
        ShowcaseCard(
          title: '2. Outlined Buttons (FDOutlinedButton)',
          description: 'Border-framed buttons with transparent background, custom BorderSide, and hover states.',
          child: FDWrap(
            spacing: 16,
            runSpacing: 14,
            children: [
              FDOutlinedButton(
                onPressed: () => _recordAction('Default Outlined Button'),
                child: FDText('Standard Outline'),
              ),
              FDOutlinedButton.icon(
                onPressed: () => _recordAction('OutlinedButton.icon (Download)'),
                icon: FDIcon(icon: FDIcons.download, size: 16, color: FlartColor('#2563eb')),
                label: FDText('Download Asset'),
              ),
              FDOutlinedButton(
                onPressed: () => _recordAction('Thick Crimson Outline'),
                style: FDOutlinedButton.styleFrom(
                  foregroundColor: FlartColor('#dc2626'),
                  side: BorderSide(color: FlartColor('#dc2626'), width: 2),
                  shape: BorderRadius.circular(10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: FDText('Danger Action (2px Red)'),
              ),
              FDOutlinedButton(
                onPressed: () => _recordAction('Amber Pill Outline'),
                style: FDOutlinedButton.styleFrom(
                  foregroundColor: FlartColor('#d97706'),
                  side: BorderSide(color: FlartColor('#d97706'), width: 1.5),
                  shape: BorderRadius.circular(24),
                ),
                child: FDText('Rounded Amber Pill'),
              ),
              FDOutlinedButton(
                onPressed: null,
                child: FDText('Disabled Outlined'),
              ),
            ],
          ),
        ),

        // 3. TextButton Showcase
        ShowcaseCard(
          title: '3. Text Buttons (FDTextButton)',
          description: 'Minimal borderless action buttons suitable for dialog actions, tables, and low-emphasis actions.',
          child: FDWrap(
            spacing: 16,
            runSpacing: 14,
            children: [
              FDTextButton(
                onPressed: () => _recordAction('Standard Text Button'),
                label: 'Cancel Action',
              ),
              FDTextButton.icon(
                onPressed: () => _recordAction('TextButton.icon (Bookmark)'),
                icon: FDIcon(icon: FDIcons.favorite, size: 16, color: FlartColor('#2563eb')),
                label: FDText('Bookmark Item'),
              ),
              FDTextButton(
                onPressed: () => _recordAction('Purple Text Action'),
                style: FDTextButton.styleFrom(
                  foregroundColor: FlartColor('#9333ea'),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                child: FDText('Learn More →'),
              ),
              FDTextButton(
                onPressed: null,
                label: 'Disabled Text Button',
              ),
            ],
          ),
        ),

        // 4. IconButton Showcase
        ShowcaseCard(
          title: '4. Icon Buttons (FDIconButton)',
          description: 'Circular touch targets for icons with built-in tooltips, customizable size, color, and padding.',
          child: FDWrap(
            spacing: 20,
            runSpacing: 14,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              FDIconButton(
                icon: FDIcon(icon: FDIcons.settings, size: 22, color: FlartColor('#475569')),
                tooltip: 'Settings',
                onPressed: () => _recordAction('IconButton: Settings'),
              ),
              FDIconButton(
                icon: FDIcon(icon: FDIcons.favorite, size: 24, color: FlartColor('#ef4444')),
                tooltip: 'Add to Favorites',
                onPressed: () => _recordAction('IconButton: Favorite'),
              ),
              FDIconButton(
                icon: FDIcon(icon: FDIcons.search, size: 20, color: FlartColor('#2563eb')),
                tooltip: 'Search Catalog',
                onPressed: () => _recordAction('IconButton: Search'),
              ),
              FDIconButton(
                icon: FDIcon(icon: FDIcons.notifications, size: 26, color: FlartColor('#f59e0b')),
                tooltip: 'Notifications',
                onPressed: () => _recordAction('IconButton: Notifications'),
              ),
              FDIconButton(
                icon: FDIcon(icon: FDIcons.share, size: 22, color: FlartColor('#059669')),
                tooltip: 'Share Link',
                onPressed: () => _recordAction('IconButton: Share'),
              ),
              FDIconButton(
                icon: FDIcon(icon: FDIcons.refresh, size: 22),
                tooltip: 'Disabled Refresh',
                onPressed: null,
              ),
            ],
          ),
        ),

        // 5. InkWell Showcase
        ShowcaseCard(
          title: '5. Interactive Tiles & Ink Response (FDInkWell)',
          description: 'Touch-responsive rectangular or rounded surfaces with hover background transitions and click/double-click recognizers.',
          child: FDRow(
            spacing: 20,
            children: [
              Expanded(
                child: FDInkWell(
                  onTap: () => _recordAction('InkWell Tile 1 Clicked'),
                  onDoubleTap: () => _recordAction('InkWell Tile 1 Double-Clicked!'),
                  onHover: (hovered) {
                    setState(() => _isHoveringInkWell = hovered);
                  },
                  borderRadius: BorderRadius.circular(12),
                  hoverColor: FlartColor('#dbeafe'),
                  splashColor: FlartColor('#bfdbfe'),
                  child: FDContainer(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _isHoveringInkWell ? FlartColor('#3b82f6') : FlartColor('#e2e8f0'),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: FDColumn(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FDRow(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FDText(
                              'Interactive Tile A',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: FlartColor('#1e293b')),
                            ),
                            FDIcon(icon: FDIcons.star, size: 20, color: FlartColor('#f59e0b')),
                          ],
                        ),
                        FDSizedBox(height: 6),
                        FDText(
                          'Hover over me or click/double-click. State transitions to dynamic blue tint.',
                          style: TextStyle(fontSize: 13, color: FlartColor('#64748b')),
                        ),
                        FDSizedBox(height: 8),
                        FDText(
                          _isHoveringInkWell ? '• Status: Currently Hovering' : '• Status: Idle',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _isHoveringInkWell ? FlartColor('#2563eb') : FlartColor('#94a3b8'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: FDInkWell(
                  onTap: () => _recordAction('InkWell Tile 2 (Emerald) Clicked'),
                  onLongPress: () => _recordAction('InkWell Tile 2 Long-Pressed!'),
                  borderRadius: BorderRadius.circular(12),
                  hoverColor: FlartColor('#d1fae5'),
                  splashColor: FlartColor('#a7f3d0'),
                  child: FDContainer(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(color: FlartColor('#e2e8f0'), width: 1.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: FDColumn(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FDRow(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FDText(
                              'Interactive Tile B (Long Press)',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: FlartColor('#1e293b')),
                            ),
                            FDIcon(icon: FDIcons.favorite, size: 20, color: FlartColor('#10b981')),
                          ],
                        ),
                        FDSizedBox(height: 6),
                        FDText(
                          'Supports tap and 600ms long-press detection with emerald splash ripple.',
                          style: TextStyle(fontSize: 13, color: FlartColor('#64748b')),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // 6. GestureDetector Playground
        ShowcaseCard(
          title: '6. Gesture Recognition Surface (FDGestureDetector)',
          description: 'Detects Tap, Double Tap, Long Press, Context Menu (Right-Click), and Hover interactions.',
          child: FDColumn(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FDGestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() => _gestureLog = 'Single Tap Detected! 🎯');
                  _recordAction('GestureDetector: Single Tap');
                },
                onDoubleTap: () {
                  setState(() => _gestureLog = 'Double Tap Detected! ⚡⚡');
                  _recordAction('GestureDetector: Double Tap');
                },
                onLongPress: () {
                  setState(() => _gestureLog = 'Long Press (600ms hold) Triggered! ⏳');
                  _recordAction('GestureDetector: Long Press');
                },
                onContextMenu: () {
                  setState(() => _gestureLog = 'Context Menu (Right Click) Intercepted! 📋');
                  _recordAction('GestureDetector: Right Click');
                },
                onHoverEnter: () {
                  setState(() => _gestureLog = 'Pointer Entered Gesture Surface 👆');
                },
                onHoverExit: () {
                  setState(() => _gestureLog = 'Pointer Exited Gesture Surface 👋');
                },
                child: FDContainer(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  decoration: BoxDecoration(
                    color: FlartColor('#0f172a'),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: FlartColor('#334155')),
                  ),
                  child: FDColumn(
                    children: [
                      FDIcon(icon: FDIcons.touch_app, size: 44, color: FlartColor('#38bdf8')),
                      FDSizedBox(height: 12),
                      FDText(
                        'Gesture Recognition Target Pad',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: FlartColor('#ffffff'),
                        ),
                      ),
                      FDSizedBox(height: 6),
                      FDText(
                        'Click, Double-Click, Hold (Long Press), or Right-Click anywhere in this box',
                        style: TextStyle(fontSize: 14, color: FlartColor('#94a3b8')),
                      ),
                    ],
                  ),
                ),
              ),
              FDSizedBox(height: 12),
              FDContainer(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: FlartColor('#ecfdf5'),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: FlartColor('#a7f3d0')),
                ),
                child: FDRow(
                  children: [
                    FDText('Live Recognition Log: ', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: FlartColor('#065f46'))),
                    FDText(_gestureLog, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: FlartColor('#047857'))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
