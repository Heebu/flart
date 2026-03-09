String toInlineStyle(
  Map<String, String>? declarations, {
  String? rawCss,
}) {
  final buffer = StringBuffer();

  if (declarations != null) {
    for (final entry in declarations.entries) {
      final key = entry.key.trim();
      final value = entry.value.trim();
      if (key.isEmpty || value.isEmpty) {
        continue;
      }
      buffer.write('$key: $value;');
    }
  }

  final raw = rawCss?.trim();
  if (raw != null && raw.isNotEmpty) {
    if (buffer.isNotEmpty && !raw.startsWith(';')) {
      buffer.write(' ');
    }
    buffer.write(raw);
  }

  return buffer.toString();
}
