import 'package:flutter/material.dart';

import '../../../../config/resources/colors.dart';

class _PortfolioItem {
  const _PortfolioItem(this.title, this.icon, this.background);

  final String title;
  final IconData icon;
  final Color background;
}

class _ExperienceItem {
  const _ExperienceItem(this.company, this.role, this.period);

  final String company;
  final String role;
  final String period;
}

/// "Home" tab: CV summary inspired by the Figma "CV design for mobile" layout -
/// profile header, portfolio carousel, skills chips and experience list.
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const List<_PortfolioItem> _portfolio = [
    _PortfolioItem('Diseño de App', Icons.phone_iphone, iceberg),
    _PortfolioItem('Diseño Web', Icons.laptop_mac, edgeWater),
    _PortfolioItem('Ilustración', Icons.brush, dirtyPink300),
  ];

  static const List<String> _skills = [
    'UI/UX Design',
    'Interaction Design',
    'Prototyping',
    'User Research',
    'Visual Design',
    'Illustration',
  ];

  static const List<_ExperienceItem> _experience = [
    _ExperienceItem('Tech Innovators Inc.', 'Product Designer', '2021 - Presente'),
    _ExperienceItem('Creative Solutions Co.', 'UI/UX Designer', '2019 - 2021'),
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
      child: Column(
        children: [
          const CircleAvatar(
            radius: 60,
            backgroundColor: selago,
            child: Icon(Icons.person, size: 60, color: carbon500),
          ),
          const SizedBox(height: 16),
          const Text(
            'Tu Nombre',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: black),
          ),
          const SizedBox(height: 4),
          const Text(
            'Tu título profesional',
            style: TextStyle(fontSize: 15, color: slateGray),
          ),
          const Text(
            'Tu ciudad, país',
            style: TextStyle(fontSize: 15, color: slateGray),
          ),
        ],
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.company,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: black),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item.role,
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
              ))
          .toList(),
    );
  }
}
