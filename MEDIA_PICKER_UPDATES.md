# Media and Picker Widgets Reorganization

## Summary
Reorganized the widget structure by moving painting widgets to a dedicated folder and creating proper media widgets. Added 5 new advanced pickers.

---

## Folder Reorganization

### **Painting Folder** (NEW)
Moved from `media/` to `painting/`:
- `custom_paint.dart` - Canvas-based custom painting
- `svg_picture.dart` - SVG rendering

**Reason:** These are painting/drawing widgets, not media playback widgets.

### **Media Folder** (UPDATED)
Now contains proper media widgets:
- `media_widgets.dart` - Video, Audio, IFrame, YouTube, Maps

---

## New Media Widgets (5)

### 1. **VideoPlayer**
HTML5 video player with full controls.

**Features:**
- Autoplay, loop, muted options
- Custom poster (thumbnail)
- Play/pause/ended callbacks
- Responsive sizing
- Controls toggle

**Example:**
```dart
VideoPlayer(
  src: '/videos/intro.mp4',
  width: 640,
  height: 360,
  controls: true,
  autoplay: false,
  poster: '/images/video-thumbnail.jpg',
  onPlay: () => print('Playing'),
  onEnded: () => print('Video ended'),
)
```

### 2. **AudioPlayer**
HTML5 audio player.

**Example:**
```dart
AudioPlayer(
  src: '/audio/music.mp3',
  controls: true,
  loop: false,
  onPlay: () => print('Playing audio'),
)
```

### 3. **IFrame**
Embed external content.

**Features:**
- Fullscreen support
- Sandbox security
- Custom styling
- Title for accessibility

**Example:**
```dart
IFrame(
  src: 'https://example.com',
  width: 800,
  height: 600,
  title: 'External Content',
  allowFullscreen: true,
)
```

### 4. **YouTubePlayer**
Easy YouTube video embedding.

**Example:**
```dart
YouTubePlayer(
  videoId: 'dQw4w9WgXcQ',
  width: 560,
  height: 315,
  autoplay: false,
  controls: true,
)
```

### 5. **MapEmbed**
Google Maps embedding.

**Example:**
```dart
MapEmbed(
  location: 'New York, NY',
  width: 600,
  height: 450,
  zoom: 15,
)
```

---

## New Advanced Pickers (5)

### 1. **DateRangePicker**
Select a date range (start and end dates).

**Example:**
```dart
DateRangePicker(
  label: 'Select Date Range',
  startDate: DateTime.now(),
  endDate: DateTime.now().add(Duration(days: 7)),
  onChanged: (range) => print('${range.start} to ${range.end}'),
)
```

### 2. **MonthPicker**
Select a specific month and year.

**Example:**
```dart
MonthPicker(
  label: 'Select Month',
  initialDate: DateTime.now(),
  onChanged: (date) => print('Selected: ${date.year}-${date.month}'),
)
```

### 3. **WeekPicker**
Select a specific week.

**Example:**
```dart
WeekPicker(
  label: 'Select Week',
  initialWeek: '2026-W01',
  onChanged: (week) => print('Selected week: $week'),
)
```

### 4. **DateTimePicker**
Select both date and time.

**Example:**
```dart
DateTimePicker(
  label: 'Appointment Time',
  initialDateTime: DateTime.now(),
  helperText: 'Choose your preferred time',
  onChanged: (dateTime) => print('Selected: $dateTime'),
)
```

### 5. **RangePicker**
Select a numeric range with dual sliders.

**Example:**
```dart
RangePicker(
  label: 'Price Range',
  min: 0,
  max: 1000,
  startValue: 100,
  endValue: 500,
  onChanged: (range) => print('${range.start} - ${range.end}'),
)
```

---

## Complete Examples

### Media Gallery
```dart
Column(
  children: [
    // Video
    VideoPlayer(
      src: '/videos/demo.mp4',
      width: 640,
      height: 360,
      controls: true,
      poster: '/images/thumb.jpg',
    ),
    
    SizedBox(height: 20),
    
    // Audio
    AudioPlayer(
      src: '/audio/podcast.mp3',
      controls: true,
    ),
    
    SizedBox(height: 20),
    
    // YouTube
    YouTubePlayer(
      videoId: 'dQw4w9WgXcQ',
      width: 560,
      height: 315,
    ),
    
    SizedBox(height: 20),
    
    // Map
    MapEmbed(
      location: 'San Francisco, CA',
      width: 600,
      height: 400,
      zoom: 12,
    ),
  ],
)
```

### Booking Form with Advanced Pickers
```dart
Form(
  child: Column(
    children: [
      // Date range for stay
      DateRangePicker(
        label: 'Check-in / Check-out',
        startDate: DateTime.now(),
        endDate: DateTime.now().add(Duration(days: 3)),
      ),
      
      SizedBox(height: 16),
      
      // Specific appointment time
      DateTimePicker(
        label: 'Appointment',
        helperText: 'Select your preferred time',
      ),
      
      SizedBox(height: 16),
      
      // Price range filter
      RangePicker(
        label: 'Budget',
        min: 0,
        max: 500,
        startValue: 50,
        endValue: 200,
      ),
      
      SizedBox(height: 16),
      
      // Month for billing
      MonthPicker(
        label: 'Billing Month',
      ),
    ],
  ),
)
```

---

## Files Created/Modified

### Created:
1. `lib/src/widgets/painting/` - New folder
2. `lib/src/widgets/painting/custom_paint.dart` - Moved from media
3. `lib/src/widgets/painting/svg_picture.dart` - Moved from media
4. `lib/src/widgets/media/media_widgets.dart` - New media widgets
5. `lib/src/widgets/pickers/advanced_pickers.dart` - New advanced pickers

### Modified:
- `lib/flart.dart` - Updated exports

---

## Export Changes

**Before:**
```dart
// Media
export 'src/widgets/media/custom_paint.dart';
export 'src/widgets/media/svg_picture.dart';
```

**After:**
```dart
// Painting
export 'src/widgets/painting/custom_paint.dart';
export 'src/widgets/painting/svg_picture.dart';

// Media
export 'src/widgets/media/media_widgets.dart';

// Pickers
export 'src/widgets/pickers/advanced_pickers.dart';
```

---

## All Available via Main Import

```dart
import 'package:flart/flart.dart';
```

Now you have:
- ✅ Proper media widgets (Video, Audio, YouTube, Maps, IFrame)
- ✅ Advanced date/time pickers (DateRange, Month, Week, DateTime, Range)
- ✅ Better organized folder structure
- ✅ Painting widgets in dedicated folder

Flart's media and picker systems are now complete and well-organized! 🎉
