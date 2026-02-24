import '../../../flartdart.dart';
import '../../../run_app.dart' as run_app;

class OverlayEntry {
  final Widget Function(BuildContext) builder;

  OverlayEntry({required this.builder});

  void remove() {
    Overlay._removeEntry(this);
  }
}

class Overlay {
  static final List<OverlayEntry> _entries = [];
  static List<OverlayEntry> get entries => List.unmodifiable(_entries);

  static void insert(OverlayEntry entry) {
    _entries.add(entry);
    _refresh();
  }

  static void _removeEntry(OverlayEntry entry) {
    if (_entries.remove(entry)) {
      _refresh();
    }
  }

  static void _refresh() {
    run_app.renderOverlays(_entries);
  }
}
