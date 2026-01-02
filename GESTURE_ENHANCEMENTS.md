# Enhanced Gesture Support for Buttons and GestureDetector

## Summary
Added comprehensive gesture and interaction support to `Button` and `GestureDetector` widgets, making them much more powerful and interactive.

---

## Button Widget - New Features

### Click Events
- `onPressed` / `onClick` - Single click/tap
- `onDoubleClick` - Double click/tap
- `onLongPress` - Long press (600ms)

### Hover Events
- `onHover` / `onHoverEnter` - Mouse enters button area
- `onHoverExit` - Mouse leaves button area

### Drag Events
- `onDragStart` - Drag operation starts
- `onDrag` - During drag
- `onDragEnd` - Drag operation ends
- `draggable` - Boolean to enable dragging

### Focus Events
- `onFocus` - Button receives focus
- `onBlur` - Button loses focus

### Context Menu
- `onContextMenu` - Right-click event

### Example Usage
```dart
Button(
  text: 'Interactive Button',
  onPressed: () => print('Clicked!'),
  onDoubleClick: () => print('Double clicked!'),
  onLongPress: () => print('Long pressed!'),
  onHover: () => print('Hovering...'),
  onHoverExit: () => print('Hover ended'),
  onDragStart: () => print('Drag started'),
  onContextMenu: () => print('Right clicked!'),
  draggable: true,
)
```

---

## GestureDetector Widget - New Features

### Tap Events
- `onTap` - Single tap
- `onDoubleTap` - Double tap
- `onLongPress` - Long press (700ms)
- `onTapDown` - Finger/mouse down
- `onTapUp` - Finger/mouse up
- `onTapCancel` - Tap cancelled

### Hover Events
- `onHover` / `onHoverEnter` - Mouse enters area
- `onHoverExit` - Mouse leaves area

### Pan/Drag Events
- `onPanStart` - Pan gesture starts
- `onPanUpdate` - During pan gesture
- `onPanEnd` - Pan gesture ends

### Swipe Events (Touch)
- `onSwipeLeft` - Swipe left
- `onSwipeRight` - Swipe right
- `onSwipeUp` - Swipe up
- `onSwipeDown` - Swipe down

### Mouse Events
- `onMouseDown` - Mouse button pressed
- `onMouseUp` - Mouse button released
- `onMouseMove` - Mouse moved over element

### Focus Events
- `onFocus` - Element receives focus
- `onBlur` - Element loses focus

### Scroll Events
- `onScroll` - Mouse wheel scrolled

### Context Menu
- `onContextMenu` - Right-click event

### Example Usage
```dart
GestureDetector(
  onTap: () => print('Tapped!'),
  onDoubleTap: () => print('Double tapped!'),
  onLongPress: () => print('Long pressed!'),
  onHover: () => print('Hovering...'),
  onPanStart: () => print('Pan started'),
  onPanUpdate: () => print('Panning...'),
  onPanEnd: () => print('Pan ended'),
  onSwipeLeft: () => print('Swiped left!'),
  onSwipeRight: () => print('Swiped right!'),
  onContextMenu: () => print('Right clicked!'),
  onScroll: () => print('Scrolled!'),
  child: Container(
    width: 200,
    height: 200,
    decoration: BoxDecoration(color: FlartColors.blue),
  ),
)
```

---

## Advanced Use Cases

### 1. **Drag and Drop**
```dart
Button(
  text: 'Drag Me',
  draggable: true,
  onDragStart: () => print('Started dragging'),
  onDrag: () => print('Dragging...'),
  onDragEnd: () => print('Dropped'),
)
```

### 2. **Custom Context Menu**
```dart
GestureDetector(
  onContextMenu: () {
    // Show custom context menu
    showDialog(...);
  },
  child: Text('Right-click me'),
)
```

### 3. **Swipe Navigation**
```dart
GestureDetector(
  onSwipeLeft: () => navigateToNext(),
  onSwipeRight: () => navigateToPrevious(),
  child: PageContent(),
)
```

### 4. **Pan to Move**
```dart
GestureDetector(
  onPanStart: () => startMoving(),
  onPanUpdate: () => updatePosition(),
  onPanEnd: () => stopMoving(),
  child: MovableWidget(),
)
```

### 5. **Hover Effects**
```dart
Button(
  text: 'Hover Me',
  onHoverEnter: () => setState(() => isHovered = true),
  onHoverExit: () => setState(() => isHovered = false),
  cssStyle: {
    'background-color': isHovered ? '#0056b3' : '#007bff',
  },
)
```

### 6. **Focus Management**
```dart
GestureDetector(
  onFocus: () => print('Focused - ready for keyboard input'),
  onBlur: () => print('Lost focus'),
  child: InputWidget(),
)
```

---

## Key Improvements

1. **✅ Comprehensive Event Coverage** - Covers all major user interactions
2. **✅ Touch & Mouse Support** - Works on both desktop and mobile
3. **✅ Swipe Detection** - Built-in swipe gesture recognition
4. **✅ Drag & Drop** - Native drag support
5. **✅ Focus Management** - Keyboard navigation support
6. **✅ Context Menu** - Right-click handling
7. **✅ Pan Gestures** - Smooth dragging/panning
8. **✅ Scroll Events** - Mouse wheel support

---

## Breaking Changes
- `GestureDetector.onDoubleClick` renamed to `onDoubleTap` for consistency with Flutter

---

## Files Modified
- `lib/src/widgets/buttons/button.dart`
- `lib/src/widgets/buttons/gesture_detector.dart`

Both widgets now provide a complete set of gesture handlers for building rich, interactive web applications!
