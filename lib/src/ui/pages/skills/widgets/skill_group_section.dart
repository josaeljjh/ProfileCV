import 'package:flutter/material.dart';

import '../../../../config/resources/app_colors.dart';
import '../../../../config/resources/sizes.dart';
import '../../../../domain/models/skill_group_model.dart';
import '../../../../presentation/widgets/skills/skill_icon.dart';
import '../../../../presentation/widgets/text/generic_label.dart';

/// One skill category and its chips (e.g. "Flutter / Dart" -> Flutter,
/// Bloc/Cubit, Dart, ...). Each chip shows an icon for that specific
/// technology (Android's robot, Flutter's dash, Apple's logo, ...)
/// instead of a generic checkmark.
class SkillGroupSection extends StatelessWidget {
  const SkillGroupSection({Key? key, required this.group}) : super(key: key);

  final SkillGroupModel group;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: paddingXL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GenericLabel(
            label: group.category,
            lines: null,
            softWrap: true,
            style: TextStyle(fontSize: fontSize17, fontWeight: FontWeight.bold, color: colors.textPrimary),
          ),
          const SizedBox(height: paddingSM + 2),
          Wrap(
            spacing: paddingSM + 2,
            runSpacing: paddingSM + 2,
            children: group.skills
                .map((skill) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: paddingMD + 2, vertical: paddingSM + 2),
                      decoration: BoxDecoration(
                        color: colors.cardSurface,
                        borderRadius: BorderRadius.circular(borderRadiusMD),
                        border: Border.all(color: colors.divider),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(skillIconFor(skill), size: iconSizeSM, color: colors.textSecondary),
                          const SizedBox(width: paddingSM - 2),
                          GenericLabel(
                            label: skill,
                            style: TextStyle(fontSize: fontSize13, color: colors.textPrimary),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
