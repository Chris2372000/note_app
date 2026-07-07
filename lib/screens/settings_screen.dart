import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool darkMode = false;
  bool notifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [

          SwitchListTile(
            secondary: const Icon(Icons.dark_mode),
            title: const Text("Dark Mode"),
            value: darkMode,
            onChanged: (value) {
              setState(() {
                darkMode = value;
              });
            },
          ),

          SwitchListTile(
            secondary: const Icon(Icons.notifications),
            title: const Text("Notifications"),
            value: notifications,
            onChanged: (value) {
              setState(() {
                notifications = value;
              });
            },
          ),
        ],
      ),
    );
  }
}