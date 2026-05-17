import 'package:flutter/material.dart';
import '../models/mood_entry.dart';

class MoodProvider extends ChangeNotifier {
  final List<MoodEntry> _entries = [];
  String? _animatingId;

  List<MoodEntry> get last7 =>
      _entries.reversed.take(7).toList().reversed.toList();

  String? get animatingId => _animatingId;

  void logMood(MoodType mood) {
    _entries.add(MoodEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      mood: mood,
      timestamp: DateTime.now(),
    ));
    notifyListeners();
  }

  Future<void> triggerAnimation(String id) async {
    _animatingId = id;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 700));
    _animatingId = null;
    notifyListeners();
  }
}
