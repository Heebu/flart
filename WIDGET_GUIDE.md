# Flart Widget Guide 📚

Complete reference guide for all 100+ Flart widgets with examples and usage patterns.

---

## Table of Contents

1. [Structure Widgets](#structure-widgets)
2. [Layout Widgets](#layout-widgets)
3. [Input & Form Widgets](#input--form-widgets)
4. [FDButton Widgets](#FDButton-widgets)
5. [FDText Widgets](#FDText-widgets)
6. [Picker Widgets](#picker-widgets)
7. [Animation Widgets](#animation-widgets)
8. [Media Widgets](#media-widgets)
9. [Display Widgets](#display-widgets)
10. [Painting Widgets](#painting-widgets)
11. [Shader & Effect Widgets](#shader--effect-widgets)
12. [Styling](#styling)

---

## Structure Widgets

### FDScaffold

The main application structure providing app bar, body, FDDrawer, and more.

```dart
FDScaffold(
  FDAppBar: FDAppBar(title: FDText('My App')),
  FDDrawer: FDDrawer(child: FDText('Menu')),
  body: FDCenter(child: FDText('Content')),
  FDFloatingActionButton: FDFloatingActionButton(
    onPressed: () => print('FAB clicked'),
    child: FDIcon(FDIcon: 'add'),
  ),
  FDBottomNavigationBar: FDBottomNavigationBar(
    items: [
      FDBottomNavigationBarItem(FDIcon: FDIcon(FDIcon: 'home'), label: 'Home'),
      FDBottomNavigationBarItem(FDIcon: FDIcon(FDIcon: 'search'), label: 'Search'),
    ],
  ),
)
```

### FDAppBar

Top application bar with title and actions.

```dart
FDAppBar(
  title: FDText('Title'),
  leading: FDIconButton(
    FDIcon: FDIcon(FDIcon: 'menu'),
    onPressed: () => openDrawer(),
  ),
  actions: [
    FDIconButton(FDIcon: FDIcon(FDIcon: 'search'), onPressed: () {}),
    FDIconButton(FDIcon: FDIcon(FDIcon: 'more_vert'), onPressed: () {}),
  ],
  backgroundColor: FlartColor.hex('#007bff'),
)
```

### FDContainer

Versatile box for layout and styling.

```dart
FDContainer(
  width: 200,
  height: 100,
  padding: EdgeInsets.all(16),
  margin: EdgeInsets.symmetric(horizontal: 20),
  decoration: BoxDecoration(
    color: FlartColor.hex('#f0f0f0'),
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: '#cccccc', width: 1),
  ),
  child: FDText('FDContainer content'),
)
```

### FDCard

Material design FDCard with elevation.

```dart
FDCard(
  elevation: 4.0,
  padding: EdgeInsets.all(16),
  margin: EdgeInsets.all(8),
  borderRadius: BorderRadius.circular(12),
  child: FDColumn(
    children: [
      FDText('FDCard Title', style: TextStyle(fontSize: 18, fontWeight: 'bold')),
      FDSizedBox(height: 8),
      FDText('FDCard content goes here'),
    ],
  ),
)
```

### FDDrawer

Side navigation FDDrawer.

```dart
FDDrawer(
  child: FDColumn(
    children: [
      FDContainer(
        height: 150,
        color: FlartColors.blue,
        child: FDCenter(child: FDText('Header')),
      ),
      ListTile(title: FDText('Item 1'), onTap: () {}),
      ListTile(title: FDText('Item 2'), onTap: () {}),
      FDDivider(),
      ListTile(title: FDText('Settings'), onTap: () {}),
    ],
  ),
)
```

### FDDialog

Modal FDDialog box.

```dart
FDDialog(
  title: FDText('Confirm'),
  content: FDText('Are you sure you want to delete this item?'),
  actions: [
    FDTextButton(
      onPressed: () => closeDialog(),
      child: FDText('Cancel'),
    ),
    FDElevatedButton(
      onPressed: () => confirmDelete(),
      child: FDText('Delete'),
    ),
  ],
)
```

### FDSizedBox

Fixed size box for spacing.

```dart
FDColumn(
  children: [
    FDText('First'),
    FDSizedBox(height: 20), // Vertical spacing
    FDText('Second'),
  ],
)

FDRow(
  children: [
    FDText('Left'),
    FDSizedBox(width: 30), // Horizontal spacing
    FDText('Right'),
  ],
)
```

### FDSpacer

Flexible spacing in FDRow/FDColumn.

```dart
FDRow(
  children: [
    FDText('Left'),
    FDSpacer(), // Takes all available space
    FDText('Right'),
  ],
)
```

### FDExpanded

Flexible child that fills available space.

```dart
FDRow(
  children: [
    FDText('Fixed'),
    FDExpanded(
      child: FDContainer(color: FlartColors.blue),
    ),
    FDText('Fixed'),
  ],
)
```

### FDSingleChildScrollView

A scrollable container for when content exceeds the screen size.

```dart
FDSingleChildScrollView(
  padding: EdgeInsets.all(16),
  child: FDColumn(
    children: List.generate(20, (i) => ListTile(title: FDText('Item $i'))),
  ),
)
```

### FDPadding

Insets its child by the given padding.

```dart
FDPadding(
  padding: EdgeInsets.all(16),
  child: FDText('Padded Text'),
)
```

### FDConstrainedBox

Imposes additional constraints on its child.

```dart
FDConstrainedBox(
  constraints: BoxConstraints(
    minWidth: 100,
    maxWidth: 200,
    minHeight: 50,
  ),
  child: FDContainer(color: FlartColors.red),
)
```

---

## Layout Widgets

### FDWrap

Displays children in multiple horizontal or vertical runs.

```dart
FDWrap(
  spacing: 8.0, // gap between adjacent chips
  runSpacing: 4.0, // gap between lines
  children: [
    Chip(label: FDText('Hamilton')),
    Chip(label: FDText('Lafayette')),
    Chip(label: FDText('Mulligan')),
    Chip(label: FDText('Laurens')),
  ],
)
```

### FDIframe (Web Specific)

Embeds an external website or content.

```dart
FDIframe(
  src: 'https://flutter.dev',
  width: 800,
  height: 600,
  title: 'Flutter Website',
)
```

### FDLink (Web Specific)

Wrapper for standard HTML anchor tags.

```dart
FDLink(
  url: 'https://google.com',
  openInNewTab: true,
  child: FDText('Go to Google', style: TextStyle(color: 'blue')),
)
```

### FDRow

Horizontal layout.

```dart
FDRow(
  mainAxisAlignment: AxisAlignment.spaceBetween,
  crossAxisAlignment: Axis.center,
  children: [
    FDIcon(FDIcon: 'star'),
    FDText('Rating'),
    FDText('4.5'),
  ],
)
```

**Alignment Options:**
- `AxisAlignment.start` - FDAlign to start
- `Axis.center` - FDCenter FDAlign
- `AxisAlignment.end` - FDAlign to end
- `AxisAlignment.spaceBetween` - Space between items
- `AxisAlignment.spaceAround` - Space around items
- `AxisAlignment.spaceEvenly` - Even spacing

### FDColumn

Vertical layout.

```dart
FDColumn(
  mainAxisAlignment: Axis.center,
  crossAxisAlignment: AxisAlignment.stretch,
  children: [
    FDText('Title'),
    FDSizedBox(height: 10),
    FDText('Subtitle'),
    FDSizedBox(height: 20),
    FDElevatedButton(
      onPressed: () {},
      child: FDText('Action'),
    ),
  ],
)
```

### FDStack

Layered layout with FDPositioned children.

```dart
FDStack(
  children: [
    FDImage(src: '/images/background.jpg'),
    FDPositioned(
      top: 20,
      right: 20,
      child: FDIcon(FDIcon: 'favorite', color: '#ff0000'),
    ),
    FDPositioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: FDContainer(
        color: 'rgba(0,0,0,0.5)',
        padding: EdgeInsets.all(16),
        child: FDText('Overlay FDText', style: TextStyle(color: '#ffffff')),
      ),
    ),
  ],
)
```

### FDPositioned

Absolute positioning within FDStack.

```dart
FDPositioned(
  top: 10,
  left: 10,
  width: 100,
  height: 100,
  child: FDContainer(color: FlartColors.red),
)
```

### FDCenter

Centers its child.

```dart
FDCenter(
  child: FDText('Centered FDText'),
)
```

### FDAlign

Custom alignment.

```dart
FDAlign(
  alignment: Alignment.topRight,
  child: FDIcon(FDIcon: 'close'),
)
```

**Alignment Options:**
- `Alignment.topLeft`, `Alignment.topCenter`, `Alignment.topRight`
- `Alignment.centerLeft`, `.center`, `Alignment.centerRight`
- `Alignment.bottomLeft`, `Alignment.bottomCenter`, `Alignment.bottomRight`

### FDListView

Scrollable list.

```dart
// Static list
FDListView(
  children: [
    ListTile(title: FDText('Item 1')),
    ListTile(title: FDText('Item 2')),
    ListTile(title: FDText('Item 3')),
  ],
)

// Builder pattern
FDListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return ListTile(
      title: FDText(items[index].title),
      subtitle: FDText(items[index].subtitle),
      onTap: () => selectItem(index),
    );
  },
)

// Separated list
FDListView.separated(
  itemCount: items.length,
  itemBuilder: (context, index) => ListTile(title: FDText(items[index])),
  separatorBuilder: (context, index) => FDDivider(),
)
```

### FDGridView

Grid layout.

```dart
FDGridView(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
  ),
  children: [
    FDCard(child: FDCenter(child: FDText('1'))),
    FDCard(child: FDCenter(child: FDText('2'))),
    FDCard(child: FDCenter(child: FDText('3'))),
  ],
)
```

---

## Input & Form Widgets

### FDTextField

FDText input with validation and styling.

```dart
FDTextField(
  label: 'Email',
  placeholder: 'Enter your email',
  keyboardType: TextInputType.email,
  prefixIcon: FDIcon(FDIcon: 'email'),
  suffixIcon: FDIcon(FDIcon: 'check'),
  errorText: hasError ? 'Invalid email' : null,
  helperText: 'We\'ll never share your email',
  onChanged: (value) => validateEmail(value),
  onSubmitted: (value) => submitForm(),
  maxLength: 100,
)
```

**Input Types:**
- `TextInputType.FDText` - Regular FDText
- `TextInputType.email` - Email keyboard
- `TextInputType.number` - Numeric keyboard
- `TextInputType.phone` - Phone keyboard
- `TextInputType.url` - URL keyboard

### FDTextFormField

FDTextField with built-in validation.

```dart
FDTextFormField(
  label: 'Password',
  obscureText: true,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null; // Valid
  },
  onSaved: (value) => savePassword(value),
)
```

### TextArea

Multi-line FDText input.

```dart
TextArea(
  label: 'Description',
  placeholder: 'Enter description...',
  rows: 6,
  maxLength: 500,
  helperText: 'Describe your project in detail',
  onChanged: (value) => updateDescription(value),
)
```

### FDCheckbox

Boolean selection.

```dart
FDCheckbox(
  value: isChecked,
  onChanged: (value) => setState(() => isChecked = value),
  activeColor: FlartColors.blue,
)

// With label
FDRow(
  children: [
    FDCheckbox(value: agreed, onChanged: (v) => setState(() => agreed = v)),
    FDText('I agree to the terms'),
  ],
)
```

### FDRadio

Single selection from options.

```dart
FDColumn(
  children: [
    FDRow(
      children: [
        FDRadio<String>(
          value: 'option1',
          groupValue: selectedOption,
          onChanged: (value) => setState(() => selectedOption = value),
        ),
        FDText('Option 1'),
      ],
    ),
    FDRow(
      children: [
        FDRadio<String>(
          value: 'option2',
          groupValue: selectedOption,
          onChanged: (value) => setState(() => selectedOption = value),
        ),
        FDText('Option 2'),
      ],
    ),
  ],
)
```

### FDSwitch

Toggle FDSwitch.

```dart
FDSwitch(
  value: isEnabled,
  onChanged: (value) => setState(() => isEnabled = value),
  activeColor: FlartColors.green,
  inactiveColor: FlartColors.grey,
)

// With label
FDRow(
  mainAxisAlignment: AxisAlignment.spaceBetween,
  children: [
    FDText('Enable notifications'),
    FDSwitch(value: notifications, onChanged: toggleNotifications),
  ],
)
```

### FDSlider

Range selection.

```dart
FDSlider(
  value: volume,
  min: 0.0,
  max: 100.0,
  divisions: 10,
  onChanged: (value) => setState(() => volume = value),
  activeColor: FlartColors.blue,
)

// With label
FDColumn(
  children: [
    FDText('Volume: ${volume.toInt()}'),
    FDSlider(
      value: volume,
      min: 0,
      max: 100,
      onChanged: (v) => setState(() => volume = v),
    ),
  ],
)
```

### DropdownButton

Dropdown selection menu.

```dart
DropdownButton<String>(
  value: selectedCountry,
  hint: FDText('Select Country'),
  items: [
    DropdownMenuItem(value: 'us', child: FDText('United States')),
    DropdownMenuItem(value: 'uk', child: FDText('United Kingdom')),
    DropdownMenuItem(value: 'ca', child: FDText('Canada')),
  ],
  onChanged: (value) => setState(() => selectedCountry = value),
  width: 200,
)
```

### Form

Form FDContainer with validation.

```dart
final formKey = GlobalKey<FormState>();

Form(
  key: formKey,
  child: FDColumn(
    children: [
      FDTextFormField(
        label: 'Name',
        validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
      ),
      FDTextFormField(
        label: 'Email',
        validator: (v) => v?.contains('@') == true ? null : 'Invalid',
      ),
      FDElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            submitForm();
          }
        },
        child: FDText('Submit'),
      ),
    ],
  ),
)
```

### AutocompleteField

Input with suggestions.

```dart
AutocompleteField(
  label: 'Country',
  placeholder: 'Type to search...',
  suggestions: ['USA', 'UK', 'Canada', 'Australia', 'Germany'],
  prefixIcon: FDIcon(FDIcon: 'search'),
  onSelected: (value) => selectCountry(value),
  onChanged: (value) => filterSuggestions(value),
)
```

### ColorPicker

Color selection.

```dart
ColorPicker(
  label: 'Theme Color',
  initialColor: FlartColors.blue,
  onChanged: (color) => updateTheme(color),
)
```

### FileUpload

File selection.

```dart
FileUpload(
  label: 'Upload FDImage',
  accept: 'FDImage/*',
  multiple: false,
  buttonText: 'Choose FDImage',
  onChanged: (files) => uploadFiles(files),
)

// Multiple files
FileUpload(
  label: 'Upload Documents',
  accept: '.pdf,.doc,.docx',
  multiple: true,
  onChanged: (files) => handleFiles(files),
)
```

---

## FDButton Widgets

### FDButton

Generic FDButton with comprehensive events.

```dart
FDButton(
  FDText: 'Click Me',
  onPressed: () => print('Clicked'),
  onDoubleClick: () => print('Double clicked'),
  onLongPress: () => print('Long pressed'),
  onHover: () => print('Hovering'),
  onHoverExit: () => print('Hover ended'),
  onDragStart: () => print('Drag started'),
  onContextMenu: () => print('Right clicked'),
  draggable: true,
  cssStyle: {
    'background-color': '#007bff',
    'color': '#ffffff',
    'padding': '10px 20px',
    'border-radius': '4px',
  },
)
```

**Available Events:**
- `onPressed` / `onClick` - Click
- `onDoubleClick` - Double click
- `onLongPress` - Long press (600ms)
- `onHover` / `onHoverEnter` - Mouse enter
- `onHoverExit` - Mouse leave
- `onDragStart`, `onDrag`, `onDragEnd` - Drag events
- `onFocus`, `onBlur` - Focus events
- `onContextMenu` - Right click

### FDElevatedButton

Material design elevated FDButton.

```dart
FDElevatedButton(
  onPressed: () => submitForm(),
  child: FDText('Submit'),
  cssStyle: {
    'background-color': '#28a745',
    'padding': '12px 24px',
  },
)
```

### FDTextButton

Flat FDText FDButton.

```dart
FDTextButton(
  label: 'Cancel',
  onPressed: () => cancel(),
  style: TextStyle(color: '#6c757d'),
)
```

### FDIconButton

FDIcon-only FDButton.

```dart
FDIconButton(
  FDIcon: FDIcon(FDIcon: 'favorite', size: 24, color: '#ff0000'),
  onPressed: () => toggleFavorite(),
)
```

### FDGestureDetector

Comprehensive gesture detection.

```dart
FDGestureDetector(
  // Tap events
  onTap: () => print('Tapped'),
  onDoubleTap: () => print('Double tapped'),
  onLongPress: () => print('Long pressed'),
  onTapDown: () => print('Tap down'),
  onTapUp: () => print('Tap up'),
  
  // Hover events
  onHover: () => print('Hovering'),
  onHoverEnter: () => print('Hover started'),
  onHoverExit: () => print('Hover ended'),
  
  // Pan/Drag events
  onPanStart: () => print('Pan started'),
  onPanUpdate: () => print('Panning'),
  onPanEnd: () => print('Pan ended'),
  
  // Swipe events
  onSwipeLeft: () => navigateNext(),
  onSwipeRight: () => navigateBack(),
  onSwipeUp: () => scrollUp(),
  onSwipeDown: () => scrollDown(),
  
  // Other events
  onContextMenu: () => showMenu(),
  onFocus: () => print('Focused'),
  onBlur: () => print('Blurred'),
  onScroll: () => print('Scrolled'),
  onMouseMove: () => print('Mouse moved'),
  
  child: FDContainer(
    width: 200,
    height: 200,
    color: FlartColors.blue,
    child: FDCenter(child: FDText('Interact with me')),
  ),
)
```

---

## FDText Widgets

### FDText

Basic FDText display.

```dart
FDText(
  'Hello World',
  style: TextStyle(
    fontSize: 24,
    fontWeight: 'bold',
    color: '#333333',
    fontFamily: 'Arial',
    textDecoration: 'underline',
  ),
  textAlign: .center,
)
```

**FDText Styles:**
- `fontSize` - Size in pixels
- `fontWeight` - 'normal', 'bold', '100'-'900'
- `color` - Hex color
- `fontFamily` - Font name
- `textDecoration` - 'none', 'underline', 'line-through'
- `fontStyle` - 'normal', 'italic'

### FDRichText

Styled FDText with multiple styles.

```dart
FDRichText(
  children: [
    TextSpan(
      FDText: 'Bold ',
      style: TextStyle(fontWeight: 'bold'),
    ),
    TextSpan(
      FDText: 'Italic ',
      style: TextStyle(fontStyle: 'italic'),
    ),
    TextSpan(
      FDText: 'Colored',
      style: TextStyle(color: '#ff0000'),
    ),
  ],
)
```

### FDLinkText

Clickable hyperlink.

```dart
FDLinkText(
  label: 'Visit Website',
  href: 'https://example.com',
  style: TextStyle(
    color: '#007bff',
    textDecoration: 'underline',
  ),
  onPressed: () => print('Link clicked'),
)
```

### FDEditableText

Inline editable FDText.

```dart
FDEditableText(
  initialValue: 'Edit me',
  onChanged: (value) => updateText(value),
  style: TextStyle(fontSize: 16),
)
```

---

## Picker Widgets

### FDDatePicker

Date selection.

```dart
FDDatePicker(
  label: 'Select Date',
  initialDate: DateTime.now(),
  onChanged: (date) => selectDate(date),
)
```

### FDTimePicker

Time selection.

```dart
FDTimePicker(
  label: 'Select Time',
  initialTime: TimeOfDay.now(),
  onChanged: (time) => selectTime(time),
)
```

### FDImagePicker

FDImage file selection.

```dart
FDImagePicker(
  label: 'Choose FDImage',
  onChanged: (file) => uploadImage(file),
)
```

### FDDateRangePicker

Date range selection.

```dart
FDDateRangePicker(
  label: 'Select Date Range',
  startDate: DateTime.now(),
  endDate: DateTime.now().add(Duration(days: 7)),
  onChanged: (range) => filterByDateRange(range),
)
```

### FDMonthPicker

Month and year selection.

```dart
FDMonthPicker(
  label: 'Select Month',
  initialDate: DateTime.now(),
  onChanged: (date) => selectMonth(date),
)
```

### FDWeekPicker

Week selection.

```dart
FDWeekPicker(
  label: 'Select Week',
  initialWeek: '2026-W01',
  onChanged: (week) => selectWeek(week),
)
```

### DateTimePicker

Date and time selection.

```dart
DateTimePicker(
  label: 'Appointment Time',
  initialDateTime: DateTime.now(),
  helperText: 'Select your preferred appointment time',
  onChanged: (dateTime) => scheduleAppointment(dateTime),
)
```

### RangePicker

Numeric range selection with dual sliders.

```dart
RangePicker(
  label: 'Price Range',
  min: 0,
  max: 1000,
  startValue: 100,
  endValue: 500,
  onChanged: (range) => filterByPrice(range.start, range.end),
)
```

---

## Animation Widgets

### AnimatedContainer

Animated FDContainer transitions.

```dart
AnimatedContainer(
  duration: Duration(milliseconds: 300),
  width: isExpanded ? 300 : 100,
  height: isExpanded ? 300 : 100,
  decoration: BoxDecoration(
    color: isExpanded ? FlartColors.blue : FlartColors.red,
    borderRadius: BorderRadius.circular(isExpanded ? 50 : 10),
  ),
  child: FDCenter(child: FDText('Tap to animate')),
)
```

### AnimatedOpacity

Opacity transitions.

```dart
AnimatedOpacity(
  opacity: isVisible ? 1.0 : 0.0,
  duration: Duration(milliseconds: 500),
  child: FDText('Fading FDText'),
)
```

### AnimatedScale

Scale transitions.

```dart
AnimatedScale(
  scale: isLarge ? 1.5 : 1.0,
  duration: Duration(milliseconds: 300),
  child: FDIcon(FDIcon: 'star', size: 48),
)
```

### AnimatedRotation

Rotation transitions.

```dart
AnimatedRotation(
  turns: rotations, // 0.5 = 180 degrees, 1.0 = 360 degrees
  duration: Duration(milliseconds: 500),
  child: FDIcon(FDIcon: 'refresh', size: 48),
)
```

### AnimatedSlide

Slide transitions.

```dart
AnimatedSlide(
  offset: isSlid ? Offset(1.0, 0) : Offset.zero,
  duration: Duration(milliseconds: 400),
  child: FDContainer(
    width: 200,
    height: 100,
    color: FlartColors.blue,
  ),
)
```

### AnimatedPositioned

Position transitions in FDStack.

```dart
FDStack(
  children: [
    AnimatedPositioned(
      left: isRight ? 200 : 0,
      top: isBottom ? 200 : 0,
      duration: Duration(milliseconds: 500),
      child: FDContainer(
        width: 100,
        height: 100,
        color: FlartColors.red,
      ),
    ),
  ],
)
```

### AnimatedSize

Size transitions.

```dart
AnimatedSize(
  duration: Duration(milliseconds: 300),
  child: FDContainer(
    width: currentWidth,
    height: currentHeight,
    color: FlartColors.green,
  ),
)
```

### AnimatedCrossFade

Crossfade between two widgets.

```dart
AnimatedCrossFade(
  firstChild: FDIcon(FDIcon: 'play_arrow', size: 48),
  secondChild: FDIcon(FDIcon: 'pause', size: 48),
  showFirst: isPlaying,
  duration: Duration(milliseconds: 300),
)
```

### FadeIn

Auto fade-in on render.

```dart
FadeIn(
  duration: Duration(milliseconds: 800),
  delay: Duration(milliseconds: 200),
  child: FDCard(
    child: FDText('This FDCard fades in automatically'),
  ),
)
```

---

## Media Widgets

### VideoPlayer

HTML5 video player.

```dart
VideoPlayer(
  src: '/videos/demo.mp4',
  width: 640,
  height: 360,
  controls: true,
  autoplay: false,
  loop: false,
  muted: false,
  poster: '/images/video-thumbnail.jpg',
  onPlay: () => print('Video playing'),
  onPause: () => print('Video paused'),
  onEnded: () => print('Video ended'),
)
```

### AudioPlayer

HTML5 audio player.

```dart
AudioPlayer(
  src: '/audio/music.mp3',
  controls: true,
  autoplay: false,
  loop: false,
  onPlay: () => print('Audio playing'),
  onEnded: () => print('Audio ended'),
)
```

### YouTubePlayer

YouTube video embed.

```dart
YouTubePlayer(
  videoId: 'dQw4w9WgXcQ',
  width: 560,
  height: 315,
  autoplay: false,
  controls: true,
  loop: false,
  muted: false,
)
```

### IFrame

External content embed.

```dart
IFrame(
  src: 'https://example.com',
  width: 800,
  height: 600,
  title: 'External Content',
  allowFullscreen: true,
  sandbox: 'allow-scripts allow-same-origin',
)
```

### MapEmbed

Google Maps embed.

```dart
MapEmbed(
  location: 'New York, NY',
  width: 600,
  height: 450,
  zoom: 15,
)
```

---

## Display Widgets

### FDChip

Compact information display.

```dart
FDChip(
  label: FDText('Flutter'),
  avatar: FDIcon(FDIcon: 'code', size: 20),
  deleteIcon: FDIcon(FDIcon: 'close', size: 18),
  onDeleted: () => removeChip(),
  backgroundColor: FlartColor.hex('#e0e0e0'),
)
```

### FDBadge

Notification FDBadge.

```dart
FDBadge(
  label: '5',
  child: FDIcon(FDIcon: 'notifications', size: 24),
  backgroundColor: FlartColors.red,
  textColor: FlartColors.white,
  isVisible: true,
)
```

### FDTooltip

Hover FDTooltip.

```dart
FDTooltip(
  message: 'Click to favorite',
  child: FDIconButton(
    FDIcon: FDIcon(FDIcon: 'favorite'),
    onPressed: () => toggleFavorite(),
  ),
  backgroundColor: FlartColor.hex('#333333'),
)
```

### FDSnackBar

Temporary message.

```dart
FDSnackBar(
  content: FDText('Item deleted'),
  duration: Duration(seconds: 3),
  action: FDTextButton(
    label: 'UNDO',
    onPressed: () => undoDelete(),
  ),
  backgroundColor: FlartColor.hex('#323232'),
)
```

### FDCircularProgressIndicator

Circular loading indicator.

```dart
FDCircularProgressIndicator(
  size: 40,
  strokeWidth: 4,
  color: FlartColors.blue,
  backgroundColor: FlartColors.grey,
)
```

### FDLinearProgressIndicator

Linear progress bar.

```dart
// Determinate
FDLinearProgressIndicator(
  value: 0.7, // 70% complete
  height: 4,
  color: FlartColors.green,
  backgroundColor: FlartColors.grey,
)

// Indeterminate
FDLinearProgressIndicator(
  value: null, // Indeterminate
  height: 4,
)
```

### FDTabBar & FDTabBarView

Tabbed navigation.

```dart
class MyTabs extends StatefulWidget {
  int currentTab = 0;
  
  @override
  Widget build(BuildContext context) {
    return FDColumn(
      children: [
        FDTabBar(
          tabs: [
            FDText('Tab 1'),
            FDText('Tab 2'),
            FDText('Tab 3'),
          ],
          currentIndex: currentTab,
          onTap: (index) => setState(() => currentTab = index),
          indicatorColor: FlartColors.blue,
          labelColor: FlartColors.blue,
          unselectedLabelColor: FlartColors.grey,
        ),
        FDTabBarView(
          currentIndex: currentTab,
          children: [
            FDCenter(child: FDText('Content 1')),
            FDCenter(child: FDText('Content 2')),
            FDCenter(child: FDText('Content 3')),
          ],
        ),
      ],
    );
  }
}
```

---

## Painting Widgets

### FDCustomPaint

Canvas-based custom painting.

```dart
FDCustomPaint(
  painter: MyCustomPainter(),
  size: Size(200, 200),
)

class MyCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Custom painting logic
  }
}
```

### VideoPlayer

Embeds a video player.

```dart
VideoPlayer(
  src: '/assets/video.mp4',
  controls: true,
  autoplay: false,
  loop: true,
  width: 640,
  height: 360,
  poster: '/assets/poster.jpg',
)
```

### FDSvgPicture

SVG rendering.

```dart
FDSvgPicture.asset(
  'assets/FDIcon.svg',
  width: 48,
  height: 48,
  color: FlartColors.blue,
)
```

---

## Navigation & Routing

### PageNavigator

Manage navigation between pages (widgets).

```dart
// Setup routes in main
void main() {
  PageNavigator.registerRoutes({
    '/': const HomePage(),
    '/second': const SecondPage(),
  });
  runApp(const MyApp());
}

// Navigate
PageNavigator.push(const SecondPage());
PageNavigator.pushNamed('/second');
PageNavigator.pushNewTab('/second'); // Opens in new tab

// Go back
PageNavigator.pop();
```

---

## Animation & Motion

### AnimatedContainer

A FDContainer that automatically transitions its values over a duration.

```dart
AnimatedContainer(
  controller: _myAnimationController, // AnimationController with duration
  beginColor: FlartColors.blue,
  endColor: FlartColors.red,
  beginWidth: 100,
  endWidth: 200,
  beginHeight: 100,
  endHeight: 100,
  child: FDCenter(child: FDText('Animate')),
)
```

### AnimationController

Manages animation state (forward, reverse, stop).

```dart
final controller = AnimationController(
  duration: Duration(seconds: 1),
);

// Start
controller.forward();

// Reverse
controller.reverse();
```

---

## Styling

### FlartColors

Access the comprehensive Material Design color palette.

```dart
FDContainer(
  color: FlartColors.purple, // Base purple
)

FDContainer(
  color: FlartColors.deepOrange.shade100, // Light shade
)

FDText(
  'Error',
  style: TextStyle(color: FlartColors.red),
)
```

### FDIcons

Use the `FDIcons` class for standard Material FDIcons.

```dart
FDIcon(FDIcons.home)
FDIcon(FDIcons.favorite, color: FlartColors.red)
FDIcon(FDIcons.settings, size: 32)
```

### TextStyle

FDText styling.

```dart
TextStyle(
  fontSize: 24,
  fontWeight: 'bold',
  color: '#333333',
  fontFamily: 'Arial, sans-serif',
  textDecoration: 'underline',
  fontStyle: 'italic',
  letterSpacing: 1.5,
  lineHeight: 1.5,
)
```

### BoxDecoration

FDContainer decoration.

```dart
BoxDecoration(
  color: FlartColor.hex('#ffffff'),
  borderRadius: BorderRadius.circular(12),
  border: Border.all(
    color: '#cccccc',
    width: 2,
  ),
  boxShadow: [
    BoxShadow(
      color: 'rgba(0,0,0,0.1)',
      blurRadius: 10,
      offset: Offset(0, 4),
    ),
  ],
  gradient: LinearGradient(
    colors: ['#667eea', '#764ba2'],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
)
```

### EdgeInsets

Padding and margin.

```dart
// All sides
EdgeInsets.all(16)

// Symmetric
EdgeInsets.symmetric(horizontal: 20, vertical: 10)

// Individual sides
EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10)
```

### BorderRadius

Corner rounding.

```dart
// All corners
BorderRadius.circular(8)

// Individual corners
BorderRadius.only(
  topLeft: 10,
  topRight: 10,
  bottomLeft: 0,
  bottomRight: 0,
)
```

---

## Complete Example

Here's a complete example combining multiple widgets:

```dart
import 'package:flartdart/flartdart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FDMaterialApp(
      home: FDScaffold(
        FDAppBar: FDAppBar(
          title: FDText('Flart Demo'),
          backgroundColor: FlartColor.hex('#007bff'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: FDColumn(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // FDCard with content
                FDCard(
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: FDColumn(
                      children: [
                        FDText(
                          'Welcome to Flart',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: 'bold',
                          ),
                        ),
                        FDSizedBox(height: 8),
                        FDText('Build beautiful web apps with Flutter-style widgets'),
                      ],
                    ),
                  ),
                ),
                
                FDSizedBox(height: 20),
                
                // Form
                Form(
                  child: FDColumn(
                    children: [
                      FDTextFormField(
                        label: 'Email',
                        keyboardType: TextInputType.email,
                        prefixIcon: FDIcon(FDIcon: 'email'),
                        validator: (v) => v?.contains('@') == true ? null : 'Invalid',
                      ),
                      FDSizedBox(height: 16),
                      FDTextFormField(
                        label: 'Password',
                        obscureText: true,
                        prefixIcon: FDIcon(FDIcon: 'lock'),
                        validator: (v) => v != null && v.length >= 8 ? null : 'Too short',
                      ),
                      FDSizedBox(height: 24),
                      FDElevatedButton(
                        onPressed: () => print('Submit'),
                        child: FDText('Sign In'),
                      ),
                    ],
                  ),
                ),
                
                FDSizedBox(height: 20),
                
                // Animated widget
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                    color: FlartColors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: FDCenter(
                    child: FDText(
                      'Animated!',
                      style: TextStyle(color: '#ffffff'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

---

---

## Shader & Effect Widgets

### ShaderWidget

Base shader widget with custom GLSL shaders.

```dart
ShaderWidget(
  fragmentShader: '''
    void main() {
      vec2 uv = gl_FragCoord.xy / resolution;
      vec3 color = vec3(uv.x, uv.y, 0.5);
      gl_FragColor = vec4(color, 1.0);
    }
  ''',
  width: 400,
  height: 400,
  animate: true,
  child: FDCenter(child: FDText('Shader Background')),
)
```

### GradientShader

Animated gradient effects.

```dart
// Radial gradient
GradientShader(
  colors: ['#667eea', '#764ba2'],
  direction: 'radial',
  width: 300,
  height: 300,
  animate: true,
)

// Horizontal gradient
GradientShader(
  colors: ['#f093fb', '#f5576c'],
  direction: 'horizontal',
  width: 400,
  height: 200,
)

// Diagonal gradient
GradientShader(
  colors: ['#4facfe', '#00f2fe'],
  direction: 'diagonal',
  width: 300,
  height: 300,
)
```

**Direction Options:**
- `'horizontal'` - Left to right
- `'vertical'` - Top to bottom
- `'diagonal'` - Top-left to bottom-right
- `'radial'` - FDCenter outward

### WaveShader

Animated wave effect.

```dart
WaveShader(
  color: '#007bff',
  width: 400,
  height: 200,
  speed: 1.5,
  amplitude: 0.1,
  child: FDCenter(
    child: FDText(
      'Wave Effect',
      style: TextStyle(color: '#ffffff', fontSize: 24),
    ),
  ),
)
```

### RippleShader

Ripple effect from FDCenter.

```dart
RippleShader(
  color: '#00ff00',
  width: 300,
  height: 300,
  speed: 1.0,
)
```

### PlasmaShader

Colorful plasma effect.

```dart
PlasmaShader(
  width: 400,
  height: 400,
  speed: 0.5,
  child: FDCenter(
    child: FDText(
      'Plasma Background',
      style: TextStyle(color: '#ffffff', fontSize: 28, fontWeight: 'bold'),
    ),
  ),
)
```

### GlowShader

Glow effect with optional pulse.

```dart
// Static glow
GlowShader(
  color: '#ff00ff',
  width: 200,
  height: 200,
  intensity: 1.5,
  pulse: false,
)

// Pulsing glow
GlowShader(
  color: '#00ffff',
  width: 200,
  height: 200,
  intensity: 2.0,
  pulse: true,
)
```

### NoiseShader

Grain/noise effect.

```dart
// Static noise
NoiseShader(
  width: 300,
  height: 300,
  intensity: 0.5,
  animate: false,
)

// Animated noise
NoiseShader(
  width: 300,
  height: 300,
  intensity: 0.3,
  animate: true,
)
```

### Shader Examples

#### Hero Section with Gradient

```dart
FDStack(
  children: [
    GradientShader(
      colors: ['#667eea', '#764ba2'],
      direction: 'diagonal',
      width: double.infinity,
      height: 400,
    ),
    FDCenter(
      child: FDColumn(
        mainAxisAlignment: Axis.center,
        children: [
          FDText(
            'Welcome',
            style: TextStyle(
              fontSize: 48,
              fontWeight: 'bold',
              color: '#ffffff',
            ),
          ),
          FDSizedBox(height: 20),
          FDElevatedButton(
            onPressed: () => navigate(),
            child: FDText('Get Started'),
          ),
        ],
      ),
    ),
  ],
)
```

#### FDCard with Glow Effect

```dart
FDStack(
  children: [
    GlowShader(
      color: '#007bff',
      width: 300,
      height: 200,
      intensity: 1.0,
      pulse: true,
    ),
    FDCard(
      padding: EdgeInsets.all(20),
      child: FDColumn(
        children: [
          FDText('Premium Feature', style: TextStyle(fontSize: 24)),
          FDSizedBox(height: 10),
          FDText('Unlock amazing capabilities'),
        ],
      ),
    ),
  ],
)
```

#### Loading Screen with Plasma

```dart
PlasmaShader(
  width: double.infinity,
  height: double.infinity,
  speed: 1.0,
  child: FDCenter(
    child: FDColumn(
      mainAxisAlignment: Axis.center,
      children: [
        FDCircularProgressIndicator(color: FlartColors.white),
        FDSizedBox(height: 20),
        FDText(
          'Loading...',
          style: TextStyle(color: '#ffffff', fontSize: 20),
        ),
      ],
    ),
  ),
)
```

---


### Raw CSS

Most core widgets support a `rawCss` property for direct CSS injection. This provides flexibility for custom styling not covered by the standard properties.

```dart
FDContainer(
  rawCss: 'border: 1px dashed red; transform: rotate(15deg);',
  child: FDText('Custom Styled'),
)

FDElevatedButton(
  rawCss: 'box-shadow: 0 10px 20px rgba(0,0,0,0.5);',
  child: FDText('Shadow Button'),
)
```

---

## Tips & Best Practices


### Performance
- Use `const` constructors when possible
- Minimize widget rebuilds
- Use `FDListView.builder` for long lists

### Styling
- Define common styles as constants
- Use theme colors consistently
- Leverage EdgeInsets.symmetric for cleaner code

### Forms
- Always validate user input
- Provide clear error messages
- Use appropriate keyboard types

### Animations
- Keep durations between 200-500ms
- Use appropriate curves
- Don't over-animate

### Shaders
- Use shaders sparingly for best performance
- Disable animation when not needed
- Consider mobile device capabilities

### Accessibility
- Provide meaningful labels
- Use semantic HTML
- Ensure proper contrast ratios

---

**For more information, visit the [Flart documentation](https://pub.dev/packages/flart)**




