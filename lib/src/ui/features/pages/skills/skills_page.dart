import 'package:flutter/material.dart';

import '../../../../config/resources/colors.dart';

class _SkillGroup {
  const _SkillGroup(this.category, this.skills);

  final String category;
  final List<String> skills;
}

/// "Skills" tab: technology skills grouped by area, from the CV.
class SkillsPage extends StatelessWidget {
  const SkillsPage({Key? key}) : super(key: key);

  static const List<_SkillGroup> _groups = [
    _SkillGroup('Flutter / Dart', [
      'Senior Flutter Engineer',
      'Flutter Bloc/Cubit',
      'Dart',
      'Unit Test in Flutter with Mockito',
      'Dependency Injection',
    ]),
    _SkillGroup('Android / Kotlin', [
      'Senior Android Engineer',
      'Kotlin',
      'Jetpack Compose',
      'Coroutines/Flow',
      'Kotlin Multiplatform',
    ]),
    _SkillGroup('Arquitectura y herramientas', [
      'Clean Architecture',
      'Realm and Room',
      'IA con Claude Code',
    ]),
    _SkillGroup('iOS / Swift', [
      'Swift / SwiftUI',
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Skills')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: _groups
            .map((group) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        group.category,
                        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: black),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: group.skills
                            .map((skill) => Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: athensGray,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.check_circle_outline, size: 16, color: niagara),
                                      const SizedBox(width: 6),
                                      Text(skill, style: const TextStyle(fontSize: 13)),
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}
