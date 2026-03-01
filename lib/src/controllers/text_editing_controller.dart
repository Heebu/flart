import '../foundation/change_notifier.dart';

class TextEditingController extends ChangeNotifier {
  String _text;

  TextEditingController({String text = ''}) : _text = text;

  String get text => _text;

  set text(String newText) {
    if (_text == newText) return;
    _text = newText;
    notifyListeners();
  }

  void clear() {
    text = '';
  }
}
