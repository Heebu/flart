import '../../../flart.dart';

/// A circular progress indicator
class CircularProgressIndicator extends Widget {
  final double size;
  final double strokeWidth;
  final FlartColor? color;
  final FlartColor? backgroundColor;

  CircularProgressIndicator({
    this.size = 40.0,
    this.strokeWidth = 4.0,
    this.color,
    this.backgroundColor,
  });

  @override
  String render(BuildContext context) {
    final id = 'progress_${DateTime.now().microsecondsSinceEpoch}';
    final mainColor = color?.toString() ?? '#6200ea';
    final bgColor = backgroundColor?.toString() ?? '#e0e0e0';

    return '''
      <div id="$id" style="
        width: ${size}px;
        height: ${size}px;
        border: ${strokeWidth}px solid $bgColor;
        border-top-color: $mainColor;
        border-radius: 50%;
        animation: spin 1s linear infinite;
      "></div>
      <style>
        @keyframes spin {
          to { transform: rotate(360deg); }
        }
      </style>
    ''';
  }
}

/// A linear progress indicator
class LinearProgressIndicator extends Widget {
  final double? value;
  final double height;
  final FlartColor? color;
  final FlartColor? backgroundColor;

  LinearProgressIndicator({
    this.value,
    this.height = 4.0,
    this.color,
    this.backgroundColor,
  });

  @override
  String render(BuildContext context) {
    final id = 'linear_progress_${DateTime.now().microsecondsSinceEpoch}';
    final mainColor = color?.toString() ?? '#6200ea';
    final bgColor = backgroundColor?.toString() ?? '#e0e0e0';
    final progress = value != null ? (value! * 100).clamp(0, 100) : null;

    if (progress != null) {
      // Determinate progress
      return '''
        <div style="
          width: 100%;
          height: ${height}px;
          background-color: $bgColor;
          border-radius: ${height / 2}px;
          overflow: hidden;
        ">
          <div style="
            width: $progress%;
            height: 100%;
            background-color: $mainColor;
            transition: width 0.3s ease;
          "></div>
        </div>
      ''';
    } else {
      // Indeterminate progress
      return '''
        <div style="
          width: 100%;
          height: ${height}px;
          background-color: $bgColor;
          border-radius: ${height / 2}px;
          overflow: hidden;
          position: relative;
        ">
          <div id="$id" style="
            position: absolute;
            height: 100%;
            width: 30%;
            background-color: $mainColor;
            animation: progress-slide 1.5s ease-in-out infinite;
          "></div>
        </div>
        <style>
          @keyframes progress-slide {
            0% { left: -30%; }
            100% { left: 100%; }
          }
        </style>
      ''';
    }
  }
}
