import 'package:flutter/material.dart';

// 📊 DASHBOARD PAGE
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

  final Color cardBgColor = const Color(0xFF1F2633);

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
        };
      case 'In Progress':
        return {'color': Colors.orangeAccent, 'icon': Icons.cached_rounded};
      case 'Completed':
        return {
          'color': Colors.greenAccent,
          'icon': Icons.check_circle_rounded,
        };
      default:
        return {'color': Colors.grey, 'icon': Icons.info_outline_rounded};
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 700;

    // 🔠 Responsive font sizes
    final double mainTitleSize = isMobile ? 22 : 30;
    final double sectionTitleSize = isMobile ? 18 : 22;
    final double smallText = isMobile ? 12 : 14;
    final double valueText = isMobile ? 18 : 22;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Dashboard Title ---
          Text(
            'Dashboard Overview',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: mainTitleSize,
            ),
          ),
          const SizedBox(height: 14),

          // --- Overview Stats Grid ---
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount;
              double aspectRatio;

              if (isMobile) {
                crossAxisCount = 2;
                aspectRatio = 5 / 3;
              } else {
                crossAxisCount = (constraints.maxWidth / 260).floor().clamp(
                  2,
                  4,
                );
                aspectRatio = 2.2;
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: aspectRatio,
                ),
                itemCount: _stats.length,
                itemBuilder: (context, index) {
                  final stat = _stats[index];
                  return Card(
                    color: cardBgColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () => widget.onAction(
                        'Tapped on ${stat['title']}',
                        Colors.indigo,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // --- Title ---
                            Text(
                              stat['title'],
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: smallText,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),

                            // --- Value + Icon ---
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  stat['value'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: valueText,
                                    color: Colors.white,
                                  ),
                                ),
                                Icon(
                                  stat['icon'],
                                  size: isMobile ? 26 : 32,
                                  color: const Color(0xFF0A74DA),
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

          const SizedBox(height: 30),

          // --- Assignments Header ---
          Text(
            'Pending Assignments & Tasks',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: sectionTitleSize,
            ),
          ),
          const SizedBox(height: 10),

          // --- Search Bar ---
          Padding(
            padding: const EdgeInsets.only(bottom: 18.0),
            child: TextFormField(
              controller: _searchController,
              style: TextStyle(color: Colors.white, fontSize: smallText + 1),
              decoration: InputDecoration(
                labelText: 'Search Assignments...',
                labelStyle: TextStyle(
                  color: Colors.white70,
                  fontSize: smallText + 1,
                ),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: Colors.white70,
                  size: isMobile ? 20 : 22,
                ),
                filled: true,
                fillColor: const Color(0xFF2A2F3A),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
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
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 1.9,
                ),
                itemCount: _filteredAssignments.length,
                itemBuilder: (context, index) {
                  final assignment = _filteredAssignments[index];
                  final visuals = _getStatusVisuals(assignment['status']);

                  return Card(
                    color: const Color(0xFF2A2F3A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () => widget.onAction(
                        'Viewing: ${assignment['title']}',
                        Colors.indigo,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
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
                                      fontSize: smallText + 1,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Icon(
                                  visuals['icon'],
                                  color: visuals['color'],
                                  size: isMobile ? 18 : 22,
                                ),
                              ],
                            ),
                            Text(
                              'Due: ${assignment['dueDate']}',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: smallText,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Chip(
                                  label: Text(
                                    assignment['status'],
                                    style: TextStyle(
                                      fontSize: smallText,
                                      fontWeight: FontWeight.bold,
                                      color: visuals['color'],
                                    ),
                                  ),
                                  backgroundColor: visuals['color'].withOpacity(
                                    0.15,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.edit_rounded,
                                        color: const Color(0xFF0A74DA),
                                        size: isMobile ? 18 : 20,
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
                                        size: isMobile ? 18 : 20,
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
            const Padding(
              padding: EdgeInsets.all(32.0),
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
