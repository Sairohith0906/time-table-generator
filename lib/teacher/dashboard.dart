import 'package:flutter/material.dart';
import 'dart:math' as math;

class DashboardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My Course-wise Attendance',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              _AttendanceGrid(),
              const SizedBox(height: 36),

              // MODIFICATION: Replaced Column with Row and used MainAxisAlignment.spaceAround
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _NotesCard(), // Now controls its own width
                  _DeadlinesCard(), // Fixed width of 250
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AttendanceGrid extends StatelessWidget {
  final items = const [
    {'title': 'Foundations & Education', 'percent': 0.72, 'label': '72%'},
    {'title': 'Curriculum & Pedagogy', 'percent': 0.80, 'label': '80%'},
    {'title': 'Indian Education', 'percent': 0.90, 'label': '90%'},
    {'title': 'Digital Skills', 'percent': 0.60, 'label': '60%'},
  ];

  const _AttendanceGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount;

        // Adaptive grid: 2 for small, 3 for medium, 4 for wide screens
        if (constraints.maxWidth < 700) {
          crossAxisCount = 2;
        } else if (constraints.maxWidth < 1050) {
          crossAxisCount = 3;
        } else {
          crossAxisCount = 4;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 1.05,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final it = items[index];
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 220, // prevents stretching on large phones
                  maxHeight: 180,
                  minWidth: 160,
                  minHeight: 160,
                ),
                child: _AttendanceCard(
                  title: it['title'] as String,
                  percent: it['percent'] as double,
                  label: it['label'] as String,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _AttendanceCard extends StatelessWidget {
  final String title;
  final double percent;
  final String label;

  const _AttendanceCard({
    required this.title,
    required this.percent,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          colors: [Color(0xFF0E2A43), Color(0xFF0F2F3F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _CircularPercent(value: percent, label: label),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Education',
                      style: TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: percent,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF0A74DA),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircularPercent extends StatelessWidget {
  final double value;
  final String label;
  const _CircularPercent({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56,
      height: 56,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.rotate(
            angle: -math.pi / 2,
            child: CircularProgressIndicator(
              value: value,
              strokeWidth: 5,
              backgroundColor: Colors.white12,
              valueColor: const AlwaysStoppedAnimation(Color(0xFF3DE7C9)),
            ),
          ),
          Text(
            (value * 100).round().toString() + '%',
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _NotesCard extends StatelessWidget {
  const _NotesCard({super.key});

  @override
  Widget build(BuildContext context) {
    // MODIFICATION: Set a fixed width for the Notes card (e.g., 400) or let it size
    // naturally with the ConstrainedBox. We use Center to respect the original constraints.
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 210),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFE082),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Notes / Reminders',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 12),
              Text(
                '• Remember to buy textbook Education',
                style: TextStyle(fontSize: 13, color: Colors.black),
              ),
              SizedBox(height: 6),
              Text(
                '• Submit project idea by Friday',
                style: TextStyle(fontSize: 13, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DeadlinesCard extends StatelessWidget {
  const _DeadlinesCard({super.key});

  @override
  Widget build(BuildContext context) {
    // MODIFICATION: Fixed width to 250 using SizedBox, respecting the max height.
    return SizedBox(
      width: 250,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 250),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFF6E57D6),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black45,
                blurRadius: 18,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Upcoming Deadlines',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                SizedBox(height: 12),
                _DeadlineItem(
                  title: 'Assignment 2: Due Oct 10',
                  subtitle: '(Curriculum & Pedagogy)',
                ),
                _DeadlineItem(
                  title: 'Mid-Term Exam: Oct 18',
                  subtitle: '(Indian Education)',
                ),
                _DeadlineItem(
                  title: 'Project Proposal: Due Oct 25',
                  subtitle: '(Digital Skills)',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DeadlineItem extends StatelessWidget {
  final String title;
  final String subtitle;
  const _DeadlineItem({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 8, color: Colors.white70),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
