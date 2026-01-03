# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-01-02

### 🎉 Initial Release

#### Added - Core Framework
- **Widget System**: Base `Widget`, `StatelessWidget`, and `StatefulWidget` classes
- **Build Context**: Context management for widget tree
- **Material App**: Application root widget with routing support
- **Run App**: Application entry point

#### Added - Structure Widgets (15)
- `Scaffold` - Application structure
- `AppBar` - Top app bar
- `Container` - Layout container
- `Card` - Material design card
- `Drawer` - Side navigation drawer
- `BottomNavigationBar` - Bottom navigation
- `FloatingActionButton` - Floating action button
- `Dialog` - Modal dialogs
- `Divider` & `VerticalDivider` - Visual separators
- `SizedBox` - Fixed size box
- `Spacer` - Flexible space
- `Expanded` - Flexible child
- `Image` - Image display
- `Icon` - Icon display

#### Added - Layout Widgets (8)
- `Row` - Horizontal layout
- `Column` - Vertical layout
- `Stack` - Layered layout
- `Positioned` - Absolute positioning
- `Center` - Center alignment
- `Align` - Custom alignment
- `ListView` - Scrollable list
- `GridView` - Grid layout

#### Added - Input & Form Widgets (15)
- `TextField` - Text input with validation
- `TextFormField` - Form text field
- `TextArea` - Multi-line input
- `Checkbox` - Checkbox input
- `Radio` - Radio button
- `Switch` - Toggle switch
- `Slider` - Range slider
- `DropdownButton` - Dropdown menu
- `Form` - Form container
- `FormField` - Generic form field
- `AutocompleteField` - Autocomplete input
- `ColorPicker` - Color selection
- `FileUpload` - File upload

#### Added - Button Widgets (5)
- `Button` - Generic button with 13 event handlers
- `ElevatedButton` - Material elevated button
- `TextButton` - Text-only button
- `IconButton` - Icon button
- `GestureDetector` - Comprehensive gesture detection (20+ events)

#### Added - Text Widgets (5)
- `Text` - Basic text display
- `RichText` - Styled text
- `EditableText` - Editable text
- `LinkText` - Hyperlink text

#### Added - Picker Widgets (9)
- `DatePicker` - Date selection
- `TimePicker` - Time selection
- `ImagePicker` - Image file selection
- `DateRangePicker` - Date range selection
- `MonthPicker` - Month selection
- `WeekPicker` - Week selection
- `DateTimePicker` - Date and time selection
- `RangePicker` - Numeric range selection
- `ColorPicker` - Color selection

#### Added - Animated Widgets (8)
- `AnimatedContainer` - Animated container
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
- `IFrame` - External content embed
- `MapEmbed` - Google Maps embed

#### Added - Display Widgets (7)
- `Chip` - Compact info display
- `Badge` - Notification badge
- `Tooltip` - Hover tooltip
- `SnackBar` - Temporary message
- `CircularProgressIndicator` - Circular loader
- `LinearProgressIndicator` - Linear progress bar
- `TabBar` & `TabBarView` - Tabbed navigation

#### Added - Painting Widgets (2)
- `CustomPaint` - Canvas painting
- `SvgPicture` - SVG rendering

#### Added - Styling System
- `FlartColor` - Color management
- `TextStyle` - Text styling
- `BoxDecoration` - Container decoration
- `Border` & `BorderSide` - Border styling
- `BorderRadius` - Corner rounding
- `BoxShadow` - Shadow effects
- `EdgeInsets` - Padding/margin
- `Alignment` - Widget alignment
- `Gradient` - Color gradients

#### Added - Controllers
- `TextEditingController` - Text input control
- `AnimationController` - Animation control

#### Added - Enums
- `Axis` - Layout direction
- `AxisAlignment` - Alignment options
- `TextAlign` - Text alignment
- `TextTag` - HTML text tags
- `GridViewType` - Grid layout types
- `TextInputType` - Input types

#### Added - Foundation
- `VoidCallback` - No-argument callback
- `ValueChanged<T>` - Value change callback
- `ValueGetter<T>` - Value getter callback
- `Duration` - Time duration
- `Curve` - Animation curves

### 📚 Documentation
- Comprehensive README with examples
- API documentation
- Widget catalog
- Form validation examples
- Animation examples
- Media integration examples

### 🎯 Features
- **Zero Dependencies**: Pure Dart web framework
- **100+ Widgets**: Comprehensive widget library
- **Flutter-Style API**: Familiar for Flutter developers
- **Responsive Design**: Mobile and desktop ready
- **Form Validation**: Built-in validation system
- **Rich Animations**: 8 animation widgets
- **Media Support**: Video, audio, YouTube, maps
- **Gesture Detection**: 20+ gesture events
- **Theming**: Customizable styles

### 🔧 Technical
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
