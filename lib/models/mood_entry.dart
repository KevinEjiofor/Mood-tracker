import 'package:flutter/material.dart';

enum MoodType { happy, excited, neutral, tired, sad }

class MoodEntry {
  final String id;
  final MoodType mood;
  final DateTime timestamp;

  MoodEntry({required this.id, required this.mood, required this.timestamp});

  Map<String, dynamic> toJson() => {
    'id': id,
    'mood': mood.index,
    'timestamp': timestamp.toIso8601String(),
  };

  factory MoodEntry.fromJson(Map<String, dynamic> json) => MoodEntry(
    id: json['id'],
    mood: MoodType.values[json['mood']],
    timestamp: DateTime.parse(json['timestamp']),
  );
}

extension MoodExtension on MoodType {
  Color get color {
    switch (this) {
      case MoodType.happy:   return const Color(0xFFFFC93C);
      case MoodType.excited: return const Color(0xFFFF6B9D);
      case MoodType.neutral: return const Color(0xFF95E1D3);
      case MoodType.tired:   return const Color(0xFF9B9ECE);
      case MoodType.sad:     return const Color(0xFF5DADE2);
    }
  }
  String get label {
    switch (this) {
      case MoodType.happy:   return 'Happy';
      case MoodType.excited: return 'Excited';
      case MoodType.neutral: return 'Neutral';
      case MoodType.tired:   return 'Tired';
      case MoodType.sad:     return 'Sad';
    }
  }
}
