import 'package:flartdart/flartdart.dart';

class Batch5Lab extends StatefulWidget {
  const Batch5Lab({Key? key}) : super(key: key);

  @override
  State<Batch5Lab> createState() => _Batch5LabState();
}

class _Batch5LabState extends State<Batch5Lab> {
  double _opacity = 1.0;
  double _turns = 0.0;
  double _scale = 1.0;
  bool _showFirst = true;

  late AnimationController _boxController;

  @override
  void initState() {
    super.initState();
    _boxController = AnimationController(duration: Duration(seconds: 1));
  }

  @override
  void dispose() {
    _boxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FDScaffold(
      appBar: FDAppBar(title: FDText('Batch 5: Animations')),
      body: FDListView(
        padding: EdgeInsets.all(24),
        children: [
          _sectionTitle('1. Implicit Animations (CSS)'),
          FDRow(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FDColumn(
                children: [
                  AnimatedOpacity(
                    opacity: _opacity,
                    duration: Duration(milliseconds: 500),
                    child: FDContainer(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(color: theme.primaryColor)),
                  ),
                  FDSizedBox(height: 8),
                  FDElevatedButton(
                      onPressed: () => setState(
                          () => _opacity = _opacity == 1.0 ? 0.2 : 1.0),
                      child: FDText('Fade')),
                ],
              ),
              FDColumn(
                children: [
                  AnimatedRotation(
                    turns: _turns,
                    duration: Duration(milliseconds: 500),
                    child: FDIcon(
                        icon: FDIcons.refresh,
                        size: 60,
                        color: theme.primaryColor),
                  ),
                  FDSizedBox(height: 8),
                  FDElevatedButton(
                      onPressed: () => setState(() => _turns += 0.25),
                      child: FDText('Rotate')),
                ],
              ),
            ],
          ),
          FDSizedBox(height: 32),
          _sectionTitle('2. Scale & Transition'),
          FDRow(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: _scale,
                duration: Duration(milliseconds: 300),
                child: FDCard(
                  elevation: 4,
                  child: FDPadding(
                      padding: EdgeInsets.all(20), child: FDText('Scale Me')),
                ),
              ),
            ],
          ),
          FDSizedBox(height: 16),
          FDRow(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FDTextButton(
                label: 'Zoom In',
                onPressed: () => setState(() => _scale = 1.5),
              ),
              FDSizedBox(width: 16),
              FDTextButton(
                label: 'Reset',
                onPressed: () => setState(() => _scale = 1.0),
              ),
            ],
          ),
          FDSizedBox(height: 32),
          _sectionTitle('3. Explicit Animation (Controller)'),
          FDCenter(
            child: AnimatedContainer(
              controller: _boxController,
              beginWidth: 100,
              endWidth: 200,
              beginHeight: 100,
              endHeight: 150,
              beginColor: theme.primaryColor,
              endColor: theme.successColor,
              child: FDCenter(
                  child: FDText('Controlled',
                      style: TextStyle(color: FlartColors.white))),
            ),
          ),
          FDSizedBox(height: 16),
          FDRow(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FDElevatedButton(
                  onPressed: () => _boxController.forward(),
                  child: FDText('Forward')),
              FDSizedBox(width: 16),
              FDElevatedButton(
                  onPressed: () => _boxController.reverse(),
                  child: FDText('Reverse')),
            ],
          ),
          FDSizedBox(height: 32),
          _sectionTitle('4. Crossfade'),
          FDCenter(
            child: AnimatedCrossFade(
              showFirst: _showFirst,
              duration: Duration(milliseconds: 500),
              firstChild: FDContainer(
                  width: 150,
                  height: 100,
                  decoration: BoxDecoration(color: theme.primaryColor),
                  child: FDCenter(child: FDText('First'))),
              secondChild: FDContainer(
                  width: 150,
                  height: 100,
                  decoration: BoxDecoration(color: theme.errorColor),
                  child: FDCenter(child: FDText('Second'))),
            ),
          ),
          FDSizedBox(height: 16),
          FDElevatedButton(
              onPressed: () => setState(() => _showFirst = !_showFirst),
              child: FDText('Switch')),
          FDSizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return FDPadding(
      padding: EdgeInsets.only(bottom: 16),
      child: FDText(title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}
