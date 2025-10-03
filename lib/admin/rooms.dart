import 'package:flutter/material.dart';

// 5. ROOM/LAB MANAGEMENT PAGE
class RoomLabManagementPage extends StatelessWidget {
  final Function(String, Color) onAction;
  const RoomLabManagementPage({required this.onAction, super.key});

  final List<Map<String, String>> mockRooms = const [
    {'name': 'C-101', 'capacity': '60', 'type': 'Theory', 'avail': 'Yes'},
    {'name': 'L-203', 'capacity': '30', 'type': 'Lab (CS)', 'avail': 'No'},
    {'name': 'R-005', 'capacity': '100', 'type': 'Auditorium', 'avail': 'Yes'},
    {'name': 'E-310', 'capacity': '45', 'type': 'Theory', 'avail': 'Yes'},
  ];

  @override
  Widget build(BuildContext context) {
    final Color cardBgColor = const Color(0xFF1F2633);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Room & Lab Management',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            FilledButton.icon(
              onPressed: () =>
                  onAction('Add new room dialog opened.', Colors.indigo),
              icon: const Icon(Icons.add),
              label: const Text('Add Room/Lab'),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Room Grid View
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = (constraints.maxWidth / 300).floor();
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount > 0 ? crossAxisCount : 1,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.5,
              ),
              itemCount: mockRooms.length,
              itemBuilder: (context, index) {
                final room = mockRooms[index];
                final isAvailable = room['avail'] == 'Yes';
                final Color statusColor = isAvailable
                    ? Colors.greenAccent
                    : Colors.redAccent;

                return Card(
                  elevation: 4,
                  color: cardBgColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
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
                            Text(
                              room['name']!,
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                            ),
                            Icon(
                              isAvailable
                                  ? Icons.check_circle_rounded
                                  : Icons.cancel_rounded,
                              color: statusColor,
                            ),
                          ],
                        ),
                        Text(
                          'Capacity: ${room['capacity']}',
                          style: const TextStyle(color: Colors.white70),
                        ),
                        Text(
                          'Type: ${room['type']}',
                          style: const TextStyle(color: Colors.white70),
                        ),
                        Text(
                          'Status: ${room['avail']}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: statusColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
