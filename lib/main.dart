import 'package:flutter/material.dart';
import 'login/login.dart'; // make sure the path matches your folder structure

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Time Table Generator',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.deepPurple, // you can change this accent
        colorScheme: ColorScheme.dark(
          primary: Colors.deepPurple,
          secondary: Colors.tealAccent,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[900],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      home: const LoginPage(),
    );
  }
}
