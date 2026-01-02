import 'package:flart/flart.dart';

void main() {
  runApp(CounterApp());
}

class CounterApp extends StatefulWidget {
  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int counter = 0;
  bool showGlow = false;

  void increment() {
    setState(() {
      counter++;
      showGlow = true;
    });

    // Hide glow after animation
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() => showGlow = false);
    });
  }

  void decrement() {
    setState(() {
      if (counter > 0) {
        counter--;
      }
    });
  }

  void reset() {
    setState(() => counter = 0);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flart Counter App'),
          backgroundColor: FlartColor.hex('#667eea'),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: ['#667eea', '#764ba2'],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: AxisAlignment.center,
              children: [
                // Title
                Text(
                  'Counter Demo',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: 'bold',
                    color: '#ffffff',
                  ),
                ),

                SizedBox(height: 40),

                // Counter Display Card
                Stack(
                  children: [
                    // Glow effect when incrementing
                    if (showGlow)
                      GlowShader(
                        color: '#00ff00',
                        width: 250,
                        height: 200,
                        intensity: 2.0,
                        pulse: false,
                      ),

                    // Counter Card
                    Card(
                      elevation: 8.0,
                      padding: EdgeInsets.all(40),
                      borderRadius: BorderRadius.circular(20),
                      child: Column(
                        children: [
                          Text(
                            'Count',
                            style: TextStyle(
                              fontSize: 20,
                              color: '#666666',
                            ),
                          ),
                          SizedBox(height: 10),

                          // Animated Counter
                          AnimatedScale(
                            scale: showGlow ? 1.2 : 1.0,
                            duration: Duration(milliseconds: 300),
                            child: Text(
                              '$counter',
                              style: TextStyle(
                                fontSize: 72,
                                fontWeight: 'bold',
                                color: '#667eea',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40),

                // Button Row
                Row(
                  mainAxisAlignment: AxisAlignment.center,
                  children: [
                    // Decrement Button
                    ElevatedButton(
                      onPressed: decrement,
                      child: Row(
                        children: [
                          Icon(icon: 'remove', size: 24),
                          SizedBox(width: 8),
                          Text('Decrease'),
                        ],
                      ),
                      cssStyle: {
                        'background-color': '#dc3545',
                        'color': '#ffffff',
                        'padding': '12px 24px',
                        'border-radius': '8px',
                        'font-size': '16px',
                        'border': 'none',
                        'cursor': 'pointer',
                      },
                    ),

                    SizedBox(width: 20),

                    // Increment Button
                    ElevatedButton(
                      onPressed: increment,
                      child: Row(
                        children: [
                          Icon(icon: 'add', size: 24),
                          SizedBox(width: 8),
                          Text('Increase'),
                        ],
                      ),
                      cssStyle: {
                        'background-color': '#28a745',
                        'color': '#ffffff',
                        'padding': '12px 24px',
                        'border-radius': '8px',
                        'font-size': '16px',
                        'border': 'none',
                        'cursor': 'pointer',
                      },
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // Reset Button
                TextButton(
                  label: 'Reset Counter',
                  onPressed: reset,
                  style: TextStyle(
                    color: '#ffffff',
                    fontSize: 16,
                    textDecoration: 'underline',
                  ),
                ),

                SizedBox(height: 40),

                // Stats Card
                Card(
                  padding: EdgeInsets.all(20),
                  borderRadius: BorderRadius.circular(12),
                  child: Column(
                    children: [
                      Text(
                        'Statistics',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: 'bold',
                          color: '#333333',
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: AxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Current',
                                style:
                                    TextStyle(fontSize: 12, color: '#666666'),
                              ),
                              Text(
                                '$counter',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: 'bold',
                                  color: '#667eea',
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 1,
                            height: 40,
                            decoration:
                                BoxDecoration(color: FlartColor.hex('#cccccc')),
                          ),
                          Column(
                            children: [
                              Text(
                                'Status',
                                style:
                                    TextStyle(fontSize: 12, color: '#666666'),
                              ),
                              Badge(
                                label: counter > 10
                                    ? 'High'
                                    : counter > 5
                                        ? 'Medium'
                                        : 'Low',
                                backgroundColor: counter > 10
                                    ? FlartColor.hex('#dc3545')
                                    : counter > 5
                                        ? FlartColor.hex('#ffc107')
                                        : FlartColor.hex('#28a745'),
                                textColor: FlartColor.hex('#ffffff'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                // Progress Indicator
                Container(
                  width: 300,
                  child: Column(
                    children: [
                      Text(
                        'Progress to 20',
                        style: TextStyle(color: '#ffffff', fontSize: 14),
                      ),
                      SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: counter / 20,
                        height: 8,
                        color: FlartColor.hex('#00ff00'),
                        backgroundColor:
                            FlartColor.hex('rgba(255,255,255,0.3)'),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${(counter / 20 * 100).toStringAsFixed(0)}%',
                        style: TextStyle(color: '#ffffff', fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: increment,
          child: Icon(icon: 'add', size: 32),
          backgroundColor: FlartColor.hex('#667eea'),
        ),
      ),
    );
  }
}
