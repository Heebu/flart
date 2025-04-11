/// Support for doing something awesome.
///
/// More dartdocs go here.
library;
export 'src/flart_base.dart';
export 'run_app.dart';
export 'src/widgets/widget.dart';
export 'src/widgets/text.dart';
export 'src/widgets/container.dart';
export 'src/widgets/column.dart';
export 'src/widgets/state.dart';
export 'src/widgets/stateful_widget.dart';
export 'src/widgets/stateless_widget.dart';
export 'src/widgets/button.dart';

//styles
export 'src/styles/alignment.dart';
export 'src/styles/axis_alignment.dart';
export 'src/styles/box_decoration.dart';
export 'src/styles/edge_insets.dart';
export 'src/styles/text_style.dart';
export 'src/styles/colors.dart';

// TODO: Export any libraries intended for clients of this package.


import 'dart:html';
import 'src/widgets/widget.dart';
import 'src/widgets/stateful_widget.dart';

void runApp(Widget app) {
  String htmlOutput;

  if (app is StatefulWidget) {
    final state = app.createState()
      ..widget = app;
    state.initState();
    htmlOutput = state.build().render();
  } else {
    htmlOutput = app.render();
  }

  querySelector('#app')?.setInnerHtml(
    htmlOutput,
    treeSanitizer: NodeTreeSanitizer.trusted,
  );
}

