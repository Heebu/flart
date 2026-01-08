# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-01-02


## [1.1.0] - 2026-01-08

### 🌟 New Features

#### Styling
- **Raw CSS Support**: Added `rawCss` property to all widgets for direct CSS styling
- Enhanced `FDSvgPicture` and `FDCustomPaint` with custom styling capabilities

### 🐛 Bug Fixes
- Fixed `FDIframe` naming consistency (was previously referred to as `IFrame`)
- Improved constructor initialization for input widgets

## [1.0.0] - 2026-01-02

### 🎉 Initial Release

#### Added - Core Framework
- **Widget System**: Base `Widget`, `StatelessWidget`, and `StatefulWidget` classes
- **Build Context**: Context management for widget tree
- **Material App**: Application root widget with routing support
- **Run App**: Application entry point

#### Added - Structure Widgets (15)
- `FDScaffold` - Application structure
- `FDAppBar` - Top app bar
- `FDContainer` - Layout FDContainer
- `FDCard` - Material design FDCard
- `FDDrawer` - Side navigation FDDrawer
- `FDBottomNavigationBar` - Bottom navigation
- `FDFloatingActionButton` - Floating action FDButton
- `FDDialog` - Modal dialogs
- `FDDivider` & `FDVerticalDivider` - Visual separators
- `FDSizedBox` - Fixed size box
- `FDSpacer` - Flexible space
- `FDExpanded` - Flexible child
- `FDImage` - FDImage display
- `FDIcon` - FDIcon display

#### Added - Layout Widgets (8)
- `FDRow` - Horizontal layout
- `FDColumn` - Vertical layout
- `FDStack` - Layered layout
- `FDPositioned` - Absolute positioning
- `FDCenter` - FDCenter alignment
- `FDAlign` - Custom alignment
- `FDListView` - Scrollable list
- `FDGridView` - Grid layout

#### Added - Input & Form Widgets (15)
- `FDTextField` - FDText input with validation
- `FDTextFormField` - Form FDText field
- `TextArea` - Multi-line input
- `FDCheckbox` - FDCheckbox input
- `FDRadio` - FDRadio FDButton
- `FDSwitch` - Toggle FDSwitch
- `FDSlider` - Range FDSlider
- `DropdownButton` - Dropdown menu
- `Form` - Form FDContainer
- `FormField` - Generic form field
- `AutocompleteField` - Autocomplete input
- `ColorPicker` - Color selection
- `FileUpload` - File upload

#### Added - FDButton Widgets (5)
- `FDButton` - Generic FDButton with 13 event handlers
- `FDElevatedButton` - Material elevated FDButton
- `FDTextButton` - FDText-only FDButton
- `FDIconButton` - FDIcon FDButton
- `FDGestureDetector` - Comprehensive gesture detection (20+ events)

#### Added - FDText Widgets (5)
- `FDText` - Basic FDText display
- `FDRichText` - Styled FDText
- `FDEditableText` - Editable FDText
- `FDLinkText` - Hyperlink FDText

#### Added - Picker Widgets (9)
- `FDDatePicker` - Date selection
- `FDTimePicker` - Time selection
- `FDImagePicker` - FDImage file selection
- `FDDateRangePicker` - Date range selection
- `FDMonthPicker` - Month selection
- `FDWeekPicker` - Week selection
- `DateTimePicker` - Date and time selection
- `RangePicker` - Numeric range selection
- `ColorPicker` - Color selection

#### Added - Animated Widgets (8)
- `AnimatedContainer` - Animated FDContainer
- `AnimatedOpacity` - Opacity animation
- `AnimatedPositioned` - Position animation
- `AnimatedRotation` - Rotation animation
- `AnimatedScale` - Scale animation
- `AnimatedSlide` - Slide animation
- `AnimatedSize` - Size animation
- `AnimatedCrossFade` - Crossfade animation
- `FadeIn` - Auto fade-in

#### Added - Media Widgets (5)
- `VideoPlayer` - HTML5 video player
- `AudioPlayer` - HTML5 audio player
- `YouTubePlayer` - YouTube embed
- `FDIframe` - External content embed
- `MapEmbed` - Google Maps embed

#### Added - Display Widgets (7)
- `FDChip` - Compact info display
- `FDBadge` - Notification FDBadge
- `FDTooltip` - Hover FDTooltip
- `FDSnackBar` - Temporary message
- `FDCircularProgressIndicator` - Circular loader
- `FDLinearProgressIndicator` - Linear progress bar
- `FDTabBar` & `FDTabBarView` - Tabbed navigation

#### Added - Painting Widgets (2)
- `FDCustomPaint` - Canvas painting
- `FDSvgPicture` - SVG rendering

#### Added - Styling System
- `FlartColor` - Color management
- `TextStyle` - FDText styling
- `BoxDecoration` - FDContainer decoration
- `Border` & `BorderSide` - Border styling
- `BorderRadius` - Corner rounding
- `BoxShadow` - Shadow effects
- `EdgeInsets` - Padding/margin
- `Alignment` - Widget alignment
- `Gradient` - Color gradients

#### Added - Controllers
- `TextEditingController` - FDText input control
- `AnimationController` - Animation control

#### Added - Enums
- `Axis` - Layout direction
- `AxisAlignment` - Alignment options
- `TextAlign` - FDText alignment
- `TextTag` - HTML FDText tags
- `GridViewType` - Grid layout types
- `TextInputType` - Input types

#### Added - Foundation
- `VoidCallback` - No-argument callback
- `ValueChanged<T>` - Value change callback
- `ValueGetter<T>` - Value getter callback
- `Duration` - Time duration
- `Curve` - Animation curves

### ðŸ“š Documentation
- Comprehensive README with examples
- API documentation
- Widget catalog
- Form validation examples
- Animation examples
- Media integration examples

### ðŸŽ¯ Features
- **Zero Dependencies**: Pure Dart web framework
- **100+ Widgets**: Comprehensive widget library
- **Flutter-Style API**: Familiar for Flutter developers
- **Responsive Design**: Mobile and desktop ready
- **Form Validation**: Built-in validation system
- **Rich Animations**: 8 animation widgets
- **Media Support**: Video, audio, YouTube, maps
- **Gesture Detection**: 20+ gesture events
- **Theming**: Customizable styles

### ðŸ”§ Technical
- Dart SDK: >=3.0.0 <4.0.0
- Platform: Web only
- No external dependencies

---

## Future Releases

### Planned for 1.1.0
- [ ] More animation curves
- [ ] Theme system
- [ ] Internationalization support
- [ ] Accessibility improvements
- [ ] Performance optimizations

### Planned for 1.2.0
- [ ] State management integration
- [ ] Router enhancements
- [ ] More media widgets
- [ ] Advanced form builders

---

[1.0.0]: https://github.com/Heebu/flart/releases/tag/v1.0.0



