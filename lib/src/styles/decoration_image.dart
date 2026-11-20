class FlartDecorationImage {
  final String url;
  final String fit;

  const FlartDecorationImage({required this.url, this.fit = 'cover'});

  String toCss() =>
      'background-FDImage: url("$url"); background-size: $fit; background-repeat: no-repeat; background-position: center;';
}
