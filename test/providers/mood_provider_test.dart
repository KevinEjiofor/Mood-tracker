import 'package:flutter_test/flutter_test.dart';
import 'package:mood_tracker/models/mood_entry.dart';
import 'package:mood_tracker/providers/mood_provider.dart';

void main() {
  group('MoodProvider', () {
    late MoodProvider provider;

    setUp(() {
      provider = MoodProvider();
    });

    test('initial state should be empty', () {
      expect(provider.last7, isEmpty);
      expect(provider.animatingId, isNull);
    });

    test('logMood should add a new mood entry', () {
      provider.logMood(MoodType.happy);

      expect(provider.last7.length, 1);
      expect(provider.last7.first.mood, MoodType.happy);
    });

    test('logMood should add multiple entries', () {
      provider.logMood(MoodType.happy);
      provider.logMood(MoodType.sad);
      provider.logMood(MoodType.neutral);

      expect(provider.last7.length, 3);
      expect(provider.last7[0].mood, MoodType.happy);
      expect(provider.last7[1].mood, MoodType.sad);
      expect(provider.last7[2].mood, MoodType.neutral);
    });

    test('last7 should return maximum 7 entries', () {
      for (int i = 0; i < 10; i++) {
        provider.logMood(MoodType.happy);
      }

      expect(provider.last7.length, 7);
    });

    test('last7 should return entries in chronological order', () {
      provider.logMood(MoodType.happy);
      provider.logMood(MoodType.sad);
      provider.logMood(MoodType.excited);

      final entries = provider.last7;
      expect(entries[0].timestamp.isBefore(entries[1].timestamp) ||
             entries[0].timestamp.isAtSameMomentAs(entries[1].timestamp), isTrue);
      expect(entries[1].timestamp.isBefore(entries[2].timestamp) ||
             entries[1].timestamp.isAtSameMomentAs(entries[2].timestamp), isTrue);
    });

    test('triggerAnimation should set animatingId', () async {
      provider.logMood(MoodType.happy);
      final entryId = provider.last7.first.id;

      final future = provider.triggerAnimation(entryId);
      expect(provider.animatingId, entryId);

      await future;
      expect(provider.animatingId, isNull);
    });

    test('triggerAnimation should clear after delay', () async {
      provider.logMood(MoodType.happy);
      final entryId = provider.last7.first.id;

      await provider.triggerAnimation(entryId);

      expect(provider.animatingId, isNull);
    });
  });
}

