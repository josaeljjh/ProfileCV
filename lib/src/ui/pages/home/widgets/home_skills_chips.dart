import 'package:flutter/material.dart';

import '../../../../config/resources/app_colors.dart';
import '../../../../config/resources/sizes.dart';
import '../../../../presentation/widgets/text/generic_label.dart';

/// Quick skills preview chips shown on Home (the full, categorized list
/// lives on the Skills screen).
class HomeSkillsChips extends StatelessWidget {
  const HomeSkillsChips({Key? key, required this.skills}) : super(key: key);

  final List<String> skills;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: paddingXL),
      child: Wrap(
        spacing: paddingSM + 2,
        runSpacing: paddingSM + 2,
        children: skills
            .map((skill) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: paddingLG, vertical: paddingMD),
                  decoration: BoxDecoration(
                    color: colors.cardSurface,
                    borderRadius: BorderRadius.circular(borderRadiusLG),
                    border: Border.all(color: colors.divider),
                  ),
                  child: GenericLabel(
                    label: skill,
                    style: TextStyle(fontSize: fontSize14, color: colors.textPrimary),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
