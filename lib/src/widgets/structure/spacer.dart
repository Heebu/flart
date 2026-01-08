import '../../../flartdart.dart';

class FDSpacer extends FDExpanded {
  FDSpacer({int flex = 1})
      : super(
    flex: flex,
    child: FDSizedBox(), // Occupies the space
  );
}



