import 'package:flutter/material.dart';

// 6. TIMETABLE GENERATOR PAGE
class TimetableGeneratorPage extends StatelessWidget {
  final Function(String, Color) onAction;
  const TimetableGeneratorPage({required this.onAction, super.key});

  final Color cardBgColor = const Color(0xFF1F2633);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Timetable Generation Center',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        // Action Buttons Row
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            FilledButton.icon(
              onPressed: () =>
                  onAction('Importing student data...', Colors.indigo),
              icon: const Icon(Icons.file_upload_rounded),
              label: const Text('Upload/Import Data'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.all(16),
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
            ),
            FilledButton.icon(
              onPressed: () =>
                  onAction('Starting timetable generation...', Colors.green),
              icon: const Icon(Icons.schedule_send_rounded),
              label: const Text('Generate Timetable'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.all(16),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
            OutlinedButton.icon(
              onPressed: () =>
                  onAction('Checking for conflicts...', Colors.orange),
              icon: const Icon(Icons.gavel_rounded, color: Colors.orange),
              label: const Text('Conflict Check'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                foregroundColor: Colors.orange,
                side: const BorderSide(color: Colors.orange),
              ),
            ),
            OutlinedButton.icon(
              onPressed: () => onAction('Optimizing timetable...', Colors.blue),
              icon: const Icon(Icons.rocket_launch_rounded, color: Colors.blue),
              label: const Text('Optimize'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                foregroundColor: Colors.blue,
                side: const BorderSide(color: Colors.blue),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Text(
          'Timetable Preview (Calendar Style)',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        // Calendar Style Timetable Placeholder
        Card(
          color: cardBgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
          child: Container(
            height: 500,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            child: Text(
              'Placeholder for Interactive Calendar/Grid Timetable View',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
