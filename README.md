# Mood Tracker
A Flutter web app for tracking your daily moods with custom-drawn faces and animated timeline entries.
## Features
- Custom painted mood faces using Flutter's CustomPainter
- 5 distinct mood types: Happy, Excited, Neutral, Tired, and Sad
- Timeline showing your last 7 mood entries
- Tap entries to see them animate
- Statistics screen with pie charts and bar graphs
- Dark mode toggle
- Data persists between sessions using SharedPreferences
## Getting Started
```bash
git clone https://github.com/KevinEjiofor/Mood-tracker.git
cd mood_tracker
flutter pub get
flutter run -d chrome
```
Run tests:
```bash
flutter test
```
## Project Structure
```
lib/
├── main.dart
├── models/
│   └── mood_entry.dart
├── painters/
│   └──mood_face_painter.dart
├── providers/
│   ├── mood_provider.dart
│   └── theme_provider.dart
├── screens/
│   ├── home_screen.dart
│   └── statistics_screen.dart
└── widgets/
    ├── mood_face.dart
    └── timeline_card.dart
```
## Implementation
### CustomPainter
All mood faces are drawn using Canvas primitives like drawCircle, drawArc, and drawPath. No images or icon fonts used.
### State Management
Using Provider pattern. MoodProvider handles the mood entries and persistence, ThemeProvider manages dark mode.
### Persistence
Data saved locally with SharedPreferences using JSON serialization.
## Dependencies
- provider ^6.1.5
- fl_chart ^0.70.2
- shared_preferences ^2.3.5
- intl ^0.20.2
## Technologies
- Flutter & Dart
- Provider state management
- CustomPainter for graphics
- Material Design 3
