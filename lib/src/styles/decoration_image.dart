class FlartDecorationImage {
  final String url;
  final String fit; // e.g. 'cover', 'contain'

  const FlartDecorationImage({required this.url, this.fit = 'cover'});

  String toCss() =>
      'background-image: url("$url"); background-size: $fit; background-repeat: no-repeat; background-position: center;';
}
