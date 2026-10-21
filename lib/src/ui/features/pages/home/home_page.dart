import 'package:flutter/material.dart';

import '../../../../config/resources/colors.dart';

class _PortfolioItem {
  const _PortfolioItem(this.title, this.icon, this.background);

  final String title;
  final IconData icon;
  final Color background;
}

class _ExperienceItem {
  const _ExperienceItem(this.company, this.role, this.period, this.description);

  final String company;
  final String role;
  final String period;
  final String description;
}

/// "Home" tab: CV summary inspired by the Figma "CV design for mobile" layout -
/// profile header, portfolio carousel, skills chips and experience list.
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String name = 'Julio Josaél Hernández Peréz';
  static const String title = 'Senior Mobile Engineer';
  static const String location = 'El Salvador';
  static const String objective =
      'Ser parte de un equipo de trabajo y consolidarme profesionalmente en una '
      'empresa donde se reconozcan los logros personales y el desempeño, además '
      'de permitir oportunidades de desarrollo personal y profesional.';

  static const List<_PortfolioItem> _portfolio = [
    _PortfolioItem('N1CO App', Icons.account_balance_wallet_outlined, iceberg),
    _PortfolioItem('N1CO Business', Icons.storefront_outlined, edgeWater),
    _PortfolioItem('Hugo App', Icons.delivery_dining_outlined, dirtyPink300),
    _PortfolioItem('Scotiabank App', Icons.account_balance_outlined, soap400),
    _PortfolioItem('Pagalo App', Icons.payments_outlined, lili300),
    _PortfolioItem('AFP Confia', Icons.savings_outlined, polar),
    _PortfolioItem('Yummy App', Icons.restaurant_outlined, auxAlert100),
    _PortfolioItem('Gourmet Express', Icons.fastfood_outlined, soap300),
  ];

  static const List<String> _skills = [
    'Flutter',
    'Kotlin',
    'Swift',
    'Dart',
    'Clean Architecture',
    'Jetpack Compose',
  ];

  static const List<_ExperienceItem> _experience = [
    _ExperienceItem(
      'N1co Technologies',
      'Senior Flutter Engineer | Staff',
      '2025',
      'Liderazgo técnico de la app Business: flujos de pago del PDV '
          '(tap-to-pay, split payments), integración de métodos de pago y '
          'nuevo diseño Design 3.0.',
    ),
    _ExperienceItem(
      'N1co Technologies',
      'Senior Flutter Engineer | TechLead',
      '2024 - 2025',
      'Tech Lead. Flutter, Clean Architecture y liderazgo de equipo en '
          'desarrollo móvil.',
    ),
    _ExperienceItem(
      'N1co Technologies',
      'Senior Flutter Engineer',
      '2022 - 2023',
      'Desarrollo móvil Flutter y Bloc con Clean Architecture.',
    ),
    _ExperienceItem(
      'Hugo Technologies',
      'Senior Android Engineer',
      '2020 - 2022',
      'Desarrollo Android con Jetpack Compose y Clean Architecture.',
    ),
    _ExperienceItem(
      'Elanin',
      'Senior Android Developer',
      '2019 - 2020',
      '1 año en desarrollo de aplicaciones móviles Android.',
    ),
    _ExperienceItem(
      'Mobile SV',
      'Android Developer',
      '2016 - 2019',
      '3 años en desarrollo de aplicaciones móviles Android.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'CV',
          style: TextStyle(color: black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 28),
            _sectionTitle('Portfolio'),
            const SizedBox(height: 12),
            _buildPortfolio(),
            const SizedBox(height: 28),
            _sectionTitle('Skills'),
            const SizedBox(height: 12),
            _buildSkills(),
            const SizedBox(height: 28),
            _sectionTitle('Experiencia'),
            const SizedBox(height: 4),
            _buildExperience(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundColor: selago,
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
            const SizedBox(height: 16),
            const Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: black),
            ),
            const SizedBox(height: 4),
            const Text(
              title,
              style: TextStyle(fontSize: 15, color: slateGray),
            ),
            const Text(
              location,
              style: TextStyle(fontSize: 15, color: slateGray),
            ),
            const SizedBox(height: 16),
            const Text(
              objective,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: gray400),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        text,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: black),
      ),
    );
  }

  Widget _buildPortfolio() {
    return SizedBox(
      height: 190,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _portfolio.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = _portfolio[index];
          return SizedBox(
            width: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: item.background,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(item.icon, size: 40, color: carbon500),
                ),
                const SizedBox(height: 8),
                Text(
                  item.title,
                  style: const TextStyle(fontSize: 14, color: black),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSkills() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: _skills
            .map((skill) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: athensGray,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    skill,
                    style: const TextStyle(fontSize: 14, color: black),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildExperience() {
    return Column(
      children: _experience
          .map((item) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.role,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: black),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                item.company,
                                style: const TextStyle(fontSize: 14, color: slateGray),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          item.period,
                          style: const TextStyle(fontSize: 14, color: black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.description,
                      style: const TextStyle(fontSize: 13, color: gray400),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
