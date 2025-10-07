import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time_table/admin/main.dart';
import 'package:time_table/student/dashboard.dart';
import 'package:time_table/student/main.dart';
import 'package:time_table/teacher/main.dart';

class OtpPage extends StatefulWidget {
  String role;
  OtpPage({super.key, required this.role});

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  Widget _buildOtpBox(int index) {
    return SizedBox(
      width: 60,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 22,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) {
          if (value.isNotEmpty && index < 3) {
            FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
          }
          if (value.isEmpty && index > 0) {
            FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
          }
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFF121212),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.tealAccent),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F), // dark background
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          width: 380,
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Enter OTP",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Enter the 4-digit code sent to your email.\nThis code is valid for the next 10 minutes.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[400], fontSize: 14),
              ),
              const SizedBox(height: 24),

              // OTP input boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) => _buildOtpBox(index)),
              ),
              const SizedBox(height: 28),

              // Reset password button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.lock, color: Colors.white),
                  label: const Text("Login", style: TextStyle(fontSize: 16)),
                  onPressed: () {
                    String otp = _controllers.map((c) => c.text).join();
                    print("Entered OTP: $otp");
                    // Role-based navigation
                    switch (widget.role) {
                      case "Admin":
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (_) => AdminDashboard(),
                          ), // ✅ wrap in MaterialPageRoute
                          (Route<dynamic> route) =>
                              false, // removes all previous routes
                        );

                        break;
                      case "Faculty":
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (_) => TeacherDashboard(),
                          ), // ✅ wrap in MaterialPageRoute
                          (Route<dynamic> route) =>
                              false, // removes all previous routes
                        );

                        break;
                      case "Student":
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (_) => StudentDashboard(),
                          ), // ✅ wrap in MaterialPageRoute
                          (Route<dynamic> route) =>
                              false, // removes all previous routes
                        );

                        break;
                      default:
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Invalid role")),
                        );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Resend code link
              RichText(
                text: TextSpan(
                  text: "Didn't get the code? ",
                  style: TextStyle(color: Colors.grey[400], fontSize: 14),
                  children: [
                    TextSpan(
                      text: "Resend code",
                      style: const TextStyle(
                        color: Colors.tealAccent,
                        fontWeight: FontWeight.bold,
                      ),
                      // Here you can wrap in a GestureRecognizer for tap
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
