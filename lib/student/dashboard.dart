import 'package:flutter/material.dart';
import 'dart:math' as math;

class DashboardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'My Course-wise Attendance',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 12),
        _AttendanceRow(),
        SizedBox(height: 36),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 1, child: _NotesCard()),
            SizedBox(width: 18),
            Expanded(flex: 1, child: _DeadlinesCard()),
          ],
        ),
      ],
    );
  }
}

class _AttendanceRow extends StatelessWidget {
  final items = const [
    {'title': 'Foundations & Education', 'percent': 0.72, 'label': '72%'},
    {'title': 'Curriculum & Pedagogy', 'percent': 0.80, 'label': '80%'},
    {'title': 'Indian Education', 'percent': 0.90, 'label': '90%'},
    {'title': 'Indian Education', 'percent': 0.60, 'label': '60%'},
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = (constraints.maxWidth - 36) / 4;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: items
                .map(
                  (it) => Container(
                    width: cardWidth,
                    height: 200,
                    margin: EdgeInsets.only(right: 12),
                    child: _AttendanceCard(
                      title: it['title'] as String,
                      percent: it['percent'] as double,
                      label: it['label'] as String,
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}

class _NotesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        child: Stack(
          children: [
            Positioned(
              left: 12,
              top: 12,
              right: 0,
              bottom: 0,
              child: Container(
                // decoration: BoxDecoration(
                //   color: Color(0xFF151719),
                //   borderRadius: BorderRadius.circular(8),
                //   // boxShadow: [
                //   //   BoxShadow(
                //   //     color: Colors.black54,
                //   //     blurRadius: 14,
                //   //     offset: Offset(0, 8),
                //   //   ),
                //   // ],
                // ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              width: 300,
              decoration: BoxDecoration(
                color: Color(0xFFFFE082),
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Notes / Reminders',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
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
          ],
        ),
      ),
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
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [Color(0xFF0E2A43), Color(0xFF0F2F3F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 12,
            offset: Offset(0, 8),
          ),
        ],
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                _CircularPercent(value: percent, label: label),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Education',
                        style: TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
                  color: Color(0xFF0A74DA),
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
      width: 64,
      height: 64,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.rotate(
            angle: -math.pi / 2,
            child: SizedBox(
              width: 64,
              height: 64,
              child: CircularProgressIndicator(
                value: value,
                strokeWidth: 6,
                backgroundColor: Colors.white12,
                valueColor: AlwaysStoppedAnimation(Color(0xFF3DE7C9)),
              ),
            ),
          ),
          Text(
            (value * 100).round().toString() + '%',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _DeadlinesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        width: 350,
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Color(0xFF6E57D6),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
                title: 'Project Proposal: Due 25',
                subtitle: '(Digital Skills)',
              ),
            ],
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
      padding: EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Icon(Icons.circle, size: 8, color: Colors.white70),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
