import 'package:flartdart/flartdart.dart';
import '../widgets/showcase_card.dart';

class MediaShowcasePage extends StatefulWidget {
  const MediaShowcasePage({super.key});

  @override
  State<MediaShowcasePage> createState() => _MediaShowcasePageState();
}

class _MediaShowcasePageState extends State<MediaShowcasePage> {
  String _mediaEventStatus = 'No player events yet';
  int _linkClickCount = 0;
  bool _customElementToggled = false;

  @override
  Widget build(BuildContext context) {
    return FDColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FDContainer(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: FlartColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const FlartColor('#e2e8f0')),
          ),
          child: FDColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FDRow(
                children: [
                  FDContainer(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const FlartColor('#0284c7'),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const FDText(
                      'CATEGORY 8',
                      style: TextStyle(
                        color: FlartColors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const FDText(
                    'Media & Web Widgets',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: FlartColor('#0f172a'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const FDText(
                'Comprehensive support for HTML5 video, audio, sandboxed iframes, YouTube embeds, map embeds, interactive anchor links, custom VDOM elements, and raw HTML ingestion without raw CSS escape hatches.',
                style: TextStyle(fontSize: 14, color: FlartColor('#64748b')),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ShowcaseCard(
          title: 'HTML5 Video & Audio Players',
          description:
              'Native browser media players with hardware playback controls and Dart event listeners for play, pause, and ended.',
          child: FDColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FDRow(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FDColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const FDText('VideoPlayer (HTML5):',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      VideoPlayer(
                        src: 'https://www.w3schools.com/html/mov_bbb.mp4',
                        width: 320,
                        height: 180,
                        controls: true,
                        borderRadius: BorderRadius.circular(8),
                        onPlay: () {
                          setState(() => _mediaEventStatus =
                              'Video Playing 🎬 (at ${DateTime.now().toIso8601String().substring(11, 19)})');
                        },
                        onPause: () {
                          setState(() => _mediaEventStatus =
                              'Video Paused ⏸️ (at ${DateTime.now().toIso8601String().substring(11, 19)})');
                        },
                      ),
                    ],
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: FDColumn(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const FDText('AudioPlayer (HTML5):',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        AudioPlayer(
                          src: 'https://www.w3schools.com/html/horse.mp3',
                          controls: true,
                          onPlay: () {
                            setState(() => _mediaEventStatus =
                                'Audio Playing 🎵 (at ${DateTime.now().toIso8601String().substring(11, 19)})');
                          },
                          onPause: () {
                            setState(() => _mediaEventStatus =
                                'Audio Paused ⏸️ (at ${DateTime.now().toIso8601String().substring(11, 19)})');
                          },
                        ),
                        const SizedBox(height: 16),
                        FDContainer(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: const FlartColor('#f1f5f9'),
                            borderRadius: BorderRadius.circular(6),
                            border:
                                Border.all(color: const FlartColor('#e2e8f0')),
                          ),
                          child: FDText(
                            'Media Event Log: $_mediaEventStatus',
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: FlartColors.indigo),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ShowcaseCard(
          title: 'YouTube Embed & Interactive Map',
          description:
              'Ready-to-use specialized embeds with clean URL parameter generation and responsive sizing.',
          child: FDRow(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FDColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FDText('YouTube Player Embed:',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  const YouTubePlayer(
                    videoId: 'dQw4w9WgXcQ',
                    width: 340,
                    height: 190,
                    controls: true,
                  ),
                ],
              ),
              const SizedBox(width: 24),
              FDColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FDText('Google Maps Embed (San Francisco):',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  const MapEmbed(
                    location: 'San Francisco, CA',
                    width: 340,
                    height: 190,
                    zoom: 12,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ShowcaseCard(
          title: 'Sandboxed IFrame (FDIframe / IFrame)',
          description:
              'Embed arbitrary web documents and interactive web apps with configurable borders and sandbox permissions.',
          child: FDColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IFrame(
                src: 'https://example.com',
                title: 'Example Domain Embed',
                height: 140,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const FlartColor('#cbd5e1')),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ShowcaseCard(
          title: 'Web Hyperlinks (FDLink)',
          description:
              'Standard anchor links with security attributes (noopener, noreferrer), new tab controls, and tap event listeners.',
          child: FDRow(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FDLink(
                url: 'https://github.com/Heebu/flart',
                openInNewTab: true,
                onTap: () {
                  setState(() => _linkClickCount++);
                },
                child: FDContainer(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: const FlartColor('#0f172a'),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const FDRow(
                    children: [
                      FDIcon(
                        icon: FDIcons.code,
                        color: FlartColors.white,
                        size: 18,
                      ),
                      SizedBox(width: 8),
                      FDText(
                        'Flart on GitHub ↗',
                        style: TextStyle(
                          color: FlartColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FDLink(
                url: 'https://flutter.dev',
                openInNewTab: true,
                onTap: () {
                  setState(() => _linkClickCount++);
                },
                child: FDContainer(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: const FlartColor('#0284c7'),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const FDText(
                    'Flutter Documentation ↗',
                    style: TextStyle(
                      color: FlartColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              FDText(
                'Link Clicks: $_linkClickCount',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ShowcaseCard(
          title: 'Native VDOM Element Builder (FDElement)',
          description:
              'Construct arbitrary semantic HTML elements directly with typed attributes, inline styles, and web events.',
          child: FDColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FDRow(
                spacing: 12,
                children: [
                  FDElement(
                    tag: 'button',
                    attributes: {
                      'type': 'button',
                      'aria-label': 'Interactive Native Button',
                    },
                    styles: {
                      'padding': '10px 18px',
                      'background-color':
                          _customElementToggled ? '#10b981' : '#6366f1',
                      'color': 'white',
                      'border': 'none',
                      'border-radius': '6px',
                      'cursor': 'pointer',
                      'font-weight': '600',
                    },
                    textContent: _customElementToggled
                        ? 'Native Element: ACTIVE 🟢'
                        : 'Click Native Element',
                    events: {
                      'click': (e) {
                        setState(() =>
                            _customElementToggled = !_customElementToggled);
                      },
                    },
                  ),
                  const FDElement(
                    tag: 'kbd',
                    styles: {
                      'padding': '4px 8px',
                      'background-color': '#e2e8f0',
                      'border-radius': '4px',
                      'border': '1px solid #cbd5e1',
                      'font-family': 'monospace',
                    },
                    textContent: 'Ctrl + Alt + F',
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ShowcaseCard(
          title: 'Raw HTML Ingestion (FDRawHTML / RawHtml)',
          description:
              'Safely ingest existing HTML blocks, vector graphics, and formatted web snippets into the Flart VDOM tree.',
          child: const FDRawHTML(
            '''
            <div style="display: flex; gap: 12px; align-items: center; padding: 12px; background: #f8fafc; border-radius: 8px; border: 1px solid #e2e8f0;">
              <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <circle cx="12" cy="12" r="10"></circle>
                <line x1="2" y1="12" x2="22" y2="12"></line>
                <path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path>
              </svg>
              <div>
                <strong style="color: #1e293b; font-size: 14px;">Inline SVG & Raw HTML Markup</strong>
                <p style="margin: 2px 0 0; color: #64748b; font-size: 12px;">Rendered directly through FlartRawHtmlNode without losing VDOM reconciliation.</p>
              </div>
            </div>
            ''',
          ),
        ),
      ],
    );
  }
}
