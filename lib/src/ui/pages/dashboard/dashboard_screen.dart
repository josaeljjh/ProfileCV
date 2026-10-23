import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';

import '../../../config/di/service_locator.dart';
import '../../../core/resources/translations_constant.dart';
import '../contact/contact_page.dart';
import '../home/home_page.dart';
import '../portfolio/portfolio_page.dart';
import '../projects/projects_page.dart';
import '../skills/skills_page.dart';
import 'cubit/bottom_nav_cubit.dart';

/// Hosts the bottom navigation for the CV: Home, Portfolio, Skills,
/// Proyectos and Contacto. Mirrors PokeAppFlutter's DashBoardScreen
/// pattern: a BottomNavCubit drives the selected tab and a Material 3
/// NavigationBar replaces the old BottomNavigationBar/setState approach.
///
/// Unlike PokeAppFlutter's dashboard, each tab here keeps its own
/// BlocProvider (via HomePage/PortfolioPage/SkillsPage/ProjectsPage/
/// ContactPage) instead of having DashBoardScreen eagerly provide every
/// tab's cubit through a single MultiBlocProvider - simpler to keep each
/// tab self-contained than to restructure around one shared provider.
class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    return BlocProvider<BottomNavCubit>(
      create: (_) => sl.get<BottomNavCubit>(),
      child: const DashBoardScreen(),
    );
  }

  /// Tab indices, shared with Home's tappable "Portfolio"/"Skills" section
  /// titles so tapping them switches tabs in place via BottomNavCubit
  /// instead of pushing a new screen on top.
  static const int portfolioIndex = 1;
  static const int skillsIndex = 2;

  static const _pages = [
    HomePage(),
    PortfolioPage(),
    SkillsPage(),
    ProjectsPage(),
    ContactPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final index = context.watch<BottomNavCubit>().state;
    return Scaffold(
      body: IndexedStack(
        index: index,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (selected) =>
            context.read<BottomNavCubit>().updateIndex(selected),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_rounded),
            selectedIcon: const Icon(Icons.home_rounded),
            label: NAV_HOME.i18n(),
          ),
          NavigationDestination(
            icon: const Icon(Icons.apps_rounded),
            selectedIcon: const Icon(Icons.apps_rounded),
            label: NAV_PORTFOLIO.i18n(),
          ),
          NavigationDestination(
            icon: const Icon(Icons.star_rounded),
            selectedIcon: const Icon(Icons.star_rounded),
            label: NAV_SKILLS.i18n(),
          ),
          NavigationDestination(
            icon: const Icon(Icons.code_rounded),
            selectedIcon: const Icon(Icons.code_rounded),
            label: NAV_PROJECTS.i18n(),
          ),
          NavigationDestination(
            icon: const Icon(Icons.mail_rounded),
            selectedIcon: const Icon(Icons.mail_rounded),
            label: NAV_CONTACT.i18n(),
          ),
        ],
      ),
    );
  }
}
