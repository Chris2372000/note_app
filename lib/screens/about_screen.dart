import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Notes Manager",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            Text("Flutter Intermediate Project"),

            SizedBox(height: 10),

            Text("SQLite CRUD App"),

            SizedBox(height: 10),

            Text("Version 1.0"),

            SizedBox(height: 20),

            Text("Developed for DCLIC Training"),
          ],
        ),
      ),
    );
  }
}