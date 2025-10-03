import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // ✅ add this

// 3. FACULTY DATA PAGE
class FacultyDataPage extends StatelessWidget {
  final Function(String, Color) onAction;
  const FacultyDataPage({required this.onAction, super.key});

  final List<Map<String, String>> mockFaculty = const [
    {
      'name': 'Dr. S. Kumar',
      'dept': 'CSE',
      'courses': '3',
      'workload': '12',
      'avail': 'M-F',
    },
    {
      'name': 'Prof. M. Patel',
      'dept': 'Physics',
      'courses': '2',
      'workload': '10',
      'avail': 'T, Th',
    },
    {
      'name': 'Ms. A. Sharma',
      'dept': 'EE',
      'courses': '4',
      'workload': '16',
      'avail': 'All',
    },
  ];

  final Color cardBgColor = const Color(0xFF1F2633);

  Future<void> _importFromFile(BuildContext context) async {
    // Open file picker
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv', 'xlsx', 'json'], // you can change
    );

    if (result != null && result.files.isNotEmpty) {
      String fileName = result.files.single.name;
      onAction("Imported file: $fileName", Colors.green);
      // TODO: Parse the file content and update faculty list
    } else {
      onAction("Import cancelled", Colors.orange);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- HEADER ROW WITH IMPORT BUTTON ---
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Faculty Data Management',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            FilledButton.icon(
              onPressed: () => _importFromFile(context),
              icon: const Icon(Icons.file_upload_outlined),
              label: const Text('Import'),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 20,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // --- SEARCH + SORT ROW ---
        Row(
          children: [
            Expanded(
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Search Faculty',
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            FilledButton.icon(
              onPressed: () =>
                  onAction('Sorting faculty data...', Colors.indigo),
              icon: const Icon(Icons.sort_rounded),
              label: const Text('Sort'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20,
                ),
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // --- FACULTY TABLE ---
        Card(
          color: cardBgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingTextStyle: const TextStyle(color: Colors.white70),
              dataTextStyle: const TextStyle(color: Colors.white),
              columns: const [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Department')),
                DataColumn(label: Text('Courses Assigned')),
                DataColumn(
                  label: Text('Workload (Hrs)', textAlign: TextAlign.right),
                  numeric: true,
                ),
                DataColumn(label: Text('Availability')),
                DataColumn(label: Text('Actions')),
              ],
              rows: mockFaculty.map((faculty) {
                return DataRow(
                  cells: [
                    DataCell(Text(faculty['name']!)),
                    DataCell(Text(faculty['dept']!)),
                    DataCell(Text(faculty['courses']!)),
                    DataCell(
                      Text(faculty['workload']!, textAlign: TextAlign.right),
                    ),
                    DataCell(Text(faculty['avail']!)),
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, size: 20),
                            color: Colors.indigo,
                            onPressed: () => onAction(
                              'Edit ${faculty['name']}',
                              Colors.indigo,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, size: 20),
                            color: Colors.red,
                            onPressed: () => onAction(
                              'Delete ${faculty['name']}',
                              Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
