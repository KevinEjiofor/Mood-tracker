import 'package:flutter_test/flutter_test.dart';
import 'package:mood_tracker/main.dart';

void main() {
  testWidgets('Mood tracker app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const MoodTrackerApp());

    expect(find.text('Mood Tracker'), findsOneWidget);
    expect(find.text('How are you feeling today?'), findsOneWidget);
  });
}
