import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/mood_entry.dart';

class MoodProvider extends ChangeNotifier {
  final List<MoodEntry> _entries = [];
  String? _animatingId;
  bool _isLoading = true;

  List<MoodEntry> get last7 =>
      _entries.reversed.take(7).toList().reversed.toList();

  List<MoodEntry> get allEntries => List.unmodifiable(_entries);

  String? get animatingId => _animatingId;

  bool get isLoading => _isLoading;

  MoodProvider() {
    _loadMoods();
  }

  Future<void> _loadMoods() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? moodsJson = prefs.getString('moods');

      if (moodsJson != null) {
        final List<dynamic> decoded = jsonDecode(moodsJson);
        _entries.clear();
        _entries.addAll(
          decoded.map((item) => MoodEntry.fromJson(item)).toList(),
        );
      }
    } catch (e) {
      debugPrint('Error loading moods: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _saveMoods() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String moodsJson = jsonEncode(
        _entries.map((entry) => entry.toJson()).toList(),
      );
      await prefs.setString('moods', moodsJson);
    } catch (e) {
      debugPrint('Error saving moods: $e');
    }
  }

  void logMood(MoodType mood) {
    _entries.add(MoodEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      mood: mood,
      timestamp: DateTime.now(),
    ));
    _saveMoods();
    notifyListeners();
  }

  Future<void> triggerAnimation(String id) async {
    _animatingId = id;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 700));
    _animatingId = null;
    notifyListeners();
  }

  Map<MoodType, int> getMoodStatistics() {
    final Map<MoodType, int> counts = {};
    for (var mood in MoodType.values) {
      counts[mood] = _entries.where((e) => e.mood == mood).length;
    }
    counts.removeWhere((key, value) => value == 0);
    return counts;
  }

  Map<String, int> getWeeklyMoodCount() {
    final Map<String, int> weekCounts = {
      'Mon': 0, 'Tue': 0, 'Wed': 0, 'Thu': 0,
      'Fri': 0, 'Sat': 0, 'Sun': 0,
    };

    final now = DateTime.now();
    final weekAgo = now.subtract(const Duration(days: 7));

    for (var entry in _entries) {
      if (entry.timestamp.isAfter(weekAgo)) {
        final dayName = _getDayName(entry.timestamp.weekday);
        weekCounts[dayName] = (weekCounts[dayName] ?? 0) + 1;
      }
    }

    return weekCounts;
  }

  String _getDayName(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }

  Future<void> clearAllMoods() async {
    _entries.clear();
    await _saveMoods();
    notifyListeners();
  }
}
