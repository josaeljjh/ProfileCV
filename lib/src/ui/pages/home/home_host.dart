import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../../../core/resources/translations_constant.dart';
import '../contact/contact_page.dart';
import '../projects/projects_page.dart';
import '../skills/skills_page.dart';
import 'home_page.dart';

/// Hosts the bottom navigation for the CV: Home, Skills, Proyectos and
/// Contacto. Mirrors the role PokeApp2's HomeHost plays for its own
/// bottom nav. Pure navigation shell — it has no data of its own, so it
/// gets no Cubit; each tab's own page/cubit handles its content.
class HomeHost extends StatefulWidget {
  const HomeHost({Key? key}) : super(key: key);

  static Widget create(BuildContext context) => const HomeHost();

  @override
  State<HomeHost> createState() => _HomeHostState();
}

class _HomeHostState extends State<HomeHost> {
  int _currentIndex = 0;

  final _pages = const [
    HomePage(),
    SkillsPage(),
    ProjectsPage(),
    ContactPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: NAV_HOME.i18n(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.star_outline),
            activeIcon: const Icon(Icons.star),
            label: NAV_SKILLS.i18n(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.code_outlined),
            activeIcon: const Icon(Icons.code),
            label: NAV_PROJECTS.i18n(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.mail_outline),
            activeIcon: const Icon(Icons.mail),
            label: NAV_CONTACT.i18n(),
          ),
        ],
      ),
    );
  }
}
