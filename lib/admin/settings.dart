import 'package:flutter/material.dart';

// 8. SETTINGS PAGE
class SettingsPage extends StatefulWidget {
  final Function(String, Color) onAction;
  const SettingsPage({required this.onAction, super.key});

  @override
  State<SettingsPage> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false;
  String _adminName = 'Admin User';

  final Color cardBgColor = const Color(0xFF1F2633);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'System Settings & Profile',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        // Admin Profile Card
        Card(
          color: cardBgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Admin Profile',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  initialValue: _adminName,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: Icon(Icons.person_rounded, color: Colors.white),
                    labelStyle: TextStyle(color: Colors.white70),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                    ),
                  ),
                  onChanged: (value) => _adminName = value,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  initialValue: 'admin@timetable.com',
                  style: const TextStyle(color: Colors.white70),
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_rounded, color: Colors.white),
                    labelStyle: TextStyle(color: Colors.white70),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white30),
                    ),
                  ),
                  enabled: false,
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: () => widget.onAction(
                    'Profile for $_adminName saved!',
                    Colors.green,
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Save Profile Changes'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
        // System Configuration Card
        Card(
          color: cardBgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'System Configuration',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                ListTile(
                  title: const Text(
                    'Enable Dark Theme',
                    style: TextStyle(color: Colors.white70),
                  ),
                  trailing: Switch(
                    value: _isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        _isDarkMode = value;
                      });
                      widget.onAction(
                        'Theme set to ${value ? 'Dark' : 'Light'}',
                        Colors.teal,
                      );
                    },
                    activeColor: Colors.tealAccent,
                  ),
                ),
                const Divider(color: Colors.white24),
                ListTile(
                  title: const Text(
                    'Timetable Algorithm Version',
                    style: TextStyle(color: Colors.white70),
                  ),
                  subtitle: const Text(
                    'Current: v2.5 (Stable)',
                    style: TextStyle(color: Colors.white54),
                  ),
                  trailing: TextButton(
                    onPressed: () => widget.onAction(
                      'Algorithm updated to latest.',
                      Colors.indigo,
                    ),
                    child: const Text('Update'),
                  ),
                ),
                const Divider(color: Colors.white24),
                FilledButton.icon(
                  onPressed: () =>
                      widget.onAction('System settings saved.', Colors.green),
                  icon: const Icon(Icons.save_rounded),
                  label: const Text('Save System Settings'),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
