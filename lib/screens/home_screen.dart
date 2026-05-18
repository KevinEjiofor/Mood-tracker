import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/mood_entry.dart';
import '../providers/mood_provider.dart';
import '../widgets/mood_face.dart';
import '../widgets/timeline_card.dart';
import 'statistics_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final entries = context.watch<MoodProvider>().last7;
    final totalEntries = context.watch<MoodProvider>().allEntries.length;
    final isWide = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FB),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isWide ? 40 : 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6C63FF).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(14)),
                          child: const Icon(Icons.mood,
                            color: Color(0xFF6C63FF), size: 28)),
                        const SizedBox(width: 14),
                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          const Text('Mood Tracker',
                            style: TextStyle(fontSize: 22,
                              fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E))),
                          Text('How are you feeling today?',
                            style: TextStyle(fontSize: 13, color: Colors.grey[500])),
                        ]),
                      ]),
                      if (totalEntries > 0)
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MultiProvider(
                                  providers: [
                                    ChangeNotifierProvider.value(
                                      value: context.read<MoodProvider>(),
                                    ),
                                  ],
                                  child: const StatisticsScreen(),
                                ),
                              ),
                            );
                          },
                          icon: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF6C63FF).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.bar_chart_rounded,
                              color: Color(0xFF6C63FF),
                              size: 24,
                            ),
                          ),
                          tooltip: 'View Statistics',
                        ),
                    ],
                  ),

                  const SizedBox(height: 32),
                  const Text('Tap a face to log your mood',
                    style: TextStyle(fontSize: 15,
                      fontWeight: FontWeight.w600, color: Color(0xFF1A1A2E))),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: MoodType.values
                        .map((m) => _MoodButton(mood: m))
                        .toList()),

                  const SizedBox(height: 40),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Recent entries',
                        style: TextStyle(fontSize: 15,
                          fontWeight: FontWeight.w600, color: Color(0xFF1A1A2E))),
                      if (entries.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6C63FF).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20)),
                          child: Text('${entries.length} / 7',
                            style: const TextStyle(
                              fontSize: 12, color: Color(0xFF6C63FF),
                              fontWeight: FontWeight.w600))),
                    ]),
                  const SizedBox(height: 14),

                  if (entries.isEmpty)
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.sentiment_satisfied_alt_outlined,
                              size: 64, color: Colors.grey[300]),
                            const SizedBox(height: 12),
                            Text('No entries yet',
                              style: TextStyle(
                                fontSize: 16, color: Colors.grey[400],
                                fontWeight: FontWeight.w500)),
                            const SizedBox(height: 6),
                            Text('Tap a face above to get started',
                              style: TextStyle(fontSize: 13, color: Colors.grey[350])),
                          ],
                        ),
                      ),
                    )
                  else
                    SizedBox(
                      height: 175,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: entries.length,
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        itemBuilder: (_, i) => TimelineCard(entry: entries[i]),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MoodButton extends StatelessWidget {
  final MoodType mood;
  const _MoodButton({required this.mood});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<MoodProvider>().logMood(mood);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${mood.label} logged!'),
          backgroundColor: mood.color,
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)),
        ));
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MoodFace(mood: mood, size: 60),
            const SizedBox(height: 6),
            Text(mood.label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700])),
          ],
        ),
      ),
    );
  }
}
