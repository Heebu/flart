# Changelog 📝

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
