import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';

import '../../../config/resources/colors.dart';
import '../../../config/resources/sizes.dart';
import '../../../core/resources/translations_constant.dart';
import '../../../domain/models/experience_model.dart';
import '../../../domain/models/portfolio_item_model.dart';
import 'cubit/home_cubit.dart';
import 'cubit/home_ui_state.dart';

/// "Home" tab content: CV summary inspired by the Figma "CV design for
/// mobile" layout - profile header, portfolio carousel, skills chips and
/// experience list. Driven by [HomeCubit] / [HomeUiState].
class HomePageContent extends StatelessWidget {
  const HomePageContent({Key? key}) : super(key: key);

  static IconData _iconFor(String key) {
    switch (key) {
      case 'account_balance_wallet_outlined':
        return Icons.account_balance_wallet_outlined;
      case 'storefront_outlined':
        return Icons.storefront_outlined;
      case 'delivery_dining_outlined':
        return Icons.delivery_dining_outlined;
      case 'account_balance_outlined':
        return Icons.account_balance_outlined;
      case 'payments_outlined':
        return Icons.payments_outlined;
      case 'savings_outlined':
        return Icons.savings_outlined;
      case 'restaurant_outlined':
        return Icons.restaurant_outlined;
      case 'fastfood_outlined':
        return Icons.fastfood_outlined;
      default:
        return Icons.apps_outlined;
    }
  }

  static Color _colorFor(String key) {
    switch (key) {
      case 'iceberg':
        return iceberg;
      case 'edgeWater':
        return edgeWater;
      case 'dirtyPink300':
        return dirtyPink300;
      case 'soap400':
        return soap400;
      case 'lili300':
        return lili300;
      case 'polar':
        return polar;
      case 'auxAlert100':
        return auxAlert100;
      case 'soap300':
        return soap300;
      case 'black':
        return black;
      case 'butterflyBush':
        return butterflyBush;
      case 'carbon100':
        return carbon100;
      case 'secondary500':
        return secondary500;
      case 'carbon400':
        return carbon400;
      default:
        return athensGray;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          CV_TITLE.i18n(),
          style: const TextStyle(color: black, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeUiState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.hasError || state.profile == null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(ERROR_HOME.i18n()),
                  const SizedBox(height: paddingMD),
                  ElevatedButton(
                    onPressed: () => context.read<HomeCubit>().loadData(Localizations.localeOf(context)),
                    child: Text(ACTION_RETRY.i18n()),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: paddingXXL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileHeader(state),
                const SizedBox(height: paddingXXXL),
                _sectionTitle(SECTION_PORTFOLIO.i18n()),
                const SizedBox(height: paddingMD),
                _buildPortfolio(state.portfolio),
                const SizedBox(height: paddingXXXL),
                _sectionTitle(SECTION_SKILLS.i18n()),
                const SizedBox(height: paddingMD),
                _buildSkills(state.homeSkills),
                const SizedBox(height: paddingXXXL),
                _sectionTitle(SECTION_EXPERIENCE.i18n()),
                const SizedBox(height: paddingSM),
                _buildExperience(state.experience),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileHeader(HomeUiState state) {
    final profile = state.profile!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: paddingXXL),
        child: Column(
          children: [
            CircleAvatar(
              radius: avatarRadiusLG,
              backgroundColor: selago,
              backgroundImage: AssetImage(profile.avatarAsset),
            ),
            const SizedBox(height: paddingLG),
            Text(
              profile.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: fontSize22, fontWeight: FontWeight.bold, color: black),
            ),
            const SizedBox(height: paddingXS),
            Text(
              profile.title,
              style: const TextStyle(fontSize: fontSize15, color: slateGray),
            ),
            Text(
              profile.location,
              style: const TextStyle(fontSize: fontSize15, color: slateGray),
            ),
            const SizedBox(height: paddingLG),
            Text(
              profile.objective,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: fontSize13, color: gray400),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: paddingXL),
      child: Text(
        text,
        style: const TextStyle(fontSize: fontSize20, fontWeight: FontWeight.bold, color: black),
      ),
    );
  }

  Widget _buildPortfolio(List<PortfolioItemModel> portfolio) {
    return SizedBox(
      height: portfolioCarouselHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: paddingXL),
        itemCount: portfolio.length,
        separatorBuilder: (_, __) => const SizedBox(width: paddingMD),
        itemBuilder: (context, index) {
          final item = portfolio[index];
          return SizedBox(
            width: portfolioCardSize,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: portfolioCardSize,
                  height: portfolioCardSize,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _colorFor(item.colorKey),
                    borderRadius: BorderRadius.circular(borderRadiusXL),
                  ),
                  child: Icon(_iconFor(item.iconKey), size: iconSizeLG, color: carbon500),
                ),
                const SizedBox(height: paddingSM),
                Text(
                  item.title,
                  style: const TextStyle(fontSize: fontSize14, color: black),
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

  Widget _buildSkills(List<String> skills) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: paddingXL),
      child: Wrap(
        spacing: paddingSM + 2,
        runSpacing: paddingSM + 2,
        children: skills
            .map((skill) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: paddingLG, vertical: paddingMD),
                  decoration: BoxDecoration(
                    color: athensGray,
                    borderRadius: BorderRadius.circular(borderRadiusLG),
                  ),
                  child: Text(
                    skill,
                    style: const TextStyle(fontSize: fontSize14, color: black),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildExperience(List<CompanyExperienceModel> experience) {
    return Column(
      children: [
        for (int i = 0; i < experience.length; i++) ...[
          _buildCompanyBlock(experience[i]),
          if (i != experience.length - 1) const Divider(height: paddingXXXL, color: athensGray),
        ],
      ],
    );
  }

  Widget _logoBox(String initials, Color color) {
    final isDark = ThemeData.estimateBrightnessForColor(color) == Brightness.dark;
    return Container(
      width: iconSizeXL,
      height: iconSizeXL,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadiusSM),
      ),
      child: Text(
        initials,
        style: TextStyle(
          fontSize: fontSize13,
          fontWeight: FontWeight.bold,
          color: isDark ? white : black,
        ),
      ),
    );
  }

  Widget _buildCompanyBlock(CompanyExperienceModel exp) {
    // A single-role company collapses into one flat entry (logo + role +
    // company + dates), matching how LinkedIn displays it.
    if (exp.roles.length == 1) {
      final role = exp.roles.first;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: paddingXL),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _logoBox(exp.logoInitials, _colorFor(exp.logoColorKey)),
            const SizedBox(width: paddingMD),
            Expanded(child: _buildRoleDetails(role, exp.company)),
          ],
        ),
      );
    }

    // Multi-role company: header with logo/name/total duration, then a
    // dotted timeline of each role at that company.
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: paddingXL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _logoBox(exp.logoInitials, _colorFor(exp.logoColorKey)),
              const SizedBox(width: paddingMD),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exp.company,
                      style: const TextStyle(fontSize: fontSize16, fontWeight: FontWeight.bold, color: black),
                    ),
                    if (exp.totalDuration != null)
                      Text(
                        exp.totalDuration!,
                        style: const TextStyle(fontSize: fontSize13, color: slateGray),
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: paddingMD),
          for (int i = 0; i < exp.roles.length; i++)
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: iconSizeXL,
                    child: Column(
                      children: [
                        Container(
                          width: paddingSM,
                          height: paddingSM,
                          margin: const EdgeInsets.only(top: paddingXS + 2),
                          decoration: const BoxDecoration(color: gray200, shape: BoxShape.circle),
                        ),
                        if (i != exp.roles.length - 1)
                          const Expanded(child: VerticalDivider(width: 1, thickness: 1, color: athensGray)),
                      ],
                    ),
                  ),
                  const SizedBox(width: paddingMD),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: paddingLG),
                      child: _buildRoleDetails(exp.roles[i], null),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRoleDetails(RoleModel role, String? companyName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          role.title,
          style: const TextStyle(fontSize: fontSize15, fontWeight: FontWeight.bold, color: black),
        ),
        if (companyName != null)
          Text(
            companyName,
            style: const TextStyle(fontSize: fontSize13, color: slateGray),
          ),
        if (role.employmentType != null)
          Text(
            role.employmentType!,
            style: const TextStyle(fontSize: fontSize12, color: slateGray),
          ),
        Text(
          '${role.period} · ${role.duration}',
          style: const TextStyle(fontSize: fontSize12, color: gray400),
        ),
        if (role.skills.isNotEmpty) ...[
          const SizedBox(height: paddingXS),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.local_offer_outlined, size: iconSizeXS, color: slateGray),
              const SizedBox(width: paddingXS),
              Expanded(
                child: Text(
                  role.skills,
                  style: const TextStyle(fontSize: fontSize12, color: slateGray),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
