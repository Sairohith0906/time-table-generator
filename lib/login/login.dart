import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time_table/student/main.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter OTP Verification UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF12161A), // ✅ Dark BG
        primaryColor: const Color(0xFF0A74DA), // ✅ Accent Blue
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF0A74DA),
          secondary: Color(0xFF1F2633),
          surface: Color(0xFF1F2633),
          background: Color(0xFF12161A),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF1F2633), // ✅ Same card-like background
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          labelStyle: const TextStyle(color: Colors.white70),
          hintStyle: const TextStyle(color: Colors.white38),
          prefixIconColor: Colors.white60,
        ),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Color(0xFF1F2633),
          contentTextStyle: TextStyle(color: Colors.white),
        ),
      ),
      home: const OtpVerificationPage(),
    );
  }
}

// --- OTP Verification Page ---
class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message, Color color) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }

  Future<void> _handleOtpLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      FocusScope.of(context).unfocus();

      await Future.delayed(const Duration(seconds: 1));

      if (_otpController.text.length == 6) {
        _showSnackBar(
          'Verification successful. Logging in ${_emailController.text}!',
          Colors.blue,
        );
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => TimetableApp()));
      } else {
        _showSnackBar(
          'OTP verification failed. Please check the 6-digit code.',
          Colors.blue,
        );
      }
      setState(() => _isLoading = false);
    }
  }

  void _handleSendOtp() {
    FocusScope.of(context).unfocus();
    if (_emailController.text.isEmpty || !_emailController.text.contains('@')) {
      _showSnackBar('Please enter a valid email.', Colors.orange);
      return;
    }
    _showSnackBar('6-digit OTP sent to ${_emailController.text}', Colors.blue);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Title
                    Text(
                      'Verify Your Identity',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: size.height * 0.05),

                    // Email field
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Email ID',
                        hintText: 'user@example.com',
                        prefixIcon: Icon(Icons.email_rounded),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@') || !value.contains('.')) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Resend OTP
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: _isLoading ? null : _handleSendOtp,
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF0A74DA),
                        ),
                        child: const Text('Send/Resend OTP?'),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // OTP field
                    TextFormField(
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'OTP',
                        hintText: 'Enter 6-digit OTP',
                        prefixIcon: Icon(Icons.dialpad_rounded),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter OTP';
                        }
                        if (value.length != 6) {
                          return 'OTP must be 6 digits';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // Verify button
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleOtpLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0A74DA),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                ),
                              )
                            : const Text(
                                'Verify',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
