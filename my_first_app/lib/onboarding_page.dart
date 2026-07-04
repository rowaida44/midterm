import 'package:flutter/material.dart';
import 'login_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final List<Map<String, dynamic>> slides = [
    {
      "title": "Welcome to StudyMate",
      "subtitle": "Plan smarter. Study better.",
      "icon": Icons.menu_book
    },
    {
      "title": "Track Your Tasks",
      "subtitle": "Add assignments and deadlines.",
      "icon": Icons.edit
    },
    {
      "title": "Stay Productive",
      "subtitle": "Never miss deadlines.",
      "icon": Icons.laptop
    },
  ];

  void _finish() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        itemCount: slides.length,
        onPageChanged: (index) => setState(() => currentIndex = index),
        itemBuilder: (context, index) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFB3E5FC), Color(0xFFE1F5FE)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              // Circle + main icon
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.blue[200],
                      shape: BoxShape.circle,
                    ),
                  ),
                  Image.asset(
  'assets/image.png',
  height: 200,
),
                  // Educational icons around circle
                  Positioned(top: -20, left: -30, child: Icon(Icons.edit, size: 30, color: Colors.blue[400])),
                  Positioned(top: -20, right: -30, child: Icon(Icons.laptop, size: 30, color: Colors.blue[400])),
                  Positioned(bottom: -20, left: -30, child: Icon(Icons.school, size: 30, color: Colors.blue[400])),
                  Positioned(bottom: -20, right: -30, child: Icon(Icons.cast_for_education, size: 30, color: Colors.blue[400])),
                ],
              ),
              // Text
              Positioned(
                bottom: 120,
                child: Column(
                  children: [
                    Text(slides[index]["title"],
                        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blue)),
                    const SizedBox(height: 10),
                    Text(slides[index]["subtitle"],
                        style: const TextStyle(fontSize: 16, color: Colors.grey), textAlign: TextAlign.center),
                  ],
                ),
              ),
              // Buttons
              Positioned(
                bottom: 40,
                left: 20,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(onPressed: _finish, child: const Text("Skip")),
                    ElevatedButton(
                      onPressed: () {
                        if (index == slides.length - 1) {
                          _finish();
                        } else {
                          _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
                        }
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                      child: Text(index == slides.length - 1 ? "Get Started" : "Next"),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}