# 🎭 Mood Tracker

A beautiful, single-screen Flutter web app that helps you track your daily moods with custom-drawn expressive faces.

## ✨ Features

- **5 Unique Mood Types**: Happy, Excited, Neutral, Tired, and Sad
- **Custom-Painted Faces**: All mood expressions are drawn using Flutter's CustomPainter with basic drawing primitives (drawCircle, drawArc, drawPath)
- **Interactive Timeline**: View your last 7 mood entries in a horizontal scrollable timeline
- **Smooth Animations**: Tap any past entry to see it animate with a bounce effect
- **Color-Coded**: Each mood has a distinct color accent for easy visual recognition
- **Responsive Design**: Works beautifully on desktop and mobile browsers

## 🎨 Technical Highlights

### CustomPainter Implementation
Each mood face is drawn from scratch using Canvas primitives:
- **Face base**: `drawCircle` for the round face with shadow effects
- **Eyes**: Different styles per mood (circles, arcs, half-circles)
- **Mouth**: `drawArc` and `drawLine` for various expressions
- **Special features**: Cheeks (happy/excited), tears (sad), eyebrows (sad/tired)
- **Animation**: Scale transform with elastic curve for tap feedback

### State Management
Using **Provider** pattern for clean, reactive state management:
- `MoodProvider`: Manages mood entries and animation states
- `ChangeNotifier`: Triggers UI updates when data changes
- `Consumer`/`context.watch`: Rebuilds only necessary widgets

### Architecture
```
lib/
├── main.dart                 # App entry point with Provider setup
├── models/
│   └── mood_entry.dart       # MoodType enum, MoodEntry model, color extensions
├── painters/
│   └── mood_face_painter.dart # CustomPainter with all 5 mood expressions
├── providers/
│   └── mood_provider.dart    # State management for mood entries
├── screens/
│   └── home_screen.dart      # Main UI with mood buttons and timeline
└── widgets/
    ├── mood_face.dart        # Stateful widget wrapping CustomPainter with animation
    └── timeline_card.dart    # Timeline entry card with date and mood info
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.x or higher)
- Web browser (Chrome recommended)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/mood_tracker.git
cd mood_tracker
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run -d chrome
```

## 📦 Building for Production

Build the web app:
```bash
flutter build web --release
```

The output will be in `build/web/` directory.

## 🌐 Deployment

### Firebase Hosting

1. Install Firebase CLI:
```bash
npm install -g firebase-tools
```

2. Login to Firebase:
```bash
firebase login
```

3. Initialize Firebase (if not already done):
```bash
firebase init hosting
```

4. Build and deploy:
```bash
flutter build web --release
firebase deploy --only hosting
```

### Vercel

1. Install Vercel CLI:
```bash
npm install -g vercel
```

2. Build the app:
```bash
flutter build web --release
```

3. Deploy:
```bash
vercel --prod
```

Or simply connect your GitHub repository to Vercel dashboard for automatic deployments.

## 🎯 Key Features Explained

### Mood Logging
Tap any of the 5 mood faces to log your current mood. A snackbar confirmation appears with the mood's color.

### Timeline View
- Shows your last 7 mood entries
- Each card displays:
  - Custom-painted mood face
  - Date and time
  - Color-coded background matching the mood
  - Mood label badge

### Animation
Tap any timeline entry to trigger a smooth bounce animation using Flutter's AnimationController with elastic curves.

### Responsive Design
The app adapts to different screen sizes with:
- Constrained max width (700px) for desktop
- Appropriate padding based on screen width
- Horizontal scrollable timeline

## 🛠️ Technologies Used

- **Flutter**: Cross-platform UI framework
- **Dart**: Programming language
- **Provider**: State management
- **CustomPainter**: Custom graphics rendering
- **Material Design 3**: Modern UI components

## 📱 How It Works

1. **Tap a mood face** → Logs entry with current timestamp
2. **View timeline** → See your last 7 entries scrolling horizontally
3. **Tap entry** → Triggers animated scale effect with elastic bounce
4. **Visual feedback** → Color-coded cards and snackbar confirmations

## 🎨 Mood Types & Colors

| Mood     | Color      | Hex       | Features                              |
|----------|------------|-----------|---------------------------------------|
| Happy    | Yellow     | `#FFC93C` | Big smile, round eyes, rosy cheeks    |
| Excited  | Hot Pink   | `#FF6B9D` | Wide eyes, open mouth, sparkles       |
| Neutral  | Mint       | `#95E1D3` | Straight line mouth, simple eyes      |
| Tired    | Purple     | `#9B9ECE` | Half-closed eyes, slight frown        |
| Sad      | Sky Blue   | `#5DADE2` | Down-turned mouth, angled brows, tear |

## 🔧 Future Improvements

With more time, I would add:
- Persistent storage (SharedPreferences or Firebase)
- Data export/analytics
- Custom mood notes
- Weekly/monthly mood trends graphs
- Dark mode support
- PWA capabilities for offline use
- Mood streak tracking

## 📄 License

This project is open source and available under the MIT License.

## 👤 Author

Created as part of a Flutter developer technical assessment.

---

Built with ❤️ using Flutter
