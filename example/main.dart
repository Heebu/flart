import 'advanced_demo.dart' as advanced;

void main() {
  try {
    advanced.main();
  } catch (e, stack) {
    print('Critical Startup Error: $e\n$stack');
  }
}
