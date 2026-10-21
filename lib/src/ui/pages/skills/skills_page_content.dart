import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';

import '../../../config/resources/colors.dart';
import '../../../config/resources/sizes.dart';
import '../../../config/tools/locale_resolver.dart';
import '../../../core/resources/translations_constant.dart';
import 'cubit/skills_cubit.dart';
import 'cubit/skills_ui_state.dart';

/// "Skills" tab content: technology skills grouped by area, from the CV.
class SkillsPageContent extends StatelessWidget {
  const SkillsPageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(SKILLS_TITLE.i18n())),
      body: BlocBuilder<SkillsCubit, SkillsUiState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(ERROR_SKILLS.i18n()),
                  const SizedBox(height: paddingMD),
                  ElevatedButton(
                    onPressed: () => context.read<SkillsCubit>().loadData(resolveAppLocale()),
                    child: Text(ACTION_RETRY.i18n()),
                  ),
                ],
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(paddingLG),
            children: state.skillGroups
                .map((group) => Padding(
                      padding: const EdgeInsets.only(bottom: paddingXL),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            group.category,
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
                                          Text(skill, style: const TextStyle(fontSize: fontSize13)),
                                        ],
                                      ),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}
