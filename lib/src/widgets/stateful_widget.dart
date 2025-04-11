import '../../flart.dart';
import 'widget.dart';

abstract class StatefulWidget extends Widget {
  const StatefulWidget();

  State createState();
}
