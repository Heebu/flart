import 'package:flartdart/flartdart.dart';
import '../widgets/showcase_card.dart';

class TextShowcase extends StatefulWidget {
  @override
  State<TextShowcase> createState() => _TextShowcaseState();
}

class _TextShowcaseState extends State<TextShowcase> {
  int _richSpanClicks = 0;
  String _lastActionClicked = 'None yet';
  final TextEditingController _singleLineCtrl = TextEditingController(text: 'Flart Web Typography');
  final TextEditingController _multiLineCtrl = TextEditingController(
    text: 'Flart gives you Flutter-like widgets compiling directly to clean DOM nodes.\nZero heavy canvas, instant startup, pure Dart Web.',
  );

  @override
  void initState() {
    super.initState();
    _singleLineCtrl.addListener(() => setState(() {}));
    _multiLineCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _singleLineCtrl.dispose();
    _multiLineCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FDColumn(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FDText(
          'Category 4: Text Widgets & Typography',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: FlartColor('#0f172a'),
          ),
        ),
        FDSizedBox(height: 8),
        FDText(
          'Exhaustive demonstration of all Category 4 widgets: FDText, Text.rich, FDRichText, TextSpan, FDSelectableText, FDLinkText, and FDEditableText — with zero raw CSS.',
          style: TextStyle(
            fontSize: 16,
            color: FlartColor('#64748b'),
            height: 1.5,
          ),
        ),
        FDSizedBox(height: 24),

        // 1. Typography & Font Hierarchy
        ShowcaseCard(
          title: '1. Typography & Font Weights (FDText)',
          description: 'Full font scale from w100 to w900, italic styles, letter spacing, and line heights.',
          child: FDColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FDText(
                'Display Large (34px, w900 Black)',
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900, color: FlartColor('#1e293b')),
              ),
              FDSizedBox(height: 6),
              FDText(
                'Headline Medium (24px, w700 Bold)',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: FlartColor('#334155')),
              ),
              FDSizedBox(height: 6),
              FDText(
                'Title Medium (18px, w600 SemiBold, Letter Spacing 1.5px)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                  color: FlartColor('#475569'),
                ),
              ),
              FDSizedBox(height: 6),
              FDText(
                'Body Regular (15px, w400 Normal, Word Spacing 3px, Italic)',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  wordSpacing: 3.0,
                  color: FlartColor('#64748b'),
                ),
              ),
              FDSizedBox(height: 6),
              FDText(
                'Caption Light (13px, w300 Light, Letter Spacing 2px)',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 2.0,
                  color: FlartColor('#94a3b8'),
                ),
              ),
            ],
          ),
        ),

        // 2. Text Decorations & Styles
        ShowcaseCard(
          title: '2. Text Decorations & Styles (TextDecoration)',
          description: 'Underline, line-through, overline, wavy/dashed/dotted styles, custom thickness, and combined decorations.',
          child: FDWrap(
            spacing: 16,
            runSpacing: 12,
            children: [
              FDContainer(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: FlartColor('#f8fafc'),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: FlartColor('#e2e8f0')),
                ),
                child: FDText(
                  'Underline (Solid Red)',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    decorationColor: FlartColor('#ef4444'),
                    decorationThickness: 2,
                  ),
                ),
              ),
              FDContainer(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: FlartColor('#f8fafc'),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: FlartColor('#e2e8f0')),
                ),
                child: FDText(
                  'Wavy Underline (Blue)',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    decorationColor: FlartColor('#3b82f6'),
                    decorationStyle: TextDecorationStyle.wavy,
                    decorationThickness: 2,
                  ),
                ),
              ),
              FDContainer(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: FlartColor('#f8fafc'),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: FlartColor('#e2e8f0')),
                ),
                child: FDText(
                  'Strikethrough (Line-Through)',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: FlartColor('#94a3b8'),
                  ),
                ),
              ),
              FDContainer(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: FlartColor('#f8fafc'),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: FlartColor('#e2e8f0')),
                ),
                child: FDText(
                  'Combined (Underline + Line-Through)',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.combine([
                      TextDecoration.underline,
                      TextDecoration.lineThrough,
                    ]),
                    decorationColor: FlartColor('#8b5cf6'),
                  ),
                ),
              ),
              FDContainer(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: FlartColor('#fef3c7'),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: FlartColor('#fde68a')),
                ),
                child: FDText(
                  'Background Highlight',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: FlartColor('#92400e'),
                    backgroundColor: FlartColor('#fde68a'),
                  ),
                ),
              ),
            ],
          ),
        ),

        // 3. Overflow & Line Clamping
        ShowcaseCard(
          title: '3. Overflow & Clamping (TextOverflow & maxLines)',
          description: 'Clamps text cleanly to 1, 2, or 3 lines with ellipsis using standard CSS line clamping without manual height hacks.',
          child: FDColumn(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FDText(
                'Single Line Ellipsis (overflow: TextOverflow.ellipsis):',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: FlartColor('#475569')),
              ),
              FDSizedBox(height: 4),
              FDContainer(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: FlartColor('#f1f5f9'),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: FDText(
                  'The quick brown fox jumps over the lazy dog repeatedly again and again and keeps going beyond the edge of the container to prove that single-line ellipsis truncates cleanly.',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: FlartColor('#0f172a')),
                ),
              ),
              FDSizedBox(height: 14),
              FDText(
                '2-Line Clamping (maxLines: 2, overflow: TextOverflow.ellipsis):',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: FlartColor('#475569')),
              ),
              FDSizedBox(height: 4),
              FDContainer(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: FlartColor('#f1f5f9'),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: FDText(
                  'Flart provides a full reactive declarative component model for modern web apps. Even when this paragraph contains very long descriptions spanning multiple sentences, it cleanly clamps to exactly two visible lines with an ellipsis automatically appended at the truncation boundary.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: FlartColor('#0f172a'), height: 1.4),
                ),
              ),
            ],
          ),
        ),

        // 4. RichText & Interactive Clickable TextSpans
        ShowcaseCard(
          title: '4. RichText & Interactive Spans (FDRichText & TextSpan)',
          description: 'Nested inline spans with distinct formatting and live interactive tap recognizers in pure DOM.',
          child: FDColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FDRichText(
                text: TextSpan(
                  text: 'Welcome to ',
                  style: TextStyle(fontSize: 18, color: FlartColor('#1e293b')),
                  children: [
                    TextSpan(
                      text: 'Flart Web Framework',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: FlartColor('#2563eb'),
                      ),
                    ),
                    TextSpan(
                      text: '! Click this ',
                      style: TextStyle(fontSize: 18, color: FlartColor('#1e293b')),
                    ),
                    TextSpan(
                      text: 'Interactive Pill [Click Me]',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: FlartColor('#ffffff'),
                        backgroundColor: FlartColor('#059669'),
                        decoration: TextDecoration.underline,
                      ),
                      onTap: () {
                        setState(() {
                          _richSpanClicks++;
                        });
                      },
                    ),
                    TextSpan(
                      text: ' to dispatch reactive events directly from an inline text span.',
                      style: TextStyle(fontSize: 18, color: FlartColor('#1e293b')),
                    ),
                  ],
                ),
              ),
              FDSizedBox(height: 12),
              FDContainer(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: FlartColor('#ecfdf5'),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: FlartColor('#a7f3d0')),
                ),
                child: FDText(
                  'Inline TextSpan Click Counter: $_richSpanClicks clicks recorded',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: FlartColor('#065f46'),
                  ),
                ),
              ),
            ],
          ),
        ),

        // 5. SelectableText (Copyable Text)
        ShowcaseCard(
          title: '5. Selectable Text (FDSelectableText)',
          description: 'Enables native browser text selection and copy/paste functionality for code blocks or quotes.',
          child: FDContainer(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: FlartColor('#0f172a'),
              borderRadius: BorderRadius.circular(8),
            ),
            child: FDColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FDText(
                  '// Try selecting and copying this code snippet:',
                  style: TextStyle(fontSize: 12, color: FlartColor('#64748b'), fontStyle: FontStyle.italic),
                ),
                FDSizedBox(height: 6),
                FDSelectableText(
                  'final widget = FDText.rich(\n'
                  '  TextSpan(\n'
                  '    text: "Hello",\n'
                  '    style: TextStyle(fontWeight: FontWeight.bold),\n'
                  '  ),\n'
                  ');',
                  style: TextStyle(
                    fontSize: 14,
                    color: FlartColor('#38bdf8'),
                    fontFamily: 'monospace',
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),

        // 6. LinkText (Hyperlinks & Action Links)
        ShowcaseCard(
          title: '6. Hyperlinks & Action Links (FDLinkText)',
          description: 'Anchor tags with URL navigation or inline clickable links executing Dart callbacks.',
          child: FDColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FDRow(
                spacing: 20,
                children: [
                  FDLinkText(
                    text: 'External: GitHub Repository ↗',
                    href: 'https://github.com/google',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: FlartColor('#2563eb'),
                    ),
                  ),
                  FDLinkText(
                    text: 'Action: Clear Counters',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: FlartColor('#dc2626'),
                    ),
                    onPressed: () {
                      setState(() {
                        _richSpanClicks = 0;
                        _lastActionClicked = 'Cleared click counters at ${DateTime.now().toIso8601String().substring(11, 19)}';
                      });
                    },
                  ),
                  FDLinkText(
                    text: 'Action: Reset Fields',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: FlartColor('#7c3aed'),
                    ),
                    onPressed: () {
                      setState(() {
                        _singleLineCtrl.text = 'Flart Web Typography';
                        _lastActionClicked = 'Reset text field inputs at ${DateTime.now().toIso8601String().substring(11, 19)}';
                      });
                    },
                  ),
                ],
              ),
              FDSizedBox(height: 10),
              FDText(
                'Last Action Executed: $_lastActionClicked',
                style: TextStyle(fontSize: 13, color: FlartColor('#64748b'), fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),

        // 7. EditableText (Single & Multiline Inputs)
        ShowcaseCard(
          title: '7. Pure Editable Text (FDEditableText)',
          description: 'The leaf input and multiline textarea primitive with live bidirectional controller binding.',
          child: FDColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FDText(
                'Single-Line FDEditableText (with live mirror below):',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: FlartColor('#334155')),
              ),
              FDSizedBox(height: 8),
              FDEditableText(
                controller: _singleLineCtrl,
                placeholder: 'Type your title...',
                style: TextStyle(fontSize: 16, color: FlartColor('#0f172a')),
              ),
              FDSizedBox(height: 8),
              FDContainer(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: FlartColor('#f8fafc'),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: FlartColor('#cbd5e1')),
                ),
                child: FDRow(
                  children: [
                    FDText('Live Mirror: ', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: FlartColor('#64748b'))),
                    FDText(_singleLineCtrl.text.isEmpty ? '(empty)' : _singleLineCtrl.text, style: TextStyle(fontSize: 14, color: FlartColor('#0f172a'))),
                  ],
                ),
              ),
              FDSizedBox(height: 18),
              FDText(
                'Multiline FDEditableText (maxLines: 4, textarea mode):',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: FlartColor('#334155')),
              ),
              FDSizedBox(height: 8),
              FDEditableText(
                controller: _multiLineCtrl,
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                placeholder: 'Enter longer content...',
                style: TextStyle(fontSize: 15, color: FlartColor('#0f172a'), height: 1.4),
              ),
              FDSizedBox(height: 8),
              FDText(
                'Stats: ${_multiLineCtrl.text.length} characters | ${_multiLineCtrl.text.split(RegExp(r"\\s+")).where((w) => w.isNotEmpty).length} words',
                style: TextStyle(fontSize: 12, color: FlartColor('#64748b')),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
