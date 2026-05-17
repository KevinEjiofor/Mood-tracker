import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mood_tracker/main.dart';
import 'package:mood_tracker/screens/home_screen.dart';

void main() {
  group('MoodTrackerApp', () {
    testWidgets('app initializes and loads correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MoodTrackerApp());

      expect(find.text('Mood Tracker'), findsOneWidget);
      expect(find.text('How are you feeling today?'), findsOneWidget);
    });

    testWidgets('app uses Material 3 theme', (WidgetTester tester) async {
      await tester.pumpWidget(const MoodTrackerApp());

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.theme?.useMaterial3, isTrue);
    });

    testWidgets('app hides debug banner', (WidgetTester tester) async {
      await tester.pumpWidget(const MoodTrackerApp());

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.debugShowCheckedModeBanner, isFalse);
    });

    testWidgets('app displays HomeScreen as home', (WidgetTester tester) async {
      await tester.pumpWidget(const MoodTrackerApp());

      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('app has correct title', (WidgetTester tester) async {
      await tester.pumpWidget(const MoodTrackerApp());

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.title, 'Mood Tracker');
    });

    testWidgets('app provides MoodProvider to widget tree', (WidgetTester tester) async {
      await tester.pumpWidget(const MoodTrackerApp());

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
