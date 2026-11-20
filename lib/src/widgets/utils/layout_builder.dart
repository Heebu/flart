import 'dart:js_interop';
import 'package:web/web.dart' as web;
import '../../../flartdart.dart';

/// Callback signature for [LayoutBuilder].
typedef LayoutWidgetBuilder = Widget Function(
    BuildContext context, BoxConstraints constraints);

typedef LayoutBuilder = FDLayoutBuilder;
typedef OrientationBuilder = FDOrientationBuilder;
typedef ResponsiveLayout = FDResponsiveLayout;

/// A widget that builds itself depending on the parent's or window's constraints.
/// Automatically listens to window resize events and rebuilds reactively.
class FDLayoutBuilder extends StatefulWidget {
  final LayoutWidgetBuilder builder;

  const FDLayoutBuilder({
    required this.builder,
    super.key,
  });

  @override
  State<FDLayoutBuilder> createState() => _FDLayoutBuilderState();
}

class _FDLayoutBuilderState extends State<FDLayoutBuilder> {
  JSFunction? _resizeListener;

  @override
  void initState() {
    super.initState();
    _resizeListener = ((web.Event _) {
      if (mounted) {
        setState(() {});
      }
    }).toJS;
    web.window.addEventListener('resize', _resizeListener!);
  }

  @override
  void dispose() {
    if (_resizeListener != null) {
      web.window.removeEventListener('resize', _resizeListener!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = web.window.innerWidth.toDouble();
    final height = web.window.innerHeight.toDouble();
    final constraints = BoxConstraints(
      minWidth: 0,
      maxWidth: width,
      minHeight: 0,
      maxHeight: height,
    );
    return widget.builder(context, constraints);
  }
}

/// Callback signature for [OrientationBuilder].
typedef OrientationWidgetBuilder = Widget Function(
    BuildContext context, Orientation orientation);

/// Builds a widget tree depending on the current orientation of the display.
class FDOrientationBuilder extends StatefulWidget {
  final OrientationWidgetBuilder builder;

  const FDOrientationBuilder({
    required this.builder,
    super.key,
  });

  @override
  State<FDOrientationBuilder> createState() => _FDOrientationBuilderState();
}

class _FDOrientationBuilderState extends State<FDOrientationBuilder> {
  JSFunction? _resizeListener;

  @override
  void initState() {
    super.initState();
    _resizeListener = ((web.Event _) {
      if (mounted) {
        setState(() {});
      }
    }).toJS;
    web.window.addEventListener('resize', _resizeListener!);
  }

  @override
  void dispose() {
    if (_resizeListener != null) {
      web.window.removeEventListener('resize', _resizeListener!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return widget.builder(context, mq.orientationEnum);
  }
}

/// Callback signature for [ResponsiveLayout] builder mode.
typedef ResponsiveWidgetBuilder = Widget Function(
  BuildContext context,
  ScreenSize screenSize,
  BoxConstraints constraints,
);

/// A reactive adaptive layout widget that builds distinct UI for small (<600px),
/// medium (600px-1023px), and large (>=1024px) screens.
class FDResponsiveLayout extends StatefulWidget {
  final Widget Function(BuildContext context)? small;
  final Widget Function(BuildContext context)? medium;
  final Widget Function(BuildContext context)? large;
  final ResponsiveWidgetBuilder? builder;

  const FDResponsiveLayout({
    this.small,
    this.medium,
    this.large,
    this.builder,
    super.key,
  });

  @override
  State<FDResponsiveLayout> createState() => _FDResponsiveLayoutState();
}

class _FDResponsiveLayoutState extends State<FDResponsiveLayout> {
  JSFunction? _resizeListener;

  @override
  void initState() {
    super.initState();
    _resizeListener = ((web.Event _) {
      if (mounted) {
        setState(() {});
      }
    }).toJS;
    web.window.addEventListener('resize', _resizeListener!);
  }

  @override
  void dispose() {
    if (_resizeListener != null) {
      web.window.removeEventListener('resize', _resizeListener!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final width = mq.width.toDouble();
    final height = mq.height.toDouble();
    final constraints = BoxConstraints(
      minWidth: 0,
      maxWidth: width,
      minHeight: 0,
      maxHeight: height,
    );

    if (widget.builder != null) {
      return widget.builder!(context, mq.screenSize, constraints);
    }

    switch (mq.screenSize) {
      case ScreenSize.small:
        if (widget.small != null) return widget.small!(context);
        if (widget.medium != null) return widget.medium!(context);
        if (widget.large != null) return widget.large!(context);
        break;
      case ScreenSize.medium:
        if (widget.medium != null) return widget.medium!(context);
        if (widget.large != null) return widget.large!(context);
        if (widget.small != null) return widget.small!(context);
        break;
      case ScreenSize.large:
        if (widget.large != null) return widget.large!(context);
        if (widget.medium != null) return widget.medium!(context);
        if (widget.small != null) return widget.small!(context);
        break;
    }

    return const FDSizedBox();
  }
}
