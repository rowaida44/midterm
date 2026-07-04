import 'package:flutter/material.dart';
import 'onboarding_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB3E5FC), Color(0xFFE1F5FE)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Main circle (الكتاب)
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.blue[200],
                  shape: BoxShape.circle,
                ),
              ),
              const Icon(Icons.menu_book, size: 80, color: Colors.blue),

              // Educational icons حول الدائرة
              Positioned(top: 0, left: 0, child: Icon(Icons.edit, size: 40, color: Colors.blue[400])),
              Positioned(top: 0, right: 0, child: Icon(Icons.laptop, size: 40, color: Colors.blue[400])),
              Positioned(bottom: 0, left: 0, child: Icon(Icons.school, size: 40, color: Colors.blue[400])),
              Positioned(bottom: 0, right: 0, child: Icon(Icons.cast_for_education, size: 40, color: Colors.blue[400])),

              // Text أسفل الدائرة
              Positioned(
                bottom: -120,
                child: Column(
                  children: const [
                    Text(
                      "Welcome to StudyMate",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Organize tasks easily",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
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