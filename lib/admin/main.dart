import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'student_data.dart';
import 'faculty_data.dart';
import 'course_management.dart';
import 'rooms.dart';
import 'timetable.dart';
import 'reports.dart';
import 'settings.dart';

// Define the different pages for navigation
enum PageType {
  dashboard,
  studentData,
  facultyData,
  courses,
  roomsLabs,
  timetableGenerator,
  reports,
  settings,
}

class TimetableDashboardApp extends StatelessWidget {
  const TimetableDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NEP 2020 Smart Timetabler',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF12161A),
        primaryColor: Color(0xFF0A74DA),
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
      'title': 'Student Data',
      'icon': Icons.group_rounded,
      'page': PageType.studentData,
    },
    {
      'title': 'Faculty Data',
      'icon': Icons.people_alt_rounded,
      'page': PageType.facultyData,
    },
    {'title': 'Courses', 'icon': Icons.book_rounded, 'page': PageType.courses},
    {
      'title': 'Rooms/Labs',
      'icon': Icons.meeting_room_rounded,
      'page': PageType.roomsLabs,
    },
    {
      'title': 'Timetable Generator',
      'icon': Icons.schedule_rounded,
      'page': PageType.timetableGenerator,
    },
    {
      'title': 'Reports',
      'icon': Icons.analytics_rounded,
      'page': PageType.reports,
    },
    {
      'title': 'Settings',
      'icon': Icons.settings_rounded,
      'page': PageType.settings,
    },
  ];

  // Sidebar
  Widget _buildSidebar(bool isPermanent) {
    return Container(
      color: Color(0xFF15191D),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          _LogoBlock(),
          const SizedBox(height: 24),
          ..._navItems.map((item) {
            final isSelected = item['page'] == _currentPage;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _currentPage = item['page'];
                  if (!isPermanent) Navigator.pop(context);
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isSelected ? Color(0xFF0A74DA) : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      item['icon'],
                      size: 18,
                      color: isSelected ? Colors.white : Colors.white70,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      item['title'],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.white60,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.all(8),
              child: Row(
                children: const [
                  Icon(Icons.help_outline, size: 18, color: Colors.white70),
                  SizedBox(width: 12),
                  Text(
                    'Help & Support',
                    style: TextStyle(color: Colors.white60, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // Top Bar
  PreferredSizeWidget _buildAppBar(bool isMobile) {
    String title =
        _navItems.firstWhere((item) => item['page'] == _currentPage)['title']
            as String;
    return AppBar(
      backgroundColor: Color(0xFF1F2633),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      elevation: 2,
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.white70),
          onPressed: () {},
        ),
        const SizedBox(width: 16),
        const CircleAvatar(child: Icon(Icons.person)),
        const SizedBox(width: 8),
        const Center(
          child: Text("Priya Sharma", style: TextStyle(color: Colors.white70)),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _getPageWidget() {
    switch (_currentPage) {
      case PageType.dashboard:
        return DashboardContent(onAction: _showSnackBar);
      case PageType.studentData:
        return StudentDataPage(onAction: _showSnackBar);
      case PageType.facultyData:
        return FacultyDataPage(onAction: _showSnackBar);
      case PageType.courses:
        return CourseManagementPage(onAction: _showSnackBar);
      case PageType.roomsLabs:
        return RoomLabManagementPage(onAction: _showSnackBar);
      case PageType.timetableGenerator:
        return TimetableGeneratorPage(onAction: _showSnackBar);
      case PageType.reports:
        return ReportsPage(onAction: _showSnackBar);
      case PageType.settings:
        return SettingsPage(onAction: _showSnackBar);
      default:
        return Center(child: Text('Page not found for $_currentPage'));
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
                Container(width: 240, child: _buildSidebar(true)),
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
            drawer: Drawer(child: _buildSidebar(false)),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: _getPageWidget(),
            ),
          );
        }
      },
    );
  }
}

// ---------- Shared Widgets ----------
class _LogoBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 44,
          width: 44,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF10B3A6), Color(0xFF0A74DA)],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Icon(Icons.school, color: Colors.white, size: 22),
          ),
        ),
        const SizedBox(width: 12),
        const Flexible(
          child: Text(
            'NAVYUG\nUNIVERSITY',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white70,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
