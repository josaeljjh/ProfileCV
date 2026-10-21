import 'package:flutter/material.dart';

import '../../../../config/resources/colors.dart';
import '../../../../config/resources/sizes.dart';
import '../../../../domain/models/skill_group_model.dart';
import '../../../../presentation/widgets/text/generic_label.dart';

/// One skill category and its chips (e.g. "Flutter / Dart" -> Flutter,
/// Bloc/Cubit, Dart, ...).
class SkillGroupSection extends StatelessWidget {
  const SkillGroupSection({Key? key, required this.group}) : super(key: key);

  final SkillGroupModel group;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: paddingXL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GenericLabel(
            label: group.category,
            lines: null,
            softWrap: true,
            style: const TextStyle(fontSize: fontSize17, fontWeight: FontWeight.bold, color: black),
          ),
          const SizedBox(height: paddingSM + 2),
          Wrap(
            spacing: paddingSM + 2,
            runSpacing: paddingSM + 2,
            children: group.skills
                .map((skill) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: paddingMD + 2, vertical: paddingSM + 2),
                      decoration: BoxDecoration(
                        color: athensGray,
                        borderRadius: BorderRadius.circular(borderRadiusMD),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.check_circle_outline, size: iconSizeSM, color: niagara),
                          const SizedBox(width: paddingSM - 2),
                          GenericLabel(
                            label: skill,
                            style: const TextStyle(fontSize: fontSize13),
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
