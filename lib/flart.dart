/// Support for doing something awesome.
///
/// More dartdocs go here.
library;
export 'src/flart_base.dart';
export 'run_app.dart';
export 'src/widgets/widget.dart';
export 'src/widgets/state.dart';
export 'src/widgets/stateful_widget.dart';
export 'src/widgets/stateless_widget.dart';


//enums
export 'src/widgets/buttons/button.dart';


//button widgets
export 'src/enums/text_align.dart';
export 'src/enums/axis.dart';
export 'src/enums/axis_alignment.dart';
export 'src/enums/indexed_widget_bulder.dart';
export 'src/enums/grid_view_type.dart';
export 'src/enums/text_tag.dart';

//text widgets
export 'src/widgets/texts/textfield.dart';
export 'src/widgets/texts/text.dart';
export 'src/widgets/texts/rich_text.dart';
export 'src/widgets/texts/text_span.dart';
export 'src/widgets/texts/selectable_text.dart';
export 'src/widgets/texts/text_button.dart';
export 'src/widgets/texts/link_text.dart';
export 'src/widgets/texts/editable_text.dart';
export 'src/widgets/texts/richtext.dart';

//animated widgets
export 'src/widgets/animated_widgets/animated_container.dart';

//arrangement widgets
export 'src/widgets/arrangement_widgets/position.dart';
export 'src/widgets/arrangement_widgets/column.dart';
export 'src/widgets/arrangement_widgets/listview.dart';
export 'src/widgets/arrangement_widgets/row.dart';
export 'src/widgets/arrangement_widgets/center.dart';
export 'src/widgets/arrangement_widgets/stack.dart';

//structure widget
export 'src/widgets/structure/container.dart';
export 'src/widgets/structure/divider.dart';
export 'src/widgets/structure/buttom_nav_bar.dart';
export 'src/widgets/structure/floating_action_widget.dart';
export 'src/widgets/structure/vertical_divider.dart';
export 'src/widgets/structure/appbar.dart';
export 'src/widgets/structure/scaffold.dart';
export 'src/widgets/structure/drawer.dart';
export 'src/widgets/structure/icons.dart';
export 'src/widgets/structure/sized_box.dart';
export 'src/widgets/structure/spacer.dart';
export 'src/widgets/structure/buttomnarbaritem.dart';
export 'src/widgets/structure/expanded.dart';
export 'src/widgets/structure/material_app.dart';
export 'src/widgets/structure/image.dart';

//styles
export 'src/styles/alignment.dart';
export 'src/styles/box_decoration.dart';
export 'src/styles/edge_insets.dart';
export 'src/styles/text_style.dart';
export 'src/styles/colors.dart';
export 'src/styles/border.dart';
export 'src/styles/border_radius.dart';
export 'src/styles/build_context.dart';
export 'src/styles/box_shadow.dart';
export 'src/styles/box_gradient.dart';
export 'src/styles/decoration_image.dart';
export 'src/styles/flart_gradient.dart';
export 'src/styles/media_querry.dart';
export 'src/styles/navigation.dart';
export 'src/styles/align.dart';


//controllers
export 'src/controllers/animated_controller.dart';
export 'src/controllers/text_editing_controller.dart';


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
