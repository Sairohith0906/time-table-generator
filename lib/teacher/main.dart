import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'timetable.dart';
import 'assignment.dart';
import 'announcement.dart';

// Define the different pages for navigation
enum PageType { dashboard, My_Timetable, Assignment, Announcements }

class TeacherDashboard extends StatelessWidget {
  const TeacherDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NEP 2020 Smart Timetabler',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF12161A),
        primaryColor: const Color(0xFF0A74DA),
        textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Roboto'),
      ),
      home: const DashboardLayout(),
    );
  }
}

// --- Dashboard Shell and Navigation ---

class DashboardLayout extends StatefulWidget {
  const DashboardLayout({super.key});

  @override
  State<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout> {
  PageType _currentPage = PageType.dashboard;

  final List<Map<String, dynamic>> _navItems = [
    {
      'title': 'Dashboard',
      'icon': Icons.dashboard_rounded,
      'page': PageType.dashboard,
    },
    {
      'title': 'My Timetable',
      'icon': Icons.group_rounded,
      'page': PageType.My_Timetable,
    },
    {
      'title': 'Assignment /Exams',
      'icon': Icons.people_alt_rounded,
      'page': PageType.Assignment,
    },
    {
      'title': 'Announcements',
      'icon': Icons.meeting_room_rounded,
      'page': PageType.Announcements,
    },
  ];

  /// Drawer (for mobile/tablet view)
  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFF15191D),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF0A74DA)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.school, color: Color(0xFF0A74DA), size: 30),
                ),
                SizedBox(height: 10),
                Text(
                  'NAVYUG UNIVERSITY',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  'NEP 2020 Timetabler',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          ..._navItems.map((item) {
            final isSelected = item['page'] == _currentPage;
            return ListTile(
              leading: Icon(
                item['icon'],
                color: isSelected ? Colors.blueAccent : Colors.white70,
              ),
              title: Text(
                item['title'],
                style: TextStyle(
                  color: isSelected ? Colors.blueAccent : Colors.white,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              selected: isSelected,
              selectedTileColor: Colors.blue.withOpacity(0.1),
              onTap: () {
                setState(() {
                  _currentPage = item['page'];
                });
                Navigator.pop(context); // Close drawer after tap
              },
            );
          }).toList(),
          const Divider(color: Colors.white24, height: 1),
          ListTile(
            leading: const Icon(Icons.help_outline, color: Colors.white70),
            title: const Text(
              'Help & Support',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  /// Sidebar (for large screen view)
  Widget _buildSidebar() {
    return Container(
      width: 240,
      color: const Color(0xFF15191D),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF0A74DA)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.school, color: Color(0xFF0A74DA), size: 30),
                ),
                SizedBox(height: 10),
                Text(
                  'NAVYUG UNIVERSITY',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  'NEP 2020 Timetabler',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: _navItems.map((item) {
                final isSelected = item['page'] == _currentPage;
                return ListTile(
                  leading: Icon(
                    item['icon'],
                    color: isSelected ? Colors.blueAccent : Colors.white70,
                  ),
                  title: Text(
                    item['title'],
                    style: TextStyle(
                      color: isSelected ? Colors.blueAccent : Colors.white,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  selected: isSelected,
                  selectedTileColor: Colors.blue.withOpacity(0.1),
                  onTap: () {
                    setState(() {
                      _currentPage = item['page'];
                    });
                  },
                );
              }).toList(),
            ),
          ),
          const Divider(color: Colors.white24, height: 1),
          ListTile(
            leading: const Icon(Icons.help_outline, color: Colors.white70),
            title: const Text(
              'Help & Support',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {},
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(bool isMobile) {
    String title =
        _navItems.firstWhere((item) => item['page'] == _currentPage)['title']
            as String;
    return AppBar(
      backgroundColor: const Color(0xFF1F2633),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      elevation: 2,
      actions: const [
        Icon(Icons.notifications_none, color: Colors.white70),
        SizedBox(width: 16),
        CircleAvatar(child: Icon(Icons.person)),
        SizedBox(width: 8),
        Center(
          child: Text("Priya Sharma", style: TextStyle(color: Colors.white70)),
        ),
        SizedBox(width: 16),
      ],
    );
  }

  Widget _getPageWidget() {
    switch (_currentPage) {
      case PageType.dashboard:
        return DashboardContent();
      case PageType.My_Timetable:
        return TimetableContent();
      case PageType.Assignment:
        return Assignment();
      case PageType.Announcements:
        return Announcement();
      default:
        return const Center(child: Text('Page not found'));
    }
  }

  void _showSnackBar(String message, Color color) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLargeScreen = constraints.maxWidth > 900;
        final isMobile = constraints.maxWidth < 600;

        if (isLargeScreen) {
          return Scaffold(
            appBar: _buildAppBar(isMobile),
            body: Row(
              children: [
                _buildSidebar(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: _getPageWidget(),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            appBar: _buildAppBar(isMobile),
            drawer: _buildDrawer(),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _getPageWidget(),
            ),
          );
        }
      },
    );
  }
}
