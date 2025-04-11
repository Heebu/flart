import '../../flart.dart';

abstract class StatelessWidget extends Widget {
  const StatelessWidget();
  String build();

  @override
  String render() => build();
}
