import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

// Conditional import: web vs mobile/desktop
import 'download_mobile.dart' if (dart.library.html) 'download_web.dart';

class StudentDataPage extends StatelessWidget {
  final Function(String, Color) onAction;
  const StudentDataPage({required this.onAction, super.key});

  final List<Map<String, String>> mockStudents = const [
    {
      'name': 'Alice Johnson',
      'roll': 'B20CS001',
      'major': 'CSE',
      'minor': 'Physics',
      'credits': '22',
      'electives': 'AI',
    },
    {
      'name': 'Bob Williams',
      'roll': 'B20EE005',
      'major': 'EE',
      'minor': 'Maths',
      'credits': '24',
      'electives': 'Robotics',
    },
    {
      'name': 'Charlie Brown',
      'roll': 'B20ME010',
      'major': 'ME',
      'minor': 'Design',
      'credits': '20',
      'electives': 'Sociology',
    },
  ];

  final Color cardBgColor = const Color(0xFF1F2633);

  // CSV Template
  String get studentTemplateCsv =>
      "Name,Roll No,Major,Minor,Credits,Electives\n"
      "John Doe,B21CS001,CSE,Maths,20,AI\n"
      "Jane Smith,B21EE002,EE,Physics,22,Robotics\n";

  // Download Template
  Future<void> downloadStudentTemplate(BuildContext context) async {
    await saveFileToDownloads(
      context,
      "student_template.csv",
      studentTemplateCsv,
    );
  }

  Future<void> importStudentsFromFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv', 'xlsx', 'json'],
    );

    if (result != null && result.files.isNotEmpty) {
      String fileName = result.files.single.name;
      onAction("Imported file: $fileName", Colors.green);
      // TODO: Parse the file content and update student list
    } else {
      onAction("Import cancelled", Colors.orange);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Student Data Management',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    FilledButton.icon(
                      onPressed: () => importStudentsFromFile(context),
                      icon: const Icon(Icons.upload_file),
                      label: const Text('Import'),
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    FilledButton.icon(
                      onPressed: () => downloadStudentTemplate(context),
                      icon: const Icon(Icons.download),
                      label: const Text('Template'),
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            // SEARCH + FILTER
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Search Students',
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
                      onAction('Filtering students...', Colors.indigo),
                  icon: const Icon(Icons.filter_alt_rounded),
                  label: const Text('Filter'),
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

            // STUDENT DATA TABLE
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
                    DataColumn(label: Text('Roll No')),
                    DataColumn(label: Text('Major/Minor')),
                    DataColumn(
                      label: Text(
                        'Credits Enrolled',
                        textAlign: TextAlign.right,
                      ),
                      numeric: true,
                    ),
                    DataColumn(label: Text('Electives Chosen')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: mockStudents.map((student) {
                    return DataRow(
                      cells: [
                        DataCell(Text(student['name']!)),
                        DataCell(Text(student['roll']!)),
                        DataCell(
                          Text('${student['major']!}/${student['minor']!}'),
                        ),
                        DataCell(
                          Text(student['credits']!, textAlign: TextAlign.right),
                        ),
                        DataCell(Text(student['electives']!)),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, size: 20),
                                color: Colors.indigo,
                                onPressed: () => onAction(
                                  'Edit ${student['name']}',
                                  Colors.indigo,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, size: 20),
                                color: Colors.red,
                                onPressed: () => onAction(
                                  'Delete ${student['name']}',
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
        ),
      ),
    );
  }
}
