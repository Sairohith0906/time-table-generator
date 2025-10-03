import 'package:flutter/material.dart';

class Announcement extends StatefulWidget {
  @override
  _AnnouncementState createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
  bool showRecent = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title + Toggle
        Row(
          children: [
            Text(
              "Announcements",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 16),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF1F2633),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  _buildTab("Recent", showRecent),
                  _buildTab("Past", !showRecent),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20),

        // Grid Layout
        Expanded(
          child: GridView.count(
            crossAxisCount: 4,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.4,
            children: showRecent
                ? _buildRecentAnnouncements()
                : _buildPastAnnouncements(),
          ),
        ),
      ],
    );
  }

  Widget _buildTab(String label, bool active) {
    return GestureDetector(
      onTap: () {
        setState(() {
          showRecent = (label == "Recent");
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: active ? Color(0xFF0A74DA) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: active ? Colors.white : Colors.white60,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildRecentAnnouncements() {
    return [
      _AnnouncementCard(
        title: "Holiday Notice",
        subtitle: "College will remain closed on Oct 12th",
        status: "New",
        date: "Oct 10, 2024",
        buttonLabel: "View Details",
        color: Colors.orange,
      ),
      _AnnouncementCard(
        title: "Workshop: AI in Education",
        subtitle: "Seminar Hall, Block A",
        status: "Upcoming",
        date: "Oct 15, 2024",
        buttonLabel: "Join Workshop",
        color: Colors.green,
      ),
    ];
  }

  List<Widget> _buildPastAnnouncements() {
    return [
      _AnnouncementCard(
        title: "Orientation Program",
        subtitle: "Successfully conducted",
        status: "Completed",
        date: "Sep 25, 2024",
        buttonLabel: "View Summary",
        color: Colors.blueGrey,
      ),
      _AnnouncementCard(
        title: "Guest Lecture: NEP 2020",
        subtitle: "Lecture by Dr. Sharma",
        status: "Archived",
        date: "Sep 20, 2024",
        buttonLabel: "Read Notes",
        color: Colors.teal,
      ),
    ];
  }
}

// ---------- Card Component ----------
class _AnnouncementCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String status;
  final String date;
  final String buttonLabel;
  final Color color;

  const _AnnouncementCard({
    required this.title,
    required this.subtitle,
    required this.status,
    required this.date,
    required this.buttonLabel,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1F2633), Color(0xFF15191D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.7), width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4),

          // Subtitle
          Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.white60)),
          SizedBox(height: 10),

          // Status pill
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: color.withOpacity(0.6), width: 1),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ),

          Spacer(),

          // Date
          Text(
            "Date: $date",
            style: TextStyle(fontSize: 12, color: Colors.white70),
          ),
          SizedBox(height: 10),

          // Action button
          SizedBox(
            width: double.infinity,
            height: 36,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: Text(
                buttonLabel,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
