import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'timetable.dart';
import 'assignment.dart';
import 'announcement.dart';

class TimetableApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NEP 2020 Smart Timetabler',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF12161A),
        primaryColor: Color(0xFF0A74DA),
        textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Roboto'),
      ),
      home: DashboardPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String selectedMenu = 'Dashboard'; // Track selected sidebar item
  final sideWidth = 240.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            // Sidebar
            Container(
              width: sideWidth,
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: BoxDecoration(
                color: Color(0xFF15191D),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    offset: Offset(0, 6),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _LogoBlock(),
                  SizedBox(height: 24),
                  _buildSidebarItem(Icons.dashboard, 'Dashboard'),
                  _buildSidebarItem(Icons.event_note, 'My Timetable'),
                  _buildSidebarItem(Icons.assignment, 'Assignments / Exams'),
                  _buildSidebarItem(Icons.campaign, 'Announcements'),
                  Spacer(),
                  _buildSidebarItem(Icons.help_outline, 'Help & Support'),
                ],
              ),
            ),

            // Main content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TopBar(),
                  SizedBox(height: 28),

                  // Right side content changes based on selection
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: getRightContent(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebarItem(IconData icon, String title) {
    bool active = selectedMenu == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMenu = title;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: active ? Color(0xFF0A74DA) : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(8),
              child: Icon(
                icon,
                size: 18,
                color: active ? Colors.white : Colors.white70,
              ),
            ),
            SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                color: active ? Colors.white : Colors.white60,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getRightContent() {
    switch (selectedMenu) {
      case 'My Timetable':
        return TimetableContent();
      case 'Assignments / Exams':
        return Assignment();
      case 'Announcements':
        return Announcement();
      default:
        return DashboardContent();
    }
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
            gradient: LinearGradient(
              colors: [Color(0xFF10B3A6), Color(0xFF0A74DA)],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Icon(Icons.school, color: Colors.white, size: 22),
          ),
        ),
        SizedBox(width: 12),
        Flexible(
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

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: Color(0xFF1F2633),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "NEP 2020 SMART TIMETABLER",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Row(
            children: [
              Icon(Icons.notifications_none, color: Colors.white70),
              SizedBox(width: 16),
              CircleAvatar(child: Icon(Icons.person)),
              SizedBox(width: 8),
              Text("Priya Sharma", style: TextStyle(color: Colors.white70)),
            ],
          ),
        ],
      ),
    );
  }
}
