import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class SettingsPage extends StatefulWidget {
  // const SettingsPage({super.key});
  final VoidCallback onSave;

  const SettingsPage({super.key, required this.onSave});

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  final TextEditingController _pioneerUrlController = TextEditingController();
  // Add more controllers for other buttons as needed

  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  Future<void> loadPreferences() async {
    final String response = await rootBundle.loadString('assets/config.json');
    final String ip = json.decode(response)['ip'] as String;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    setState(() {
      _pioneerUrlController.text = prefs.getString('ip_address') ?? ip;
      // Load other endpoints as needed
    });
  }

  Future<void> _savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('ip_address', _pioneerUrlController.text);
    widget.onSave(); // Notify the main page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _pioneerUrlController,
              decoration: const InputDecoration(labelText: 'Pioneer URL'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _savePreferences,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}