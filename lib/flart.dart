export 'src/framework.dart';
export 'src/widgets/basic.dart';

import 'dart:html';

import 'src/framework.dart';

void runApp(Widget app) {
  final appElement = app.createElement();
  document.body!.append(appElement);
}
