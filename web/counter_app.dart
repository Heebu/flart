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

  increment() {
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
          backgroundColor: FlartColors.blue,
        ),
        body: Container(
          decoration: BoxDecoration(
            color: FlartColor('#667eea'),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title
                Text(
                  'Counter Demo',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
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
                                fontWeight: FontWeight.bold,
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
                  mainAxisAlignment: MainAxisAlignment.center,
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
                          fontWeight: FontWeight.bold,
                          color: '#333333',
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                  fontWeight: FontWeight.bold,
                                  color: '#667eea',
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 1,
                            height: 40,
                            decoration:
                                BoxDecoration(color: FlartColors.blue.shade50),
                          ),
                          Column(
                            children: [
                              Text(
                                'Status',
                                style:
                                    TextStyle(fontSize: 12, color: '#666666'),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: counter > 10
                                      ? FlartColors.red
                                      : counter > 5
                                          ? FlartColor('#ffc107')
                                          : FlartColors.green,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  counter > 10
                                      ? 'High'
                                      : counter > 5
                                          ? 'Medium'
                                          : 'Low',
                                  style: TextStyle(
                                    color: '#ffffff',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
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
                        color: FlartColors.white,
                        backgroundColor: FlartColors.black,
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
          onPressed: () => increment(),
          child: Icon(icon: 'add', size: 32),
          backgroundColor: FlartColors.green,
        ),
      ),
      title: 'Counter App',
    );
  }
}
