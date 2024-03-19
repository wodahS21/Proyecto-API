import 'package:flutter/material.dart';

class CardScreen extends StatelessWidget {
  final Card card;
  const CardScreen({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade600,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueGrey.shade900,
        title: Text('Centro Pokemon'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.admin_panel_settings_rounded),
              color: Colors.lightBlueAccent.shade400),
        ],
      ),
      body: Center(),
    );
  }
}
