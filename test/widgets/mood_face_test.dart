import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mood_tracker/models/mood_entry.dart';
import 'package:mood_tracker/widgets/mood_face.dart';

void main() {
  group('MoodFace Widget', () {
    testWidgets('should render with default size', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MoodFace(mood: MoodType.happy),
          ),
        ),
      );

      expect(find.byType(MoodFace), findsOneWidget);
      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('should render with custom size', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MoodFace(mood: MoodType.happy, size: 100),
          ),
        ),
      );

      final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
      final moodFaceSizedBox = sizedBoxes.firstWhere((box) => box.width == 100);
      expect(moodFaceSizedBox.width, 100);
      expect(moodFaceSizedBox.height, 100);
    });

    testWidgets('should render all mood types', (WidgetTester tester) async {
      for (final mood in MoodType.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MoodFace(mood: mood),
            ),
          ),
        );

        expect(find.byType(MoodFace), findsOneWidget);
        expect(find.byType(CustomPaint), findsWidgets);
      }
    });

    testWidgets('should complete animation lifecycle', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MoodFace(mood: MoodType.happy, animate: true),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(MoodFace), findsOneWidget);
    });

    testWidgets('should use AnimatedBuilder for animation', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MoodFace(mood: MoodType.happy, animate: false),
          ),
        ),
      );

      expect(find.byType(AnimatedBuilder), findsWidgets);
    });
  });
}


