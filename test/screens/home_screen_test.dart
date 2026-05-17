import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mood_tracker/models/mood_entry.dart';
import 'package:mood_tracker/providers/mood_provider.dart';
import 'package:mood_tracker/screens/home_screen.dart';
import 'package:mood_tracker/widgets/mood_face.dart';
import 'package:mood_tracker/widgets/timeline_card.dart';

void main() {
  group('HomeScreen Widget', () {
    late MoodProvider provider;

    setUp(() {
      provider = MoodProvider();
    });

    testWidgets('should render app header and title', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: provider,
            child: const HomeScreen(),
          ),
        ),
      );

      expect(find.text('Mood Tracker'), findsOneWidget);
      expect(find.text('How are you feeling today?'), findsOneWidget);
      expect(find.byIcon(Icons.mood), findsOneWidget);
    });

    testWidgets('should display all mood options', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: provider,
            child: const HomeScreen(),
          ),
        ),
      );

      expect(find.text('Tap a face to log your mood'), findsOneWidget);

      expect(find.byType(MoodFace), findsNWidgets(5));

      expect(find.text('Happy'), findsOneWidget);
      expect(find.text('Excited'), findsOneWidget);
      expect(find.text('Neutral'), findsOneWidget);
      expect(find.text('Tired'), findsOneWidget);
      expect(find.text('Sad'), findsOneWidget);
    });

    testWidgets('should show empty state when no entries', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: provider,
            child: const HomeScreen(),
          ),
        ),
      );

      expect(find.text('Recent entries'), findsOneWidget);
      expect(find.text('No entries yet'), findsOneWidget);
      expect(find.text('Tap a face above to get started'), findsOneWidget);
      expect(find.byIcon(Icons.sentiment_satisfied_alt_outlined), findsOneWidget);
    });

    testWidgets('should log mood when tapping a face', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: provider,
            child: const HomeScreen(),
          ),
        ),
      );

      expect(provider.last7.length, 0);

      final happyButton = find.ancestor(
        of: find.text('Happy'),
        matching: find.byType(GestureDetector),
      );

      await tester.tap(happyButton);
      await tester.pump();

      expect(provider.last7.length, 1);
      expect(provider.last7.first.mood, MoodType.happy);
    });

    testWidgets('should show snackbar when mood is logged', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: provider,
            child: const HomeScreen(),
          ),
        ),
      );

      final happyButton = find.ancestor(
        of: find.text('Happy'),
        matching: find.byType(GestureDetector),
      );

      await tester.tap(happyButton);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Happy logged!'), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('should display timeline when entries exist', (WidgetTester tester) async {
      provider.logMood(MoodType.happy);
      provider.logMood(MoodType.sad);
      provider.logMood(MoodType.neutral);

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: provider,
            child: const HomeScreen(),
          ),
        ),
      );

      expect(find.byType(TimelineCard), findsNWidgets(3));

      expect(find.text('3 / 7'), findsOneWidget);

      expect(find.text('No entries yet'), findsNothing);
    });

    testWidgets('should display maximum 7 entries in timeline', (WidgetTester tester) async {
      for (int i = 0; i < 10; i++) {
        provider.logMood(MoodType.values[i % MoodType.values.length]);
      }

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: provider,
            child: const HomeScreen(),
          ),
        ),
      );

      expect(find.byType(TimelineCard), findsWidgets);
      expect(find.text('7 / 7'), findsOneWidget);
    });

    testWidgets('timeline should be horizontally scrollable', (WidgetTester tester) async {
      for (int i = 0; i < 7; i++) {
        provider.logMood(MoodType.happy);
      }

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: provider,
            child: const HomeScreen(),
          ),
        ),
      );

      final listView = tester.widget<ListView>(find.byType(ListView));
      expect(listView.scrollDirection, Axis.horizontal);
    });

    testWidgets('should log different moods', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: provider,
            child: const HomeScreen(),
          ),
        ),
      );

      final excitedButton = find.ancestor(
        of: find.text('Excited'),
        matching: find.byType(GestureDetector),
      );
      await tester.tap(excitedButton);
      await tester.pump();

      expect(provider.last7.length, 1);
      expect(provider.last7.first.mood, MoodType.excited);

      final tiredButton = find.ancestor(
        of: find.text('Tired'),
        matching: find.byType(GestureDetector),
      );
      await tester.tap(tiredButton);
      await tester.pump();

      expect(provider.last7.length, 2);
      expect(provider.last7[1].mood, MoodType.tired);
    });

    testWidgets('should handle responsive layout for wide screens', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: provider,
            child: const HomeScreen(),
          ),
        ),
      );

      expect(find.byType(HomeScreen), findsOneWidget);

      addTearDown(tester.view.resetPhysicalSize);
    });

    testWidgets('should handle responsive layout for narrow screens', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: provider,
            child: const HomeScreen(),
          ),
        ),
      );

      expect(find.byType(HomeScreen), findsOneWidget);

      addTearDown(tester.view.resetPhysicalSize);
    });

    testWidgets('should have proper styling and colors', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: provider,
            child: const HomeScreen(),
          ),
        ),
      );

      final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
      expect(scaffold.backgroundColor, const Color(0xFFF5F5FB));
    });

    testWidgets('timeline cards should be tappable', (WidgetTester tester) async {
      provider.logMood(MoodType.happy);

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: provider,
            child: const HomeScreen(),
          ),
        ),
      );

      final timelineCard = find.byType(TimelineCard);
      expect(timelineCard, findsOneWidget);

      await tester.tap(timelineCard);
      await tester.pump();

      expect(provider.animatingId, isNotNull);

      await tester.pump(const Duration(milliseconds: 800));
      await tester.pump();
    });
  });
}




