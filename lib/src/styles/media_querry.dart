import 'dart:html';

class MediaQuery {
  final num width;
  final num height;

  MediaQuery._(this.width, this.height);

  static MediaQuery of() {
    final width = window.innerWidth ?? 0;
    final height = window.innerHeight ?? 0;
    return MediaQuery._(width, height);
  }
}
