import '../../flart.dart';

typedef StatelessBuilder = String Function();

class Stateless extends StatelessWidget {
  final StatelessBuilder builder;

  const Stateless(this.builder);

  @override
  String build() => builder();
}
