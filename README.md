# Mood Tracker

A single-screen Flutter web app for tracking daily moods with custom-drawn expressive faces.

## Features

- 5 distinct mood types (Happy, Excited, Neutral, Tired, Sad)
- Custom-painted faces using Flutter's CustomPainter
- Interactive timeline showing last 7 entries
- Smooth animations on tap
- Clean, responsive design

## Technical Implementation

### CustomPainter
Each mood face is drawn from scratch using Canvas drawing primitives:
- `drawCircle` - Face base, eyes, and cheeks
- `drawArc` - Smiles, frowns, and eye variations
- `drawPath` - Tear drops and special effects

All mood expressions are rendered with basic shapes, no images or icon fonts.

### State Management
Uses Provider pattern with ChangeNotifier for reactive state updates. The MoodProvider manages mood entries and animation states.

### Project Structure
```
lib/
├── main.dart                 # App entry point
├── models/
│   └── mood_entry.dart       # Data models
├── painters/
│   └── mood_face_painter.dart # CustomPainter implementation
├── providers/
│   └── mood_provider.dart    # State management
├── screens/
│   └── home_screen.dart      # Main UI
└── widgets/
    ├── mood_face.dart        # Animated face widget
    └── timeline_card.dart    # Timeline cards
```

## Getting Started

### Prerequisites
- Flutter SDK 3.x or higher
- Web browser (Chrome recommended)

### Installation

```bash
git clone https://github.com/yourusername/mood_tracker.git
cd mood_tracker
flutter pub get
```

### Run Locally

```bash
flutter run -d chrome
```

### Build for Production

```bash
flutter build web --release
```

Output will be in `build/web/` directory.

## Deployment

### Firebase Hosting

```bash
npm install -g firebase-tools
firebase login
firebase init hosting
flutter build web --release
firebase deploy --only hosting
```

### Vercel

```bash
npm install -g vercel
flutter build web --release
vercel --prod
```

Or connect your GitHub repository to Vercel for automatic deployments.

## Usage

1. Tap any mood face to log your current mood
2. View your last 7 entries in the horizontal timeline
3. Tap any timeline entry to trigger an animation
4. Each entry shows the date, time, and mood face

## Technologies

- Flutter & Dart
- Provider for state management
- CustomPainter for graphics
- Material Design 3

## License

This project is open source and available under the MIT License.

---

Built with ❤️ using Flutter
