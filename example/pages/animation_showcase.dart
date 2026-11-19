import 'package:flartdart/flartdart.dart';
import '../widgets/showcase_card.dart';

class AnimationShowcasePage extends StatefulWidget {
  const AnimationShowcasePage({super.key});

  @override
  State<AnimationShowcasePage> createState() => _AnimationShowcasePageState();
}

class _AnimationShowcasePageState extends State<AnimationShowcasePage> {
  // AnimatedContainer state
  bool _containerExpanded = false;

  // Opacity & CrossFade state
  double _opacityValue = 1.0;
  bool _showFirstCrossfade = true;

  // Transform states
  double _turns = 0.0;
  double _scale = 1.0;
  Offset _slideOffset = Offset.zero;

  // Positioned state
  bool _positionedEnd = false;

  // Entrance toggle
  int _entranceResetKey = 0;

  @override
  Widget build(BuildContext context) {
    return FDColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category Header
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
                      color: FlartColors.indigo,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const FDText(
                      'CATEGORY 7',
                      style: TextStyle(
                        color: FlartColors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const FDText(
                    'Animation & Effect Widgets',
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
                'Implicitly animated widgets, transform transitions, crossfade effects, Hero markers, and WebGL shaders matching Flutter specification without raw CSS string injection.',
                style: TextStyle(fontSize: 14, color: FlartColor('#64748b')),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Card 1: FDAnimatedContainer
        ShowcaseCard(
          title: 'FDAnimatedContainer (Implicit Transitions)',
          description:
              'Seamlessly interpolates size, color, border radius, and shadow using hardware-accelerated CSS transitions without manual controller wiring.',
          child: FDColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FDCenter(
                child: FDAnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.fastOutSlowIn,
                  width: _containerExpanded ? 280 : 120,
                  height: _containerExpanded ? 130 : 80,
                  decoration: BoxDecoration(
                    color: _containerExpanded
                        ? const FlartColor('#10b981')
                        : const FlartColor('#3b82f6'),
                    borderRadius:
                        BorderRadius.circular(_containerExpanded ? 28 : 8),
                    boxShadow: _containerExpanded
                        ? const [
                            BoxShadow(
                              color: FlartColor('#a7f3d0'),
                              offset: Offset(0, 10),
                              blurRadius: 20,
                            )
                          ]
                        : null,
                  ),
                  child: FDCenter(
                    child: FDText(
                      _containerExpanded ? 'Expanded & Styled ✨' : 'Compact Box',
                      style: const TextStyle(
                        color: FlartColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FDRow(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FDElevatedButton(
                    onPressed: () {
                      setState(() {
                        _containerExpanded = !_containerExpanded;
                      });
                    },
                    style: FDElevatedButton.styleFrom(
                      backgroundColor: FlartColors.indigo,
                      foregroundColor: FlartColors.white,
                    ),
                    child: FDText(_containerExpanded
                        ? 'Collapse Box'
                        : 'Animate Container'),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Card 2: FDAnimatedOpacity & FDAnimatedCrossFade
        ShowcaseCard(
          title: 'AnimatedOpacity & AnimatedCrossFade',
          description:
              'Smooth opacity fading and pure VDOM crossfade between two alternate widgets.',
          child: FDColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FDRow(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedOpacity(
                    opacity: _opacityValue,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    child: FDContainer(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: const FlartColor('#8b5cf6'),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const FDText(
                        'Variable Opacity Widget',
                        style: TextStyle(
                            color: FlartColors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  FDElevatedButton(
                    onPressed: () {
                      setState(() {
                        _opacityValue = _opacityValue == 1.0 ? 0.2 : 1.0;
                      });
                    },
                    child: FDText(_opacityValue == 1.0
                        ? 'Fade Out (0.2)'
                        : 'Fade In (1.0)'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const FDText('AnimatedCrossFade:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              AnimatedCrossFade(
                crossFadeState: _showFirstCrossfade
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 500),
                firstChild: FDContainer(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const FlartColor('#fef3c7'),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const FlartColor('#f59e0b')),
                  ),
                  child: const FDText(
                    '⚡ View A: Primary Alert Banner',
                    style: TextStyle(
                        color: FlartColor('#92400e'),
                        fontWeight: FontWeight.w600),
                  ),
                ),
                secondChild: FDContainer(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const FlartColor('#ecfdf5'),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const FlartColor('#10b981')),
                  ),
                  child: const FDText(
                    '✅ View B: Success Confirmation View',
                    style: TextStyle(
                        color: FlartColor('#065f46'),
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              FDOutlinedButton(
                onPressed: () {
                  setState(() {
                    _showFirstCrossfade = !_showFirstCrossfade;
                  });
                },
                child: const FDText('Toggle CrossFade View'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Card 3: Transform Transitions (Rotation, Scale, Slide)
        ShowcaseCard(
          title: 'Transform Animations (Rotation, Scale, Slide)',
          description:
              'Independent hardware-accelerated transforms powered by AnimatedRotation, AnimatedScale, and AnimatedSlide.',
          child: FDRow(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Rotation
              FDColumn(
                children: [
                  AnimatedRotation(
                    turns: _turns,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.fastOutSlowIn,
                    child: FDContainer(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: FlartColors.indigo,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const FDCenter(
                        child: FDIcon(
                          icon: FDIcons.refresh,
                          color: FlartColors.white,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  FDOutlinedButton(
                    onPressed: () {
                      setState(() => _turns += 0.25);
                    },
                    child: const FDText('+90° Rotate'),
                  ),
                ],
              ),

              // Scale
              FDColumn(
                children: [
                  AnimatedScale(
                    scale: _scale,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    child: FDContainer(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: FlartColors.teal,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const FDCenter(
                        child: FDIcon(
                          icon: FDIcons.favorite,
                          color: FlartColors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  FDOutlinedButton(
                    onPressed: () {
                      setState(() => _scale = _scale == 1.0 ? 1.4 : 1.0);
                    },
                    child: FDText(_scale == 1.0 ? 'Pulse 1.4x' : 'Reset Scale'),
                  ),
                ],
              ),

              // Slide
              FDColumn(
                children: [
                  AnimatedSlide(
                    offset: _slideOffset,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.fastOutSlowIn,
                    child: FDContainer(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: FlartColors.orange,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const FDCenter(
                        child: FDIcon(
                          icon: FDIcons.send,
                          color: FlartColors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  FDOutlinedButton(
                    onPressed: () {
                      setState(() => _slideOffset = _slideOffset == Offset.zero
                          ? const Offset(0.3, 0)
                          : Offset.zero);
                    },
                    child: const FDText('Slide Right'),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Card 4: AnimatedPositioned in a Stack
        ShowcaseCard(
          title: 'AnimatedPositioned in FDStack',
          description:
              'Smooth 2D coordinate positioning of children inside bounded layout stacks.',
          child: FDColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FDContainer(
                width: 300,
                height: 150,
                decoration: BoxDecoration(
                  color: const FlartColor('#f8fafc'),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const FlartColor('#cbd5e1')),
                ),
                child: FDStack(
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn,
                      left: _positionedEnd ? 220 : 16,
                      top: _positionedEnd ? 80 : 16,
                      child: FDContainer(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: FlartColors.indigo,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: const [
                            BoxShadow(
                              color: FlartColor('#c7d2fe'),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const FDCenter(
                          child: FDIcon(
                            icon: FDIcons.bolt,
                            color: FlartColors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              FDElevatedButton(
                onPressed: () {
                  setState(() {
                    _positionedEnd = !_positionedEnd;
                  });
                },
                child: FDText(_positionedEnd
                    ? 'Move to Top-Left'
                    : 'Move to Bottom-Right'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Card 5: Entrance Animations (FadeIn, SlideIn, ScaleIn)
        ShowcaseCard(
          title: 'Entrance Animations (FadeIn, SlideIn, ScaleIn)',
          description:
              'Micro-animations triggered on DOM insertion with zero style sheet pollution.',
          child: FDColumn(
            key: ValueKey(_entranceResetKey),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FDRow(
                spacing: 16,
                children: [
                  FadeIn(
                    duration: const Duration(milliseconds: 600),
                    child: FDContainer(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: const FlartColor('#dbeafe'),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const FDText('FadeIn Badge',
                          style: TextStyle(
                              color: FlartColor('#1e40af'),
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  SlideIn(
                    duration: const Duration(milliseconds: 600),
                    offsetX: 20,
                    child: FDContainer(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: const FlartColor('#e0e7ff'),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const FDText('SlideIn Badge',
                          style: TextStyle(
                              color: FlartColor('#3730a3'),
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  ScaleIn(
                    duration: const Duration(milliseconds: 600),
                    startScale: 0.6,
                    child: FDContainer(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: const FlartColor('#fce7f3'),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const FDText('ScaleIn Badge',
                          style: TextStyle(
                              color: FlartColor('#9d174d'),
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              FDOutlinedButton(
                onPressed: () {
                  setState(() => _entranceResetKey++);
                },
                child: const FDText('Replay Entrances 🔁'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Card 6: Hero & Shader Visual Effects
        ShowcaseCard(
          title: 'Hero Markers & WebGL Shader Effects',
          description:
              'Hero element tagging for transition targets and hardware-rendered fragment shaders.',
          child: FDRow(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Hero(
                tag: 'user-profile-avatar',
                child: FDContainer(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: FlartColor('#f59e0b'),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: FDCenter(
                    child: FDIcon(
                      icon: FDIcons.person,
                      color: FlartColors.white,
                      size: 40,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 24),
              FDColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FDText('Hero Tag: "user-profile-avatar"',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  const FDText(
                      'Ready for hero flight transitions across pages and modals.',
                      style: TextStyle(fontSize: 13, color: FlartColors.grey)),
                  const SizedBox(height: 8),
                  WaveShader(
                    width: 180,
                    height: 40,
                    color: '#3b82f6',
                    speed: 2.0,
                    amplitude: 0.2,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
