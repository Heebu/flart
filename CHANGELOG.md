# Changelog 📝

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.6.0] - 2026-05-05

### 🏗️ Architecture & Internals

- **Unified Event System**: Rewrote `FDGestureDetector` to use `FlartCallbackManager` exclusively, eliminating the competing `Future.delayed` + `getElementById` event architecture. The entire framework now uses a single, consistent event bridge pattern.
- **Smart DOM Reconciler Activated**: `SmartReconciler` is now wired into `StatefulWidget._performScopedUpdate()`. Instead of raw `innerHTML` replacement, scoped updates now patch the DOM tree recursively — preserving focus, scroll positions, and input state automatically.
- **Stable State Keys**: `StatefulWidget` now uses a monotonic positional counter instead of `hashCode` for state keys when no explicit `Key` is provided. This prevents silent state loss across re-renders.
- **Consolidated on `package:web`**: Migrated `run_app.dart`, `stateful_widget.dart`, `gesture_detector.dart`, `callback_manager.dart`, `animation_controller.dart`, and `reconciler.dart` from the deprecated `dart:html` / `dart:js` APIs to `package:web` + `dart:js_interop`.
- **Fixed Style Tag Accumulation**: `FDAnimate` now injects all `@keyframes` into a single shared `<style>` element instead of creating a new `<style>` tag per animated widget. Also uses a monotonic counter for IDs to prevent microsecond collisions.

### 🚀 CLI Improvements

- **Project Templates**: `flartdart create` now supports `--template` flag with three options: `default`, `counter`, and `routing`.
- **Auto Dependency Resolution**: `flartdart create` automatically runs `dart pub get` after scaffolding. `flartdart run` auto-runs `pub get` on first run if `.dart_tool` doesn't exist.
- **Project Name Validation**: CLI now validates that project names are valid Dart package names before creating.
- **Richer Doctor Output**: `flartdart doctor` now checks webdev availability, dependency resolution state, and Dart SDK version compatibility.
- **Beautiful Help Output**: Redesigned `--help` with a quick-start guide, formatted command reference, and useful links.

### 🛠️ Improvements & Fixes

- `FDGestureDetector` now has a proper `const` constructor.
- All widget ID generation uses monotonic counters instead of `DateTime.now().microsecondsSinceEpoch` to prevent collisions.
- `SmartReconciler` now uses `nodeName` checks instead of `is` type checks for `package:web` extension type compatibility.

---

## [1.5.1] - 2026-03-09

### 🛠️ Improvements & Fixes
- **CLI Development Server**: Fixed the `flartdart run` command to successfully bind `webdev serve` inside Windows environments by running in shell mode. Starter projects are now generated with the `webdev` dependency automatically.
- **Type Safety**: Upgraded the entire UI framework to Dart 3 strict typing (`strict-casts`, `strict-inference`, `strict-raw-types`), refactoring core classes like `FDFormFieldState` and `FDStreamBuilder` for enhanced type stability.
- **Quality Gates**: Adopted rigorous formatting (`dart format`) and static analysis rules to enforce an enterprise-level standard moving forward.

## [1.5.0] - 2026-03-06

### 🚀 Major CLI & Tooling Upgrades
- **Integrated CLI**: A powerful `flartdart` tool for project management.
  - `flartdart run`: Serve application with Hot Reload.
  - `flartdart build`: Optimized production bundling.
  - `flartdart test`: Integrated test runner.
  - `flartdart clean`: Efficiently wipe build artifacts and caches.
  - `flartdart doctor`: Detailed environment diagnostics.
  - `flartdart fix`: Automatic application of code fixes.
- **Responsive Framework**: Introduced `ScreenUtil` and numeric extensions (`.w`, `.h`, `.sp`, `.sw`, `.sh`).
  - Native support for responsive scaling across desktop (1440x900 default) and mobile.
  - High-performance scaling for fonts and layouts.

### 🌟 Framework Core Upgrades
- **Reactive State Management**: Introduced a robust `StatefulWidget` and `State` architecture that perfectly scopes DOM repaints to individual component wrappers. Say goodbye to full-page re-renders!
- **Pure CSS Animations**: Overhauled `FDAnimate` to dynamically inject highly performant `@keyframes` animations instead of relying on inline JS `requestAnimationFrame`. Wait-for-mount delays and multi-step animations now work flawlessly.
- **Form Controls & Inputs**: Added the comprehensive `FDEditableText` and refactored `FDTextField`. These now natively bind to `TextEditingController` which extends the newly introduced pure-Dart `ChangeNotifier`. Inputs maintain their focus and cursor position smoothly across renders.

### 🌟 New UI Components
- **Advanced Layout**: Added `FDSliverAppBar` and `FDDataTable` for creating complex, scrollable structures and dynamic admin dashboards natively in Dart Web.
- **Glassmorphism & Theming**: Expanded the `flartdart` theming engine and styling API to rigorously support deep web layouts. `FDGestureDetector` now cleanly formats standard Web button UX out of the box.
- **Utility Widgets**: Introduced `FDRawHTML` for specialized DOM injection and `FDSpacer`/`FDExpanded` which now correctly utilize layout constraints.
- **Real-Time Context**: Added a fully usable `FDWebSocket` implementation natively binding WS protocols into widget trees.

### 🛠️ Improvements & Fixes
- `FDViewModelBuilder` no longer forces page-level rebuilds.
- `FDGestureDetector` properly wraps bounds and avoids destroying CSS border/border-radius geometry.
- The default flart starter template has been optimized into an ultra-clean, standalone `main.dart` demonstrating the core reactivity features.
- Fixed CLI boilerplate generator to use POSIX-compliant paths and include `test` dependencies by default.

---

## [1.2.0] - 2026-01-27
### 🌟 New Features
- **Flartdart CLI**: Introduced a new command-line tool `flartdart` for scaffolding new projects.
  - Usage: `flartdart create <project_name>`
  - Supports local path linking for development with `--local-path`.
- **Documentation Overhaul**: Completely rewritten `README.md`, `WIDGET_GUIDE.md`, `CONTRIBUTING.md`, and `PUBLISHING.md` for better clarity and accuracy.

### 🛠️ Improvements
- **Project Structure**: Improved naming consistency for exported widgets.
- **Scaffolding Template**: The default template now includes a full structure with `web/main.dart`, `pubspec.yaml`, and `analysis_options.yaml`.

---

## [1.1.0] - 2026-01-08

### 🎨 Styling
- **Raw CSS Support**: Added `rawCss` property to all widgets for direct CSS styling.
- **Custom Painting**: Enhanced `FDSvgPicture` and `FDCustomPaint` with custom styling capabilities.

### 🐛 Bug Fixes
- Fixed `FDIframe` naming consistency.
- Improved constructor initialization for input widgets.

---

## [1.0.0] - 2026-01-02

### 🎉 Initial Release
- **Core Framework**: Base `Widget`, `BuildContext`, `StatelessWidget`, and `StatefulWidget` classes.
- **Comprehensive Widget Library**: 100+ widgets across 10 categories.
- **Zero Dependencies**: Pure Dart implementation for the web.
- **Animations**: Transition and fade effects.
- **Forms**: Built-in validation and input management.
- **Media**: Native support for Video, Audio, YouTube, and Maps.

---

[1.2.0]: https://github.com/Heebu/flart/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/Heebu/flart/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/Heebu/flart/releases/tag/v1.0.0
