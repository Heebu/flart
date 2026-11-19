import '../../../flartdart.dart';

typedef Spacer = FDSpacer;

class FDSpacer extends FDExpanded {
  const FDSpacer({super.flex = 1, super.key})
      : super(
          child: const FDSizedBox(),
        );
}
