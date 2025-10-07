import 'package:flutter/material.dart';

class Announcement extends StatefulWidget {
  @override
  _AnnouncementState createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
  bool showUpcoming = true;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title + Toggle
          Row(
            children: [
              const Text(
                "Announcements",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1F2633),
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
          const SizedBox(height: 20),

          // Scrollable Responsive Grid
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                double cardMaxWidth = 280; // max width per card
                return GridView.builder(
                  padding: const EdgeInsets.only(bottom: 16),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: cardMaxWidth,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    // Removed childAspectRatio so height can grow
                    mainAxisExtent: 250, // set minimum height for mobile
                  ),
                  itemCount: showUpcoming
                      ? _buildRecentAnnouncements().length
                      : _buildPastAnnouncements().length,
                  itemBuilder: (context, index) {
                    return showUpcoming
                        ? _buildRecentAnnouncements()[index]
                        : _buildPastAnnouncements()[index];
                  },
                );
              },
            ),
          ),
        ],
      ),
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
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF0A74DA) : Colors.transparent,
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
        due: "Oct 10, 2024",
        buttonLabel: "View Details",
        color: Colors.orange,
      ),
      _AnnouncementCard(
        title: "Workshop: AI in Education",
        subtitle: "Seminar Hall, Block A",
        status: "Upcoming",
        due: "Oct 15, 2024",
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
        due: "Sep 25, 2024",
        buttonLabel: "View Summary",
        color: Colors.blueGrey,
      ),
      _AnnouncementCard(
        title: "Guest Lecture: NEP 2020",
        subtitle: "Lecture by Dr. Sharma",
        status: "Archived",
        due: "Sep 20, 2024",
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
  final String due;
  final String buttonLabel;
  final Color color;

  const _AnnouncementCard({
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
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
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // no overflow
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 12, color: Colors.white60),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
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
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Due: $due",
                style: const TextStyle(fontSize: 12, color: Colors.white70),
              ),
              const SizedBox(height: 10),
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
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
