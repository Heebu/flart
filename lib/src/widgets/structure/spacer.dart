import '../../../flart.dart';

class Spacer extends Expanded {
  Spacer({int flex = 1})
      : super(
    flex: flex,
    child: SizedBox(), // Occupies the space
  );
}
