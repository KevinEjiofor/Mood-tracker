import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/mood_entry.dart';
import '../providers/mood_provider.dart';
import 'mood_face.dart';

class TimelineCard extends StatelessWidget {
  final MoodEntry entry;
  const TimelineCard({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final isAnimating = context.watch<MoodProvider>().animatingId == entry.id;
    return GestureDetector(
      onTap: () => context.read<MoodProvider>().triggerAnimation(entry.id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 110,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        decoration: BoxDecoration(
          color: isAnimating
              ? entry.mood.color.withOpacity(0.35)
              : entry.mood.color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: entry.mood.color,
            width: isAnimating ? 2.5 : 1.5),
          boxShadow: isAnimating
              ? [BoxShadow(
                  color: entry.mood.color.withOpacity(0.4),
                  blurRadius: 12, spreadRadius: 2)]
              : [],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MoodFace(mood: entry.mood, size: 58, animate: isAnimating),
            const SizedBox(height: 8),
            Text(DateFormat('MMM d').format(entry.timestamp),
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
            Text(DateFormat('h:mm a').format(entry.timestamp),
              style: TextStyle(fontSize: 10, color: Colors.grey[500])),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: entry.mood.color.withOpacity(0.25),
                borderRadius: BorderRadius.circular(20)),
              child: Text(entry.mood.label,
                style: TextStyle(
                  fontSize: 10,
                  color: entry.mood.color,
                  fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
