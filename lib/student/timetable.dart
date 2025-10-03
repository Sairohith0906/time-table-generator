import 'package:flutter/material.dart';

class TimetableContent extends StatelessWidget {
  final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];
  final List<String> timeSlots = [
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
  ];

  final List<Map<String, dynamic>> classes = [
    {
      'day': 'Monday',
      'time': '9:00 AM',
      'title': 'Foundations of Education',
      'teacher': 'Dr. Roe',
      'color': Colors.blue,
    },
    {
      'day': 'Monday',
      'time': '11:00 AM',
      'title': 'Digital Skills',
      'teacher': 'Lee',
      'color': Colors.orange,
    },
    {
      'day': 'Tuesday',
      'time': '10:00 AM',
      'title': 'Curriculum & Pedagogy',
      'teacher': 'Dr. Anjel',
      'color': Colors.green,
    },
    {
      'day': 'Wednesday',
      'time': '1:00 PM',
      'title': 'Inclusive Education',
      'teacher': 'Dr. Alrik',
      'color': Colors.lightBlue,
    },
    {
      'day': 'Thursday',
      'time': '3:00 PM',
      'title': 'Teaching Practice',
      'teacher': 'Tyre',
      'color': Colors.greenAccent,
    },
    {
      'day': 'Friday',
      'time': '2:00 PM',
      'title': 'Environmental Ethics',
      'teacher': 'Dr. Viten',
      'color': Colors.purple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Table(
        border: TableBorder.all(color: Colors.white24),
        defaultColumnWidth: FixedColumnWidth(150),
        children: [
          TableRow(
            children: [
              _tableHeader("Day/Time"),
              ...timeSlots.map((t) => _tableHeader(t)).toList(),
            ],
          ),
          ...days.map((day) {
            return TableRow(
              children: [
                _tableHeader(day),
                ...timeSlots.map((time) {
                  Map<String, dynamic>? matchedClass;
                  try {
                    matchedClass = classes.firstWhere(
                      (c) => c['day'] == day && c['time'] == time,
                    );
                  } catch (e) {
                    matchedClass = null;
                  }
                  return Container(
                    height: 90,
                    decoration: BoxDecoration(
                      color: matchedClass?['color'] ?? Color(0xFF1F2633),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: matchedClass != null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                matchedClass['title'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 4),
                              Text(
                                matchedClass['teacher'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          )
                        : Center(
                            child: Text(
                              "Free",
                              style: TextStyle(
                                color: Colors.white38,
                                fontSize: 12,
                              ),
                            ),
                          ),
                  );
                }).toList(),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _tableHeader(String text) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Color(0xFF2A2F3F),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 13,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}