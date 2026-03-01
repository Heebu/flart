import '../../../flartdart.dart';

class FDSpacer extends FDExpanded {
  const FDSpacer({int flex = 1, Key? key})
      : super(
          flex: flex,
          child: const FDSizedBox(), // Occupies the space
          key: key,
        );
}
