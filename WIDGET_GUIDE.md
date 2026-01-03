# Flart Widget Guide 📚

Complete reference guide for all 100+ Flart widgets with examples and usage patterns.

---

## Table of Contents

1. [Structure Widgets](#structure-widgets)
2. [Layout Widgets](#layout-widgets)
3. [Input & Form Widgets](#input--form-widgets)
4. [Button Widgets](#button-widgets)
5. [Text Widgets](#text-widgets)
6. [Picker Widgets](#picker-widgets)
7. [Animation Widgets](#animation-widgets)
8. [Media Widgets](#media-widgets)
9. [Display Widgets](#display-widgets)
10. [Painting Widgets](#painting-widgets)
11. [Shader & Effect Widgets](#shader--effect-widgets)
12. [Styling](#styling)

---

## Structure Widgets

### Scaffold

The main application structure providing app bar, body, drawer, and more.

```dart
Scaffold(
  appBar: AppBar(title: Text('My App')),
  drawer: Drawer(child: Text('Menu')),
  body: Center(child: Text('Content')),
  floatingActionButton: FloatingActionButton(
    onPressed: () => print('FAB clicked'),
    child: Icon(icon: 'add'),
  ),
  bottomNavigationBar: BottomNavigationBar(
    items: [
      BottomNavigationBarItem(icon: Icon(icon: 'home'), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(icon: 'search'), label: 'Search'),
    ],
  ),
)
```

### AppBar

Top application bar with title and actions.

```dart
AppBar(
  title: Text('Title'),
  leading: IconButton(
    icon: Icon(icon: 'menu'),
    onPressed: () => openDrawer(),
  ),
  actions: [
    IconButton(icon: Icon(icon: 'search'), onPressed: () {}),
    IconButton(icon: Icon(icon: 'more_vert'), onPressed: () {}),
  ],
  backgroundColor: FlartColor.hex('#007bff'),
)
```

### Container

Versatile box for layout and styling.

```dart
Container(
  width: 200,
  height: 100,
  padding: EdgeInsets.all(16),
  margin: EdgeInsets.symmetric(horizontal: 20),
  decoration: BoxDecoration(
    color: FlartColor.hex('#f0f0f0'),
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: '#cccccc', width: 1),
  ),
  child: Text('Container content'),
)
```

### Card

Material design card with elevation.

```dart
Card(
  elevation: 4.0,
  padding: EdgeInsets.all(16),
  margin: EdgeInsets.all(8),
  borderRadius: BorderRadius.circular(12),
  child: Column(
    children: [
      Text('Card Title', style: TextStyle(fontSize: 18, fontWeight: 'bold')),
      SizedBox(height: 8),
      Text('Card content goes here'),
    ],
  ),
)
```

### Drawer

Side navigation drawer.

```dart
Drawer(
  child: Column(
    children: [
      Container(
        height: 150,
        color: FlartColors.blue,
        child: Center(child: Text('Header')),
      ),
      ListTile(title: Text('Item 1'), onTap: () {}),
      ListTile(title: Text('Item 2'), onTap: () {}),
      Divider(),
      ListTile(title: Text('Settings'), onTap: () {}),
    ],
  ),
)
```

### Dialog

Modal dialog box.

```dart
Dialog(
  title: Text('Confirm'),
  content: Text('Are you sure you want to delete this item?'),
  actions: [
    TextButton(
      onPressed: () => closeDialog(),
      child: Text('Cancel'),
    ),
    ElevatedButton(
      onPressed: () => confirmDelete(),
      child: Text('Delete'),
    ),
  ],
)
```

### SizedBox

Fixed size box for spacing.

```dart
Column(
  children: [
    Text('First'),
    SizedBox(height: 20), // Vertical spacing
    Text('Second'),
  ],
)

Row(
  children: [
    Text('Left'),
    SizedBox(width: 30), // Horizontal spacing
    Text('Right'),
  ],
)
```

### Spacer

Flexible spacing in Row/Column.

```dart
Row(
  children: [
    Text('Left'),
    Spacer(), // Takes all available space
    Text('Right'),
  ],
)
```

### Expanded

Flexible child that fills available space.

```dart
Row(
  children: [
    Text('Fixed'),
    Expanded(
      child: Container(color: FlartColors.blue),
    ),
    Text('Fixed'),
  ],
)
```

---

## Layout Widgets

### Row

Horizontal layout.

```dart
Row(
  mainAxisAlignment: AxisAlignment.spaceBetween,
  crossAxisAlignment: AxisAlignment.center,
  children: [
    Icon(icon: 'star'),
    Text('Rating'),
    Text('4.5'),
  ],
)
```

**Alignment Options:**
- `AxisAlignment.start` - Align to start
- `AxisAlignment.center` - Center align
- `AxisAlignment.end` - Align to end
- `AxisAlignment.spaceBetween` - Space between items
- `AxisAlignment.spaceAround` - Space around items
- `AxisAlignment.spaceEvenly` - Even spacing

### Column

Vertical layout.

```dart
Column(
  mainAxisAlignment: AxisAlignment.center,
  crossAxisAlignment: AxisAlignment.stretch,
  children: [
    Text('Title'),
    SizedBox(height: 10),
    Text('Subtitle'),
    SizedBox(height: 20),
    ElevatedButton(
      onPressed: () {},
      child: Text('Action'),
    ),
  ],
)
```

### Stack

Layered layout with positioned children.

```dart
Stack(
  children: [
    Image(src: '/images/background.jpg'),
    Positioned(
      top: 20,
      right: 20,
      child: Icon(icon: 'favorite', color: '#ff0000'),
    ),
    Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: 'rgba(0,0,0,0.5)',
        padding: EdgeInsets.all(16),
        child: Text('Overlay Text', style: TextStyle(color: '#ffffff')),
      ),
    ),
  ],
)
```

### Positioned

Absolute positioning within Stack.

```dart
Positioned(
  top: 10,
  left: 10,
  width: 100,
  height: 100,
  child: Container(color: FlartColors.red),
)
```

### Center

Centers its child.

```dart
Center(
  child: Text('Centered Text'),
)
```

### Align

Custom alignment.

```dart
Align(
  alignment: Alignment.topRight,
  child: Icon(icon: 'close'),
)
```

**Alignment Options:**
- `Alignment.topLeft`, `Alignment.topCenter`, `Alignment.topRight`
- `Alignment.centerLeft`, `Alignment.center`, `Alignment.centerRight`
- `Alignment.bottomLeft`, `Alignment.bottomCenter`, `Alignment.bottomRight`

### ListView

Scrollable list.

```dart
// Static list
ListView(
  children: [
    ListTile(title: Text('Item 1')),
    ListTile(title: Text('Item 2')),
    ListTile(title: Text('Item 3')),
  ],
)

// Builder pattern
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text(items[index].title),
      subtitle: Text(items[index].subtitle),
      onTap: () => selectItem(index),
    );
  },
)

// Separated list
ListView.separated(
  itemCount: items.length,
  itemBuilder: (context, index) => ListTile(title: Text(items[index])),
  separatorBuilder: (context, index) => Divider(),
)
```

### GridView

Grid layout.

```dart
GridView(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
  ),
  children: [
    Card(child: Center(child: Text('1'))),
    Card(child: Center(child: Text('2'))),
    Card(child: Center(child: Text('3'))),
  ],
)
```

---

## Input & Form Widgets

### TextField

Text input with validation and styling.

```dart
TextField(
  label: 'Email',
  placeholder: 'Enter your email',
  keyboardType: TextInputType.email,
  prefixIcon: Icon(icon: 'email'),
  suffixIcon: Icon(icon: 'check'),
  errorText: hasError ? 'Invalid email' : null,
  helperText: 'We\'ll never share your email',
  onChanged: (value) => validateEmail(value),
  onSubmitted: (value) => submitForm(),
  maxLength: 100,
)
```

**Input Types:**
- `TextInputType.text` - Regular text
- `TextInputType.email` - Email keyboard
- `TextInputType.number` - Numeric keyboard
- `TextInputType.phone` - Phone keyboard
- `TextInputType.url` - URL keyboard

### TextFormField

TextField with built-in validation.

```dart
TextFormField(
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

Multi-line text input.

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

### Checkbox

Boolean selection.

```dart
Checkbox(
  value: isChecked,
  onChanged: (value) => setState(() => isChecked = value),
  activeColor: FlartColors.blue,
)

// With label
Row(
  children: [
    Checkbox(value: agreed, onChanged: (v) => setState(() => agreed = v)),
    Text('I agree to the terms'),
  ],
)
```

### Radio

Single selection from options.

```dart
Column(
  children: [
    Row(
      children: [
        Radio<String>(
          value: 'option1',
          groupValue: selectedOption,
          onChanged: (value) => setState(() => selectedOption = value),
        ),
        Text('Option 1'),
      ],
    ),
    Row(
      children: [
        Radio<String>(
          value: 'option2',
          groupValue: selectedOption,
          onChanged: (value) => setState(() => selectedOption = value),
        ),
        Text('Option 2'),
      ],
    ),
  ],
)
```

### Switch

Toggle switch.

```dart
Switch(
  value: isEnabled,
  onChanged: (value) => setState(() => isEnabled = value),
  activeColor: FlartColors.green,
  inactiveColor: FlartColors.grey,
)

// With label
Row(
  mainAxisAlignment: AxisAlignment.spaceBetween,
  children: [
    Text('Enable notifications'),
    Switch(value: notifications, onChanged: toggleNotifications),
  ],
)
```

### Slider

Range selection.

```dart
Slider(
  value: volume,
  min: 0.0,
  max: 100.0,
  divisions: 10,
  onChanged: (value) => setState(() => volume = value),
  activeColor: FlartColors.blue,
)

// With label
Column(
  children: [
    Text('Volume: ${volume.toInt()}'),
    Slider(
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
  hint: Text('Select Country'),
  items: [
    DropdownMenuItem(value: 'us', child: Text('United States')),
    DropdownMenuItem(value: 'uk', child: Text('United Kingdom')),
    DropdownMenuItem(value: 'ca', child: Text('Canada')),
  ],
  onChanged: (value) => setState(() => selectedCountry = value),
  width: 200,
)
```

### Form

Form container with validation.

```dart
final formKey = GlobalKey<FormState>();

Form(
  key: formKey,
  child: Column(
    children: [
      TextFormField(
        label: 'Name',
        validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
      ),
      TextFormField(
        label: 'Email',
        validator: (v) => v?.contains('@') == true ? null : 'Invalid',
      ),
      ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            submitForm();
          }
        },
        child: Text('Submit'),
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
  prefixIcon: Icon(icon: 'search'),
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
  label: 'Upload Image',
  accept: 'image/*',
  multiple: false,
  buttonText: 'Choose Image',
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

## Button Widgets

### Button

Generic button with comprehensive events.

```dart
Button(
  text: 'Click Me',
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

### ElevatedButton

Material design elevated button.

```dart
ElevatedButton(
  onPressed: () => submitForm(),
  child: Text('Submit'),
  cssStyle: {
    'background-color': '#28a745',
    'padding': '12px 24px',
  },
)
```

### TextButton

Flat text button.

```dart
TextButton(
  label: 'Cancel',
  onPressed: () => cancel(),
  style: TextStyle(color: '#6c757d'),
)
```

### IconButton

Icon-only button.

```dart
IconButton(
  icon: Icon(icon: 'favorite', size: 24, color: '#ff0000'),
  onPressed: () => toggleFavorite(),
)
```

### GestureDetector

Comprehensive gesture detection.

```dart
GestureDetector(
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
  
  child: Container(
    width: 200,
    height: 200,
    color: FlartColors.blue,
    child: Center(child: Text('Interact with me')),
  ),
)
```

---

## Text Widgets

### Text

Basic text display.

```dart
Text(
  'Hello World',
  style: TextStyle(
    fontSize: 24,
    fontWeight: 'bold',
    color: '#333333',
    fontFamily: 'Arial',
    textDecoration: 'underline',
  ),
  textAlign: TextAlign.center,
)
```

**Text Styles:**
- `fontSize` - Size in pixels
- `fontWeight` - 'normal', 'bold', '100'-'900'
- `color` - Hex color
- `fontFamily` - Font name
- `textDecoration` - 'none', 'underline', 'line-through'
- `fontStyle` - 'normal', 'italic'

### RichText

Styled text with multiple styles.

```dart
RichText(
  children: [
    TextSpan(
      text: 'Bold ',
      style: TextStyle(fontWeight: 'bold'),
    ),
    TextSpan(
      text: 'Italic ',
      style: TextStyle(fontStyle: 'italic'),
    ),
    TextSpan(
      text: 'Colored',
      style: TextStyle(color: '#ff0000'),
    ),
  ],
)
```

### LinkText

Clickable hyperlink.

```dart
LinkText(
  label: 'Visit Website',
  href: 'https://example.com',
  style: TextStyle(
    color: '#007bff',
    textDecoration: 'underline',
  ),
  onPressed: () => print('Link clicked'),
)
```

### EditableText

Inline editable text.

```dart
EditableText(
  initialValue: 'Edit me',
  onChanged: (value) => updateText(value),
  style: TextStyle(fontSize: 16),
)
```

---

## Picker Widgets

### DatePicker

Date selection.

```dart
DatePicker(
  label: 'Select Date',
  initialDate: DateTime.now(),
  onChanged: (date) => selectDate(date),
)
```

### TimePicker

Time selection.

```dart
TimePicker(
  label: 'Select Time',
  initialTime: TimeOfDay.now(),
  onChanged: (time) => selectTime(time),
)
```

### ImagePicker

Image file selection.

```dart
ImagePicker(
  label: 'Choose Image',
  onChanged: (file) => uploadImage(file),
)
```

### DateRangePicker

Date range selection.

```dart
DateRangePicker(
  label: 'Select Date Range',
  startDate: DateTime.now(),
  endDate: DateTime.now().add(Duration(days: 7)),
  onChanged: (range) => filterByDateRange(range),
)
```

### MonthPicker

Month and year selection.

```dart
MonthPicker(
  label: 'Select Month',
  initialDate: DateTime.now(),
  onChanged: (date) => selectMonth(date),
)
```

### WeekPicker

Week selection.

```dart
WeekPicker(
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

Animated container transitions.

```dart
AnimatedContainer(
  duration: Duration(milliseconds: 300),
  width: isExpanded ? 300 : 100,
  height: isExpanded ? 300 : 100,
  decoration: BoxDecoration(
    color: isExpanded ? FlartColors.blue : FlartColors.red,
    borderRadius: BorderRadius.circular(isExpanded ? 50 : 10),
  ),
  child: Center(child: Text('Tap to animate')),
)
```

### AnimatedOpacity

Opacity transitions.

```dart
AnimatedOpacity(
  opacity: isVisible ? 1.0 : 0.0,
  duration: Duration(milliseconds: 500),
  child: Text('Fading text'),
)
```

### AnimatedScale

Scale transitions.

```dart
AnimatedScale(
  scale: isLarge ? 1.5 : 1.0,
  duration: Duration(milliseconds: 300),
  child: Icon(icon: 'star', size: 48),
)
```

### AnimatedRotation

Rotation transitions.

```dart
AnimatedRotation(
  turns: rotations, // 0.5 = 180 degrees, 1.0 = 360 degrees
  duration: Duration(milliseconds: 500),
  child: Icon(icon: 'refresh', size: 48),
)
```

### AnimatedSlide

Slide transitions.

```dart
AnimatedSlide(
  offset: isSlid ? Offset(1.0, 0) : Offset.zero,
  duration: Duration(milliseconds: 400),
  child: Container(
    width: 200,
    height: 100,
    color: FlartColors.blue,
  ),
)
```

### AnimatedPositioned

Position transitions in Stack.

```dart
Stack(
  children: [
    AnimatedPositioned(
      left: isRight ? 200 : 0,
      top: isBottom ? 200 : 0,
      duration: Duration(milliseconds: 500),
      child: Container(
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
  child: Container(
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
  firstChild: Icon(icon: 'play_arrow', size: 48),
  secondChild: Icon(icon: 'pause', size: 48),
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
  child: Card(
    child: Text('This card fades in automatically'),
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

### Chip

Compact information display.

```dart
Chip(
  label: Text('Flutter'),
  avatar: Icon(icon: 'code', size: 20),
  deleteIcon: Icon(icon: 'close', size: 18),
  onDeleted: () => removeChip(),
  backgroundColor: FlartColor.hex('#e0e0e0'),
)
```

### Badge

Notification badge.

```dart
Badge(
  label: '5',
  child: Icon(icon: 'notifications', size: 24),
  backgroundColor: FlartColors.red,
  textColor: FlartColors.white,
  isVisible: true,
)
```

### Tooltip

Hover tooltip.

```dart
Tooltip(
  message: 'Click to favorite',
  child: IconButton(
    icon: Icon(icon: 'favorite'),
    onPressed: () => toggleFavorite(),
  ),
  backgroundColor: FlartColor.hex('#333333'),
)
```

### SnackBar

Temporary message.

```dart
SnackBar(
  content: Text('Item deleted'),
  duration: Duration(seconds: 3),
  action: TextButton(
    label: 'UNDO',
    onPressed: () => undoDelete(),
  ),
  backgroundColor: FlartColor.hex('#323232'),
)
```

### CircularProgressIndicator

Circular loading indicator.

```dart
CircularProgressIndicator(
  size: 40,
  strokeWidth: 4,
  color: FlartColors.blue,
  backgroundColor: FlartColors.grey,
)
```

### LinearProgressIndicator

Linear progress bar.

```dart
// Determinate
LinearProgressIndicator(
  value: 0.7, // 70% complete
  height: 4,
  color: FlartColors.green,
  backgroundColor: FlartColors.grey,
)

// Indeterminate
LinearProgressIndicator(
  value: null, // Indeterminate
  height: 4,
)
```

### TabBar & TabBarView

Tabbed navigation.

```dart
class MyTabs extends StatefulWidget {
  int currentTab = 0;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          tabs: [
            Text('Tab 1'),
            Text('Tab 2'),
            Text('Tab 3'),
          ],
          currentIndex: currentTab,
          onTap: (index) => setState(() => currentTab = index),
          indicatorColor: FlartColors.blue,
          labelColor: FlartColors.blue,
          unselectedLabelColor: FlartColors.grey,
        ),
        TabBarView(
          currentIndex: currentTab,
          children: [
            Center(child: Text('Content 1')),
            Center(child: Text('Content 2')),
            Center(child: Text('Content 3')),
          ],
        ),
      ],
    );
  }
}
```

---

## Painting Widgets

### CustomPaint

Canvas-based custom painting.

```dart
CustomPaint(
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

### SvgPicture

SVG rendering.

```dart
SvgPicture.asset(
  'assets/icon.svg',
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

A container that automatically transitions its values over a duration.

```dart
AnimatedContainer(
  controller: _myAnimationController, // AnimationController with duration
  beginColor: FlartColors.blue,
  endColor: FlartColors.red,
  beginWidth: 100,
  endWidth: 200,
  beginHeight: 100,
  endHeight: 100,
  child: Center(child: Text('Animate')),
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
Container(
  color: FlartColors.purple, // Base purple
)

Container(
  color: FlartColors.deepOrange.shade100, // Light shade
)

Text(
  'Error',
  style: TextStyle(color: FlartColors.red),
)
```

### Icons

Use the `Icons` class for standard Material icons.

```dart
Icon(Icons.home)
Icon(Icons.favorite, color: FlartColors.red)
Icon(Icons.settings, size: 32)
```

### TextStyle

Text styling.

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

Container decoration.

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
import 'package:flart/flart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flart Demo'),
          backgroundColor: FlartColor.hex('#007bff'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Card with content
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          'Welcome to Flart',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: 'bold',
                          ),
                        ),
                        SizedBox(height: 8),
                        Text('Build beautiful web apps with Flutter-style widgets'),
                      ],
                    ),
                  ),
                ),
                
                SizedBox(height: 20),
                
                // Form
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        label: 'Email',
                        keyboardType: TextInputType.email,
                        prefixIcon: Icon(icon: 'email'),
                        validator: (v) => v?.contains('@') == true ? null : 'Invalid',
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        label: 'Password',
                        obscureText: true,
                        prefixIcon: Icon(icon: 'lock'),
                        validator: (v) => v != null && v.length >= 8 ? null : 'Too short',
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () => print('Submit'),
                        child: Text('Sign In'),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 20),
                
                // Animated widget
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                    color: FlartColors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
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
  child: Center(child: Text('Shader Background')),
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
- `'radial'` - Center outward

### WaveShader

Animated wave effect.

```dart
WaveShader(
  color: '#007bff',
  width: 400,
  height: 200,
  speed: 1.5,
  amplitude: 0.1,
  child: Center(
    child: Text(
      'Wave Effect',
      style: TextStyle(color: '#ffffff', fontSize: 24),
    ),
  ),
)
```

### RippleShader

Ripple effect from center.

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
  child: Center(
    child: Text(
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
Stack(
  children: [
    GradientShader(
      colors: ['#667eea', '#764ba2'],
      direction: 'diagonal',
      width: double.infinity,
      height: 400,
    ),
    Center(
      child: Column(
        mainAxisAlignment: AxisAlignment.center,
        children: [
          Text(
            'Welcome',
            style: TextStyle(
              fontSize: 48,
              fontWeight: 'bold',
              color: '#ffffff',
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => navigate(),
            child: Text('Get Started'),
          ),
        ],
      ),
    ),
  ],
)
```

#### Card with Glow Effect

```dart
Stack(
  children: [
    GlowShader(
      color: '#007bff',
      width: 300,
      height: 200,
      intensity: 1.0,
      pulse: true,
    ),
    Card(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text('Premium Feature', style: TextStyle(fontSize: 24)),
          SizedBox(height: 10),
          Text('Unlock amazing capabilities'),
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
  child: Center(
    child: Column(
      mainAxisAlignment: AxisAlignment.center,
      children: [
        CircularProgressIndicator(color: FlartColors.white),
        SizedBox(height: 20),
        Text(
          'Loading...',
          style: TextStyle(color: '#ffffff', fontSize: 20),
        ),
      ],
    ),
  ),
)
```

---

## Tips & Best Practices

### Performance
- Use `const` constructors when possible
- Minimize widget rebuilds
- Use `ListView.builder` for long lists

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
