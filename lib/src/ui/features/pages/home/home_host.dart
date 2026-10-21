import 'package:flutter/material.dart';

import '../contact/contact_page.dart';
import '../skills/skills_page.dart';
import 'home_page.dart';

/// Hosts the bottom navigation for the CV: Home, Skills and Contact.
/// Mirrors the role PokeApp2's HomeHost plays for its own bottom nav.
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
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_outline),
            activeIcon: Icon(Icons.star),
            label: 'Skills',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail_outline),
            activeIcon: Icon(Icons.mail),
            label: 'Contacto',
          ),
        ],
      ),
    );
  }
}
