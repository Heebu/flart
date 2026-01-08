import 'package:flartdart/flartdart.dart';

void main() {
  runApp(const ShowcaseApp());
}

class ShowcaseApp extends Widget {
  const ShowcaseApp();

  @override
  String render(BuildContext context) {
    return FDMaterialApp(
      context: context,
      title: 'Flart Kitchen Sink',
      home: const HomePage(),
      favicon: '/assets/flart_logo.png',
      darkMode: true,
    ).render(context);
  }
}

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;
  bool _switchValue = false;
  bool _checkboxValue = false;
  String _typedText = '';

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FDScaffold(
      appBar: FDAppBar(
        title: FDText('Flart Kitchen Sink'),
      ),
      drawer: FDDrawer(
        child: FDListView(
          padding: EdgeInsets.all(0),
          children: [
            FDContainer(
              height: 150,
              decoration: BoxDecoration(color: FlartColors.blue),
              alignment: Alignment.center,
              child: FDText(
                'Flart Menu',
                style: TextStyle(
                    color: '#FFFFFF',
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
            FDGestureDetector(
              onTap: () => print('Menu item 1 tapped'),
              child: FDContainer(
                padding: EdgeInsets.all(16),
                child: FDRow(children: [
                  FDIcon(icon: FDIcons.home),
                  FDSizedBox(width: 16),
                  FDText('Home')
                ]),
              ),
            ),
            FDGestureDetector(
              onTap: () => print('Menu item 2 tapped'),
              child: FDContainer(
                padding: EdgeInsets.all(16),
                child: FDRow(children: [
                  FDIcon(icon: FDIcons.settings),
                  FDSizedBox(width: 16),
                  FDText('Settings')
                ]),
              ),
            ),
          ],
        ),
      ),
      body: FDListView(
        padding: EdgeInsets.all(20),
        children: [
          _buildHeading('Animations & Navigation'),
          FDCard(
            padding: EdgeInsets.all(16),
            child: FDColumn(
              children: [
                FDText('Navigation Demo'),
                FDSizedBox(height: 10),
                FDElevatedButton(
                  child: FDText('Push New Page'),
                  onPressed: () {
                    PageNavigator.seed(const HomePage());
                    PageNavigator.push(const SecondPage());
                  },
                ),
                FDSizedBox(height: 20),
                FDText('Animation Demo'),
                FDSizedBox(height: 10),
                AnimatedContainerDemo(),
              ],
            ),
          ),
          FDSizedBox(height: 20),
          _buildHeading('Buttons & Interactions'),
          FDCard(
            padding: EdgeInsets.all(16),
            child: FDColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FDRow(
                  children: [
                    FDElevatedButton(
                      child: FDText('Elevated FDButton'),
                      onPressed: () => print('Elevated Pressed'),
                    ),
                    FDSizedBox(width: 10),
                    FDTooltip(
                      message: 'I am an FDIcon FDButton',
                      child: FDIconButton(
                        icon:
                            FDIcon(icon: FDIcons.favorite, color: FlartColors.red),
                        onPressed: () => print('FDIcon Pressed'),
                      ),
                    ),
                  ],
                ),
                FDSizedBox(height: 10),
                FDGestureDetector(
                  onTap: _incrementCounter,
                  child: FDContainer(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: FlartColors.blue.shade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: FDText('Custom Gesture FDButton (Tap Me)'),
                  ),
                ),
              ],
            ),
          ),
          FDSizedBox(height: 20),
          _buildHeading('State & Counters'),
          FDCard(
            padding: EdgeInsets.all(16),
            child: FDColumn(
              children: [
                FDText('Counter: $_counter',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: FlartColors.blue.hex)),
                FDSizedBox(height: 10),
                FDRow(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FDElevatedButton(
                      cssStyle: {'background-color': '#F44336'},
                      child: FDText('Decrement'),
                      onPressed: _decrementCounter,
                    ),
                    FDSizedBox(width: 10),
                    FDElevatedButton(
                      child: FDText('Increment'),
                      onPressed: _incrementCounter,
                    ),
                  ],
                ),
              ],
            ),
          ),
          FDSizedBox(height: 20),
          _buildHeading('Colors & FDIcons'),
          FDCard(
            padding: EdgeInsets.all(16),
            child: FDColumn(
              children: [
                FDRow(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FDIcon(icon: FDIcons.star, color: FlartColors.amber, size: 32),
                    FDSizedBox(width: 10),
                    FDIcon(
                        icon: FDIcons.favorite, color: FlartColors.red, size: 32),
                    FDSizedBox(width: 10),
                    FDIcon(
                        icon: FDIcons.thumb_up,
                        color: FlartColors.blue,
                        size: 32),
                    FDSizedBox(width: 10),
                    FDIcon(
                        icon: FDIcons.check_circle,
                        color: FlartColors.green,
                        size: 32),
                  ],
                ),
                FDSizedBox(height: 20),
                FDText(
                  'This FDText uses FlartColors.purple',
                  style: TextStyle(
                      color: FlartColors.purple, fontWeight: FontWeight.bold),
                ),
                FDSizedBox(height: 5),
                FDText(
                  'This FDText uses FlartColors.deepOrange',
                  style: TextStyle(
                      color: FlartColors.deepOrange,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          FDSizedBox(height: 20),
          _buildHeading('Inputs'),
          FDCard(
            padding: EdgeInsets.all(16),
            child: FDColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FDTextField(
                  label: 'Type something',
                  placeholder: 'Enter FDText...',
                  onChanged: (val) {
                    setState(() {
                      _typedText = val;
                    });
                  },
                ),
                FDSizedBox(height: 10),
                FDText('You typed: $_typedText'),
                FDSizedBox(height: 20),
                FDRow(
                  children: [
                    FDSwitch(
                      value: _switchValue,
                      activeColor: FlartColors.green,
                      onChanged: (val) {
                        setState(() {
                          _switchValue = !_switchValue;
                        });
                      },
                    ),
                    FDSizedBox(width: 8),
                    FDText('switch is ${_switchValue ? "ON" : "OFF"}'),
                  ],
                ),
                FDSizedBox(height: 10),
                FDRow(
                  children: [
                    FDCheckbox(
                      value: _checkboxValue,
                      onChanged: (val) {
                        setState(() {
                          _checkboxValue = !_checkboxValue;
                        });
                      },
                    ),
                    FDSizedBox(width: 8),
                    FDText(
                        'FDCheckbox is ${_checkboxValue ? "Checked" : "Unchecked"}'),
                  ],
                ),
              ],
            ),
          ),
          FDSizedBox(height: 20),
          _buildHeading('FDText Selection'),
          FDCard(
            padding: EdgeInsets.all(16),
            child: FDColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FDText(
                    'This FDText is NOT selectable (default default behavior). Try selecting me!'),
                FDSizedBox(height: 10),
                FDText(
                  'This FDText IS selectable (selectable: true). Select me!',
                  selectable: true,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                FDSizedBox(height: 10),
                FDSelectableText(
                  'This is using the FDSelectableText widget.',
                  style: TextStyle(color: FlartColors.blue.hex),
                ),
              ],
            ),
          ),
          FDSizedBox(height: 20),
          _buildHeading('Grid Layout'),
          FDGridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: List.generate(
                6,
                (index) => FDContainer(
                      height: 80,
                      decoration: BoxDecoration(
                          color: FlartColors
                                  .blue.shades[100 * ((index % 9) + 1)] ??
                              FlartColors.blue),
                      child:
                          FDText('Item $index', style: TextStyle(color: '#fff')),
                    )),
          ),
          FDSizedBox(height: 20),
          _buildHeading('Assets & Defaults'),
          FDCard(
            padding: EdgeInsets.all(16),
            child: FDColumn(
              children: [
                FDText('Default FDImage Fallback (Empty Source):'),
                FDSizedBox(height: 10),
                FDImage.network(
                  '', // Empty source should trigger default
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FDFloatingActionButton(
        onPressed: _incrementCounter,
        child: FDIcon(icon: FDIcons.add),
      ),
    );
  }

  Widget _buildHeading(String text) {
    return FDContainer(
      margin: EdgeInsets.only(bottom: 10),
      child: FDText(text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: '#444',
        ),
      ),
    );
  }
}

class SecondPage extends Widget {
  const SecondPage();

  @override
  String render(BuildContext context) {
    return FDScaffold(
      appBar: FDAppBar(title: FDText('Second Page')),
      body: FDCenter(
        child: FDColumn(
          children: [
            FDText('You have navigated to the second page!'),
            FDSizedBox(height: 20),
            FDElevatedButton(
              child: FDText('Go Back'),
              onPressed: () {
                PageNavigator.pop();
              },
            ),
          ],
        ),
      ),
    ).render(context);
  }
}

class AnimatedContainerDemo extends StatefulWidget {
  @override
  State<AnimatedContainerDemo> createState() => _AnimatedContainerDemoState();
}

class _AnimatedContainerDemoState extends State<AnimatedContainerDemo> {
  late AnimationController _controller;
  bool _toggled = false;

  @override
  void initState() {
    _controller = AnimationController(
        duration: Duration(seconds: 1), upperBound: 1.0, lowerBound: 0.0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FDColumn(
      children: [
        AnimatedContainer(
          controller: _controller,
          beginColor: FlartColors.blue,
          endColor: FlartColors.red,
          beginWidth: 100,
          endWidth: 200,
          beginHeight: 100,
          endHeight: 100,
          child: FDCenter(
              child:
                  FDText('Animate', style: TextStyle(color: FlartColors.white))),
        ),
        FDSizedBox(height: 20),
        FDElevatedButton(
          child: FDText(_toggled ? 'Reverse' : 'Forward'),
          onPressed: () {
            _toggled = !_toggled;
            if (_toggled) {
              _controller.forward();
            } else {
              _controller.reverse();
            }
            // Force rebuild regarding FDButton FDText
            setState(() {});
          },
        ),
      ],
    );
  }
}





