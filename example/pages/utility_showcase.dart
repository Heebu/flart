import 'dart:async';
import 'package:flartdart/flartdart.dart';
import '../widgets/showcase_card.dart';

/// User session for InheritedWidget demo
class UserSession {
  final String username;
  final String role;
  final String email;

  const UserSession({
    required this.username,
    required this.role,
    required this.email,
  });
}

/// Cart model for ChangeNotifierProvider & Consumer demo
class CartModel extends ChangeNotifier {
  final List<String> _items = ['Flart Web Guide', 'Reactive Dart Book'];
  double _total = 49.98;

  List<String> get items => List.unmodifiable(_items);
  double get total => _total;
  int get itemCount => _items.length;

  void addItem(String name, double price) {
    _items.add(name);
    _total += price;
    notifyListeners();
  }

  void clear() {
    _items.clear();
    _total = 0.0;
    notifyListeners();
  }
}

/// View model for MVVM demo
class CounterViewModel extends ViewModel {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    if (_count > 0) {
      _count--;
      notifyListeners();
    }
  }

  void reset() {
    _count = 0;
    notifyListeners();
  }
}

class UtilityShowcasePage extends StatefulWidget {
  const UtilityShowcasePage({super.key});

  @override
  State<UtilityShowcasePage> createState() => _UtilityShowcasePageState();
}

class _UtilityShowcasePageState extends State<UtilityShowcasePage> {
  final ValueNotifier<int> _counterNotifier = ValueNotifier<int>(0);

  Future<String>? _apiFuture;

  StreamController<int>? _streamController;
  Timer? _streamTimer;
  int _streamTick = 0;
  bool _isStreaming = false;

  final CartModel _cartModel = CartModel();

  @override
  void initState() {
    super.initState();
    _startStream();
  }

  @override
  void dispose() {
    _streamTimer?.cancel();
    _streamController?.close();
    _counterNotifier.dispose();
    _cartModel.dispose();
    super.dispose();
  }

  void _triggerFetch() {
    setState(() {
      _apiFuture = Future<String>.delayed(
        const Duration(milliseconds: 1200),
        () =>
            'Successfully fetched user record #4092 at ${DateTime.now().toIso8601String().substring(11, 19)} UTC',
      );
    });
  }

  void _startStream() {
    _streamController?.close();
    _streamTimer?.cancel();
    _streamController = StreamController<int>.broadcast();
    _isStreaming = true;
    _streamTick = 0;
    _streamTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_streamController!.isClosed) {
        _streamTick++;
        _streamController!.add(_streamTick);
      }
    });
  }

  void _toggleStream() {
    setState(() {
      if (_isStreaming) {
        _streamTimer?.cancel();
        _isStreaming = false;
      } else {
        _isStreaming = true;
        _streamTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (!_streamController!.isClosed) {
            _streamTick++;
            _streamController!.add(_streamTick);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Category 9: Utility & Reactive Builders',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: FlartColor('#0f172a'),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'High-performance reactive builders and dependency injection without unnecessary DOM rebuilds.',
                style: TextStyle(
                  fontSize: 16,
                  color: FlartColor('#475569'),
                ),
              ),
            ],
          ),
        ),
        ShowcaseCard(
          title: 'ValueListenableBuilder<T>',
          description:
              'Rebuilds only its subtree when the ValueNotifier value changes, bypassing ancestor setState().',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => _counterNotifier.value++,
                    child: Text('Increment (+1)'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (_counterNotifier.value > 0) {
                        _counterNotifier.value--;
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: FlartColor('#64748b'),
                    ),
                    child: Text('Decrement (-1)'),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: () => _counterNotifier.value = 0,
                    child: Text('Reset'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ValueListenableBuilder<int>(
                valueListenable: _counterNotifier,
                builder: (context, count, child) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: FlartColor('#f0fdf4'),
                      border:
                          Border.all(color: FlartColor('#86efac'), width: 1.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(FDIcons.checkCircle, color: FlartColor('#16a34a')),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Reactive Subtree Value: $count',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: FlartColor('#15803d'),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Targeted VDOM patch executed cleanly.',
                              style: TextStyle(
                                  fontSize: 13, color: FlartColor('#166534')),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ShowcaseCard(
          title: 'FutureBuilder<T>',
          description:
              'Builds itself based on the latest interaction with a Future (none, waiting, done).',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: _triggerFetch,
                child: Row(
                  children: [
                    Icon(FDIcons.refresh,
                        color: FlartColor('#ffffff'), size: 16),
                    const SizedBox(width: 8),
                    Text('Trigger Async Request'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              FutureBuilder<String>(
                future: _apiFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.none) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: FlartColor('#f8fafc'),
                        border: Border.all(color: FlartColor('#e2e8f0')),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Ready: Click the button above to start an asynchronous task.',
                        style: TextStyle(color: FlartColor('#64748b')),
                      ),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: FlartColor('#eff6ff'),
                        border: Border.all(color: FlartColor('#bfdbfe')),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(FDIcons.hourglass, color: FlartColor('#2563eb')),
                          const SizedBox(width: 12),
                          Text(
                            'Loading asynchronous data...',
                            style: TextStyle(
                              color: FlartColor('#1e40af'),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: FlartColor('#fef2f2'),
                        border: Border.all(color: FlartColor('#fecaca')),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: TextStyle(color: FlartColor('#dc2626')),
                      ),
                    );
                  } else {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: FlartColor('#f0fdf4'),
                        border: Border.all(color: FlartColor('#bbf7d0')),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(FDIcons.checkCircle,
                              color: FlartColor('#16a34a')),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              snapshot.data ?? 'No data',
                              style: TextStyle(
                                color: FlartColor('#166534'),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ShowcaseCard(
          title: 'StreamBuilder<T>',
          description:
              'Builds itself based on the latest interaction with a Stream, updating on every emitted event.',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _toggleStream,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isStreaming
                          ? FlartColor('#e11d48')
                          : FlartColor('#0284c7'),
                    ),
                    child:
                        Text(_isStreaming ? 'Pause Stream' : 'Resume Stream'),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton(
                    onPressed: () {
                      _startStream();
                      setState(() {});
                    },
                    child: Text('Restart Stream'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              StreamBuilder<int>(
                stream: _streamController?.stream,
                initialData: 0,
                builder: (context, snapshot) {
                  final tick = snapshot.data ?? 0;
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: FlartColor('#faf5ff'),
                      border:
                          Border.all(color: FlartColor('#e9d5ff'), width: 1.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(FDIcons.refresh, color: FlartColor('#9333ea')),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Active Stream Tick: $tick seconds',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: FlartColor('#6b21a8'),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Connection state: ${snapshot.connectionState.name}',
                              style: TextStyle(
                                  fontSize: 13, color: FlartColor('#7e22ce')),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ShowcaseCard(
          title: 'ChangeNotifierProvider & Consumer',
          description:
              'Scoped dependency injection and selective subtree rebuilds for ChangeNotifier models.',
          child: ChangeNotifierProvider<CartModel>(
            create: (_) => _cartModel,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () =>
                          _cartModel.addItem('WebAssembly Module', 29.99),
                      child: Text('Add Item (\$29.99)'),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () => _cartModel.clear(),
                      child: Text('Clear Cart'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Consumer<CartModel>(
                  builder: (context, cart, child) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: FlartColor('#fffbeb'),
                        border: Border.all(
                            color: FlartColor('#fde68a'), width: 1.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Items in Cart: ${cart.itemCount}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: FlartColor('#92400e'),
                                ),
                              ),
                              Text(
                                'Total: \$${cart.total.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: FlartColor('#b45309'),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Items: ${cart.items.join(', ')}',
                            style: TextStyle(
                                fontSize: 13, color: FlartColor('#78350f')),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        ShowcaseCard(
          title: 'InheritedWidget & Provider.of<T>',
          description:
              'Allows descendant widgets to efficiently read data higher in the widget hierarchy.',
          child: Provider<UserSession>(
            value: const UserSession(
              username: 'alex_developer',
              role: 'Lead Architect',
              email: 'alex@flart.dev',
            ),
            child: Builder(
              builder: (context) {
                final session = Provider.of<UserSession>(context);
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: FlartColor('#f8fafc'),
                    border: Border.all(color: FlartColor('#cbd5e1')),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: FlartColor('#3b82f6'),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Center(
                          child:
                              Icon(FDIcons.user, color: FlartColor('#ffffff')),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            session.username,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: FlartColor('#0f172a'),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${session.role} • ${session.email}',
                            style: TextStyle(
                                fontSize: 13, color: FlartColor('#64748b')),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 24),
        ShowcaseCard(
          title: 'ViewModelBuilder & ListenableBuilder',
          description:
              'Clean MVVM pattern binding UI widgets to structured business logic view models.',
          child: ViewModelBuilder<CounterViewModel>(
            viewModelBuilder: () => CounterViewModel(),
            builder: (context, vm, child) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: FlartColor('#f1f5f9'),
                  border: Border.all(color: FlartColor('#cbd5e1')),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ViewModel Count: ${vm.count}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: FlartColor('#1e293b'),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Encapsulated inside CounterViewModel',
                          style: TextStyle(
                              fontSize: 12, color: FlartColor('#64748b')),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: vm.increment,
                          child: Text('+'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: vm.decrement,
                          child: Text('-'),
                        ),
                        const SizedBox(width: 8),
                        OutlinedButton(
                          onPressed: vm.reset,
                          child: Text('Reset'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
