import 'package:flutter/material.dart';

// 7. REPORTS PAGE
class ReportsPage extends StatelessWidget {
  final Function(String, Color) onAction;
  const ReportsPage({required this.onAction, super.key});

  final List<String> mockReports = const [
    'Timetable V1 - Semester Fall 2024',
    'Conflict Report - Week 10',
    'Faculty Workload Summary',
    'Student Enrollment by Major',
  ];

  @override
  Widget build(BuildContext context) {
    final Color cardBgColor = const Color(0xFF1F2633);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reports & Export Center',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            FilledButton.icon(
              onPressed: () =>
                  onAction('Exporting reports to PDF...', Colors.red.shade700),
              icon: const Icon(Icons.picture_as_pdf_rounded),
              label: const Text('Export All to PDF'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.all(16),
                backgroundColor: Colors.red.shade700,
                foregroundColor: Colors.white,
              ),
            ),
            FilledButton.icon(
              onPressed: () => onAction(
                'Exporting reports to Excel...',
                Colors.green.shade700,
              ),
              icon: const Icon(Icons.table_chart_rounded),
              label: const Text('Export All to Excel'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.all(16),
                backgroundColor: Colors.green.shade700,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Text(
          'Generated Timetables & Reports',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        // Report List
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: mockReports.length,
          itemBuilder: (context, index) {
            final report = mockReports[index];
            return Card(
              color: cardBgColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: const Icon(
                  Icons.file_copy_rounded,
                  color: Color(0xFF0A74DA),
                ),
                title: Text(
                  report,
                  style: const TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  'Generated on: ${DateTime.now().subtract(Duration(days: index)).toString().substring(0, 10)}',
                  style: TextStyle(color: Colors.white70),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.download_rounded,
                        size: 20,
                        color: Colors.greenAccent,
                      ),
                      onPressed: () =>
                          onAction('Downloading $report', Colors.green),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.remove_red_eye_rounded,
                        size: 20,
                        color: Colors.orangeAccent,
                      ),
                      onPressed: () =>
                          onAction('Viewing $report', Colors.orange),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
