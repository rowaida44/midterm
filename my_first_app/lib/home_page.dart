import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tasks = [
      {"title": "Mathematics", "subtitle": "Homework due tomorrow", "icon": Icons.menu_book},
      {"title": "Physics", "subtitle": "Read Chapter 5", "icon": Icons.laptop},
      {"title": "Chemistry", "subtitle": "Lab report submission", "icon": Icons.science},
      {"title": "English", "subtitle": "Essay draft review", "icon": Icons.edit},
    ];

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 33, 198, 243),
        title: const Text("StudyMate"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Decorative background circles
          Positioned(top: 50, left: 30, child: Container(width: 50, height: 50, decoration: BoxDecoration(color: const Color.fromARGB(255, 187, 243, 251)?.withOpacity(0.3), shape: BoxShape.circle))),
          Positioned(bottom: 100, right: 40, child: Container(width: 80, height: 80, decoration: BoxDecoration(color: Colors.blue[200]?.withOpacity(0.3), shape: BoxShape.circle))),
          
          // Task cards
          Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  elevation: 4,
                  child: ListTile(
                    leading: Icon(tasks[index]["icon"], color: Colors.blue, size: 40),
                    title: Text(tasks[index]["title"], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    subtitle: Text(tasks[index]["subtitle"], style: const TextStyle(fontSize: 16, color: Colors.grey)),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                    onTap: () {},
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}