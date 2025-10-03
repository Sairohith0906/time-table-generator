import 'package:flutter/material.dart';

// 4. COURSE MANAGEMENT PAGE
class CourseManagementPage extends StatelessWidget {
  final Function(String, Color) onAction;
  const CourseManagementPage({required this.onAction, super.key});

  final List<Map<String, String>> mockCourses = const [
    {
      'code': 'CS301',
      'title': 'Operating Systems',
      'credits': '4',
      'category': 'Major',
    },
    {
      'code': 'PH101',
      'title': 'Modern Physics',
      'credits': '3',
      'category': 'Minor',
    },
    {
      'code': 'SK001',
      'title': 'Data Analytics',
      'credits': '2',
      'category': 'Skill',
    },
    {
      'code': 'VA005',
      'title': 'Ethics in Tech',
      'credits': '1',
      'category': 'Value',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(
            16.0,
          ), // gives breathing space from top/side
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start, // forces top alignment
            children: [
              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Course Management',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF0A74DA),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => onAction(
                      'Add new course dialog opened.',
                      Colors.indigo,
                    ),
                    icon: const Icon(Icons.add),
                    label: const Text('Add Course'),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Course List using Cards
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: mockCourses.length,
                itemBuilder: (context, index) {
                  final course = mockCourses[index];
                  return Card(
                    color: const Color(0xFF1F2633), // Dark card color
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFF0A74DA),
                        child: Text(
                          course['code']![0],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(
                        '${course['title']} (${course['code']})',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        'Credits: ${course['credits']} | Category: ${course['category']}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              size: 20,
                              color: Colors.white70,
                            ),
                            onPressed: () =>
                                onAction('Edit ${course['code']}', Colors.grey),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              size: 20,
                              color: Colors.redAccent,
                            ),
                            onPressed: () => onAction(
                              'Delete ${course['code']}',
                              Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
