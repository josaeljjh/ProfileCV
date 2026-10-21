import 'package:flutter/material.dart';

import '../../../../config/resources/colors.dart';

/// "Skills" tab: list of skills/technologies.
class SkillsPage extends StatelessWidget {
  const SkillsPage({Key? key}) : super(key: key);

  static const List<String> _skills = [
    'Kotlin',
    'Flutter / Dart',
    'Android',
    'Clean Architecture',
    'REST APIs',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Skills')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _skills.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) => Card(
          child: ListTile(
            leading: const Icon(Icons.check_circle_outline, color: niagara),
            title: Text(_skills[index]),
          ),
        ),
      ),
    );
  }
}
