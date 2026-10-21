import 'package:flutter/material.dart';

import '../../../../config/resources/colors.dart';

/// "Home" tab: profile summary (name, title, short bio).
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ProfileCV')),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 56,
                backgroundColor: selago,
                child: Icon(Icons.person, size: 56, color: carbon500),
              ),
              SizedBox(height: 16),
              Text(
                'Tu Nombre',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                'Tu título profesional',
                style: TextStyle(fontSize: 16, color: gray500),
              ),
              SizedBox(height: 16),
              Text(
                'Breve descripción sobre tu perfil profesional, experiencia '
                'y lo que te hace destacar.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: gray400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
