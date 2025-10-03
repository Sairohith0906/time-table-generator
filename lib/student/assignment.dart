// DashboardContent.dart
import 'package:flutter/material.dart';

class Assignment extends StatefulWidget {
  @override
  _AssignmentState createState() => _AssignmentState();
}

class _AssignmentState extends State<Assignment> {
  bool showUpcoming = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title + Toggle
        Row(
          children: [
            Text(
              "My Assignments & Exams",
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
                  _buildTab("Upcoming", showUpcoming),
                  _buildTab("Completed", !showUpcoming),
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
            childAspectRatio: 1.4, // ✅ keep same proportions as first version
            children: showUpcoming
                ? _buildUpcomingCards()
                : _buildCompletedCards(),
          ),
        ),
      ],
    );
  }

  Widget _buildTab(String label, bool active) {
    return GestureDetector(
      onTap: () {
        setState(() {
          showUpcoming = (label == "Upcoming");
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

  List<Widget> _buildUpcomingCards() {
    return [
      _AssignmentCard(
        title: "Assignment 2: Curriculum & Pedagogy",
        subtitle: "Curriculum & Peniaticary (FYUP)",
        status: "Pending Submission",
        due: "Fri, Oct 10, 2024 at 11:59 PM",
        buttonLabel: "Upload File",
        color: Colors.amber,
      ),
      _AssignmentCard(
        title: "Mid-Term Exam: Indian Education",
        subtitle: "FYED",
        status: "Not Started",
        due: "Mon, Oct 18, 2024 at 10:00 AM",
        buttonLabel: "Exam Guidelines",
        color: Colors.green,
      ),
    ];
  }

  List<Widget> _buildCompletedCards() {
    return [
      _AssignmentCard(
        title: "Quiz 1: Foundations & Education Education",
        subtitle: "BED",
        status: "Graded A-",
        due: "Sep 25, 2024",
        buttonLabel: "View Description",
        color: Colors.teal,
      ),
      _AssignmentCard(
        title: "Quiz 1: Foundations & Education Digital Skills",
        subtitle: "ITED",
        status: "Completed",
        due: "Sep 20, 2024",
        buttonLabel: "View Feedback",
        color: Colors.blueGrey,
      ),
    ];
  }
}

// ---------- Card Component ----------
class _AssignmentCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String status;
  final String due;
  final String buttonLabel;
  final Color color;

  const _AssignmentCard({
    required this.title,
    required this.subtitle,
    required this.status,
    required this.due,
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

          // Due date
          Text(
            "Due: $due",
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
