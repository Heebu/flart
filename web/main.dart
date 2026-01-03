import 'package:flart/flart.dart';
import 'package:flart/src/helper/callback_manager.dart';

void main() {
  runApp(const ShowcaseApp());
}

class ShowcaseApp extends Widget {
  const ShowcaseApp();

  @override
  String render(BuildContext context) {
    return MaterialApp(
      title: 'Flart Kitchen Sink',
      home: const HomePage(),
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

  // Tabs
  int _currentTabIndex = 0;

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Flart Kitchen Sink'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(color: FlartColors.blue),
              alignment: Alignment.center,
              child: Text(
                'Flart Menu',
                style: TextStyle(
                    color: '#FFFFFF',
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
            GestureDetector(
              onTap: () => print('Menu item 1 tapped'),
              child: Container(
                padding: EdgeInsets.all(16),
                child: Row(children: [
                  Icon(icon: Icons.home),
                  SizedBox(width: 16),
                  Text('Home')
                ]),
              ),
            ),
            GestureDetector(
              onTap: () => print('Menu item 2 tapped'),
              child: Container(
                padding: EdgeInsets.all(16),
                child: Row(children: [
                  Icon(icon: Icons.settings),
                  SizedBox(width: 16),
                  Text('Settings')
                ]),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          _buildHeading('Buttons & Interactions'),
          Card(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ElevatedButton(
                      child: Text('Elevated Button'),
                      onPressed: () => print('Elevated Pressed'),
                    ),
                    SizedBox(width: 10),
                    Tooltip(
                      message: 'I am an icon button',
                      child: IconButton(
                        icon:
                            Icon(icon: Icons.favorite, color: FlartColors.red),
                        onPressed: () => print('Icon Pressed'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: _incrementCounter,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: FlartColors.blue.shade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text('Custom Gesture Button (Tap Me)'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          _buildHeading('State & Counters'),
          Card(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text('Counter: $_counter',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: FlartColors.blue.hex)),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      cssStyle: {'background-color': '#F44336'},
                      child: Text('Decrement'),
                      onPressed: _decrementCounter,
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      child: Text('Increment'),
                      onPressed: _incrementCounter,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          _buildHeading('Inputs'),
          Card(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  label: 'Type something',
                  placeholder: 'Enter text...',
                  onChanged: (val) {
                    setState(() {
                      _typedText = val;
                    });
                  },
                ),
                SizedBox(height: 10),
                Text('You typed: $_typedText'),
                SizedBox(height: 20),
                Row(
                  children: [
                    Switch(
                      value: _switchValue,
                      activeColor: FlartColors.green,
                      onChanged: (val) {
                        setState(() {
                          _switchValue = !_switchValue;
                        });
                      },
                    ),
                    SizedBox(width: 8),
                    Text('Switch is ${_switchValue ? "ON" : "OFF"}'),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                      value: _checkboxValue,
                      onChanged: (val) {
                        setState(() {
                          _checkboxValue = !_checkboxValue;
                        });
                      },
                    ),
                    SizedBox(width: 8),
                    Text(
                        'Checkbox is ${_checkboxValue ? "Checked" : "Unchecked"}'),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          _buildHeading('Grid Layout'),
          GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: List.generate(
                6,
                (index) => Container(
                      height: 80,
                      decoration: BoxDecoration(
                          color: FlartColors
                                  .blue.shades[100 * ((index % 9) + 1)] ??
                              FlartColors.blue),
                      alignment: Alignment.center,
                      child:
                          Text('Item $index', style: TextStyle(color: '#fff')),
                    )),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: Icon(icon: Icons.add),
      ),
    );
  }

  Widget _buildHeading(String text) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: '#444',
        ),
      ),
    );
  }
}
