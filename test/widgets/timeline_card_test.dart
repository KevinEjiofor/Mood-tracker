import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mood_tracker/models/mood_entry.dart';
import 'package:mood_tracker/providers/mood_provider.dart';
import 'package:mood_tracker/widgets/timeline_card.dart';
import 'package:mood_tracker/widgets/mood_face.dart';

void main() {
  group('TimelineCard Widget', () {
    late MoodProvider provider;
    late MoodEntry testEntry;

    setUp(() {
      provider = MoodProvider();
      testEntry = MoodEntry(
        id: 'test-123',
        mood: MoodType.happy,
        timestamp: DateTime(2026, 5, 17, 10, 30),
      );
    });

    testWidgets('should render mood entry details', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: provider,
            child: Scaffold(
              body: TimelineCard(entry: testEntry),
            ),
          ),
        ),
      );

      // Check that the card is rendered
      expect(find.byType(TimelineCard), findsOneWidget);
      expect(find.byType(MoodFace), findsOneWidget);

      // Check date and time display
      expect(find.text('May 17'), findsOneWidget);
      expect(find.text('10:30 AM'), findsOneWidget);

      // Check mood label
      expect(find.text('Happy'), findsOneWidget);
    });

    testWidgets('should be tappable', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: provider,
            child: Scaffold(
              body: TimelineCard(entry: testEntry),
            ),
          ),
        ),
      );

      final gesture = find.byType(GestureDetector);
      expect(gesture, findsOneWidget);

      // Tap the card
      await tester.tap(gesture);
      await tester.pump();

      // Animation should be triggered
      expect(provider.animatingId, testEntry.id);

      // Wait for animation to complete
      await tester.pumpAndSettle(const Duration(seconds: 1));
    });

    testWidgets('should show animation state', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: provider,
            child: Scaffold(
              body: TimelineCard(entry: testEntry),
            ),
          ),
        ),
      );

      // Get initial container
      AnimatedContainer container = tester.widget(find.byType(AnimatedContainer));
      final initialDecoration = container.decoration as BoxDecoration;

      // Trigger animation
      final animationFuture = provider.triggerAnimation(testEntry.id);
      await tester.pump();

      // Get container after animation trigger
      container = tester.widget(find.byType(AnimatedContainer));
      final animatingDecoration = container.decoration as BoxDecoration;

      // Should have different appearance when animating
      expect(animatingDecoration.border, isNot(equals(initialDecoration.border)));

      // Wait for animation to complete
      await animationFuture;
      await tester.pumpAndSettle();
    });

    testWidgets('should render all mood types correctly', (WidgetTester tester) async {
      for (final mood in MoodType.values) {
        final entry = MoodEntry(
          id: 'test-${mood.label}',
          mood: mood,
          timestamp: DateTime.now(),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: ChangeNotifierProvider.value(
              value: provider,
              child: Scaffold(
                body: TimelineCard(entry: entry),
              ),
            ),
          ),
        );

        expect(find.text(mood.label), findsOneWidget);
        expect(find.byType(MoodFace), findsOneWidget);
      }
    });

    testWidgets('should display correct time format', (WidgetTester tester) async {
      final morningEntry = MoodEntry(
        id: 'morning',
        mood: MoodType.happy,
        timestamp: DateTime(2026, 5, 17, 9, 15),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: provider,
            child: Scaffold(
              body: TimelineCard(entry: morningEntry),
            ),
          ),
        ),
      );

      expect(find.text('9:15 AM'), findsOneWidget);

      final eveningEntry = MoodEntry(
        id: 'evening',
        mood: MoodType.tired,
        timestamp: DateTime(2026, 5, 17, 21, 45),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: provider,
            child: Scaffold(
              body: TimelineCard(entry: eveningEntry),
            ),
          ),
        ),
      );

      expect(find.text('9:45 PM'), findsOneWidget);
    });

    testWidgets('should have proper styling and layout', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: provider,
            child: Scaffold(
              body: TimelineCard(entry: testEntry),
            ),
          ),
        ),
      );

      final container = tester.widget<AnimatedContainer>(find.byType(AnimatedContainer));

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.borderRadius, BorderRadius.circular(20));
      expect(decoration.color, testEntry.mood.color.withOpacity(0.12));
    });
  });
}



