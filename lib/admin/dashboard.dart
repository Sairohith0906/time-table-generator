import 'package:flutter/material.dart';

// 1. DASHBOARD PAGE
class DashboardContent extends StatefulWidget {
  final Function(String, Color) onAction;
  const DashboardContent({required this.onAction, super.key});

  @override
  State<DashboardContent> createState() => DashboardContentState();
}

class DashboardContentState extends State<DashboardContent> {
  final List<Map<String, dynamic>> _stats = const [
    {
      'title': 'Total Students',
      'value': '1250',
      'icon': Icons.group_add_rounded,
    },
    {
      'title': 'Total Faculty',
      'value': '150',
      'icon': Icons.person_add_rounded,
    },
    {
      'title': 'Active Courses',
      'value': '85',
      'icon': Icons.local_library_rounded,
    },
    {
      'title': 'Rooms/Labs Available',
      'value': '42',
      'icon': Icons.house_rounded,
    },
    {
      'title': 'Timetables Generated',
      'value': '8',
      'icon': Icons.calendar_today_rounded,
    },
  ];

  final List<Map<String, dynamic>> _mockAssignments = const [
    {
      'title': 'Faculty Workload Input',
      'dueDate': '2025-10-15',
      'status': 'Pending',
    },
    {
      'title': 'Course Slotting',
      'dueDate': '2025-10-10',
      'status': 'In Progress',
    },
    {
      'title': 'Student Data Import',
      'dueDate': '2025-09-30',
      'status': 'Completed',
    },
    {
      'title': 'Room Conflict Review',
      'dueDate': '2025-10-20',
      'status': 'Pending',
    },
    {
      'title': 'Elective Mapping',
      'dueDate': '2025-10-18',
      'status': 'In Progress',
    },
    {
      'title': 'Final Timetable Check',
      'dueDate': '2025-10-25',
      'status': 'Pending',
    },
  ];

  List<Map<String, dynamic>> _filteredAssignments = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredAssignments = _mockAssignments;
    _searchController.addListener(_filterAssignments);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterAssignments);
    _searchController.dispose();
    super.dispose();
  }

  void _filterAssignments() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredAssignments = _mockAssignments;
      } else {
        _filteredAssignments = _mockAssignments
            .where(
              (assignment) =>
                  assignment['title'].toLowerCase().contains(query) ||
                  assignment['status'].toLowerCase().contains(query) ||
                  assignment['dueDate'].toLowerCase().contains(query),
            )
            .toList();
      }
    });
  }

  Map<String, dynamic> _getStatusVisuals(String status) {
    switch (status) {
      case 'Pending':
        return {
          'color': Colors.redAccent,
          'icon': Icons.pending_actions_rounded,
          'bgColor': Color(0xFF2A2F3A),
        };
      case 'In Progress':
        return {
          'color': Colors.orangeAccent,
          'icon': Icons.cached_rounded,
          'bgColor': Color(0xFF2A2F3A),
        };
      case 'Completed':
        return {
          'color': Colors.greenAccent,
          'icon': Icons.check_circle_rounded,
          'bgColor': Color(0xFF2A2F3A),
        };
      default:
        return {
          'color': Colors.grey,
          'icon': Icons.info_outline_rounded,
          'bgColor': Color(0xFF2A2F3A),
        };
    }
  }

  final Color cardBgColor = const Color(0xFF1F2633);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dashboard Overview',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),

          // --- Overview Stats Grid ---
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = (constraints.maxWidth / 250).floor().clamp(
                1,
                4,
              );
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 2.0,
                ),
                itemCount: _stats.length,
                itemBuilder: (context, index) {
                  final stat = _stats[index];
                  return Card(
                    color: cardBgColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => widget.onAction(
                        'Tapped on ${stat['title']}',
                        Colors.indigo,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  stat['title'],
                                  style: TextStyle(color: Colors.white70),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  stat['value'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              stat['icon'],
                              size: 40,
                              color: const Color(0xFF0A74DA),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),

          const SizedBox(height: 40),
          Text(
            'Pending Assignments & Tasks',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),

          // --- Search Bar ---
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: TextFormField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Search Assignments...',
                labelStyle: const TextStyle(color: Colors.white70),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: Colors.white70,
                ),
                filled: true,
                fillColor: const Color(0xFF2A2F3A),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // --- Assignments Grid ---
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = (constraints.maxWidth / 350).floor().clamp(
                1,
                3,
              );
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.8,
                ),
                itemCount: _filteredAssignments.length,
                itemBuilder: (context, index) {
                  final assignment = _filteredAssignments[index];
                  final visuals = _getStatusVisuals(assignment['status']);

                  return Card(
                    color: visuals['bgColor'],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => widget.onAction(
                        'Viewing: ${assignment['title']}',
                        Colors.indigo,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    assignment['title'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: visuals['color'],
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Icon(visuals['icon'], color: visuals['color']),
                              ],
                            ),
                            Text(
                              'Due: ${assignment['dueDate']}',
                              style: const TextStyle(color: Colors.white70),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Chip(
                                  label: Text(assignment['status']),
                                  backgroundColor: visuals['color'].withOpacity(
                                    0.15,
                                  ),
                                  labelStyle: TextStyle(
                                    color: visuals['color'],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.edit_rounded,
                                        color: const Color(0xFF0A74DA),
                                      ),
                                      onPressed: () => widget.onAction(
                                        'Editing: ${assignment['title']}',
                                        Colors.indigo,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.task_alt_rounded,
                                        color: Colors.greenAccent,
                                      ),
                                      onPressed: () => widget.onAction(
                                        'Marking complete: ${assignment['title']}',
                                        Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),

          if (_filteredAssignments.isEmpty)
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Center(
                child: Text(
                  'No assignments match your search.',
                  style: TextStyle(color: Colors.white38),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
