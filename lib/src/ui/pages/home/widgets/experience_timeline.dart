import 'package:flutter/material.dart';

import '../../../../config/resources/app_colors.dart';
import '../../../../config/resources/colors.dart';
import '../../../../config/resources/sizes.dart';
import '../../../../domain/models/experience_model.dart';
import '../../../../presentation/widgets/text/generic_label.dart';

Color _logoColorFor(String key) {
  switch (key) {
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

/// LinkedIn-style grouped work history: a multi-role company gets a header
/// (logo, name, total tenure) and a dotted timeline of its roles; a
/// single-role company collapses into one flat entry.
class ExperienceTimeline extends StatelessWidget {
  const ExperienceTimeline({Key? key, required this.experience}) : super(key: key);

  final List<CompanyExperienceModel> experience;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Column(
      children: [
        for (int i = 0; i < experience.length; i++) ...[
          _CompanyBlock(company: experience[i]),
          if (i != experience.length - 1) Divider(height: paddingXXXL, color: colors.divider),
        ],
      ],
    );
  }
}

class _LogoBox extends StatelessWidget {
  const _LogoBox({required this.initials, required this.colorKey, this.logoAsset});

  final String initials;
  final String colorKey;
  final String? logoAsset;

  @override
  Widget build(BuildContext context) {
    if (logoAsset != null) {
      final colors = AppColors.of(context);
      return Container(
        width: iconSizeXL,
        height: iconSizeXL,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadiusSM),
          border: Border.all(color: colors.divider),
        ),
        child: Image.asset(logoAsset!, fit: BoxFit.cover),
      );
    }

    final color = _logoColorFor(colorKey);
    final isDark = ThemeData.estimateBrightnessForColor(color) == Brightness.dark;
    return Container(
      width: iconSizeXL,
      height: iconSizeXL,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadiusSM),
      ),
      child: GenericLabel(
        label: initials,
        style: TextStyle(
          fontSize: fontSize13,
          fontWeight: FontWeight.bold,
          color: isDark ? white : black,
        ),
      ),
    );
  }
}

class _RoleDetails extends StatelessWidget {
  const _RoleDetails({required this.role, this.companyName});

  final RoleModel role;
  final String? companyName;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GenericLabel(
          label: role.title,
          lines: null,
          softWrap: true,
          style: TextStyle(fontSize: fontSize15, fontWeight: FontWeight.bold, color: colors.textPrimary),
        ),
        if (companyName != null)
          GenericLabel(
            label: companyName!,
            lines: null,
            softWrap: true,
            style: TextStyle(fontSize: fontSize13, color: colors.textSecondary),
          ),
        if (role.employmentType != null)
          GenericLabel(
            label: role.employmentType!,
            lines: null,
            softWrap: true,
            style: TextStyle(fontSize: fontSize12, color: colors.textSecondary),
          ),
        GenericLabel(
          label: '${role.period} · ${role.duration}',
          lines: null,
          softWrap: true,
          style: TextStyle(fontSize: fontSize12, color: colors.textTertiary),
        ),
        if (role.skills.isNotEmpty) ...[
          const SizedBox(height: paddingXS),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.local_offer_outlined, size: iconSizeXS, color: colors.textSecondary),
              const SizedBox(width: paddingXS),
              Expanded(
                child: GenericLabel(
                  label: role.skills,
                  lines: null,
                  softWrap: true,
                  style: TextStyle(fontSize: fontSize12, color: colors.textSecondary),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _CompanyBlock extends StatelessWidget {
  const _CompanyBlock({required this.company});

  final CompanyExperienceModel company;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    // A single-role company collapses into one flat entry (logo + role +
    // company + dates), matching how LinkedIn displays it.
    if (company.roles.length == 1) {
      final role = company.roles.first;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: paddingXL),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _LogoBox(initials: company.logoInitials, colorKey: company.logoColorKey, logoAsset: company.logoAsset),
            const SizedBox(width: paddingMD),
            Expanded(child: _RoleDetails(role: role, companyName: company.company)),
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
              _LogoBox(initials: company.logoInitials, colorKey: company.logoColorKey, logoAsset: company.logoAsset),
              const SizedBox(width: paddingMD),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GenericLabel(
                      label: company.company,
                      lines: null,
                      softWrap: true,
                      style: TextStyle(fontSize: fontSize16, fontWeight: FontWeight.bold, color: colors.textPrimary),
                    ),
                    if (company.totalDuration != null)
                      GenericLabel(
                        label: company.totalDuration!,
                        lines: null,
                        softWrap: true,
                        style: TextStyle(fontSize: fontSize13, color: colors.textSecondary),
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: paddingMD),
          for (int i = 0; i < company.roles.length; i++)
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
                        if (i != company.roles.length - 1)
                          Expanded(child: VerticalDivider(width: 1, thickness: 1, color: colors.divider)),
                      ],
                    ),
                  ),
                  const SizedBox(width: paddingMD),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: paddingLG),
                      child: _RoleDetails(role: company.roles[i]),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
