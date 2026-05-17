import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mood_tracker/models/mood_entry.dart';

void main() {
  group('MoodEntry', () {
    test('should create a mood entry with required fields', () {
      final now = DateTime.now();
      final entry = MoodEntry(
        id: '123',
        mood: MoodType.happy,
        timestamp: now,
      );

      expect(entry.id, '123');
      expect(entry.mood, MoodType.happy);
      expect(entry.timestamp, now);
    });
  });

  group('MoodType', () {
    test('happy should have correct properties', () {
      expect(MoodType.happy.label, 'Happy');
      expect(MoodType.happy.color, const Color(0xFFFFC93C));
    });

    test('excited should have correct properties', () {
      expect(MoodType.excited.label, 'Excited');
      expect(MoodType.excited.color, const Color(0xFFFF6B9D));
    });

    test('neutral should have correct properties', () {
      expect(MoodType.neutral.label, 'Neutral');
      expect(MoodType.neutral.color, const Color(0xFF95E1D3));
    });

    test('tired should have correct properties', () {
      expect(MoodType.tired.label, 'Tired');
      expect(MoodType.tired.color, const Color(0xFF9B9ECE));
    });

    test('sad should have correct properties', () {
      expect(MoodType.sad.label, 'Sad');
      expect(MoodType.sad.color, const Color(0xFF5DADE2));
    });

    test('all mood types should be available', () {
      expect(MoodType.values.length, 5);
      expect(MoodType.values, contains(MoodType.happy));
      expect(MoodType.values, contains(MoodType.excited));
      expect(MoodType.values, contains(MoodType.neutral));
      expect(MoodType.values, contains(MoodType.tired));
      expect(MoodType.values, contains(MoodType.sad));
    });

    test('each mood should have unique color', () {
      final colors = MoodType.values.map((m) => m.color).toSet();
      expect(colors.length, MoodType.values.length);
    });

    test('each mood should have unique label', () {
      final labels = MoodType.values.map((m) => m.label).toSet();
      expect(labels.length, MoodType.values.length);
    });
  });
}


