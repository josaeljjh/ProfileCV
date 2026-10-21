import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';

import '../../../config/resources/sizes.dart';
import '../../../config/tools/locale_resolver.dart';
import '../../../core/resources/translations_constant.dart';
import '../../../presentation/widgets/feedback/error_view.dart';
import '../../../presentation/widgets/feedback/loading_view.dart';
import '../../../presentation/widgets/text/generic_label.dart';
import 'cubit/skills_cubit.dart';
import 'cubit/skills_ui_state.dart';
import 'widgets/skill_group_section.dart';

/// "Skills" tab content: technology skills grouped by area, from the CV.
class SkillsPageContent extends StatelessWidget {
  const SkillsPageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // An explicit empty TextStyle forces GenericLabel to inherit the
      // ambient AppBar title style instead of its own (unsuitable) default.
      appBar: AppBar(title: GenericLabel(label: SKILLS_TITLE.i18n(), style: const TextStyle())),
      body: BlocBuilder<SkillsCubit, SkillsUiState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const LoadingView();
          }
          if (state.hasError) {
            return ErrorView(
              message: ERROR_SKILLS.i18n(),
              onRetry: () => context.read<SkillsCubit>().loadData(resolveAppLocale()),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(paddingLG),
            children: state.skillGroups.map((group) => SkillGroupSection(group: group)).toList(),
          );
        },
      ),
    );
  }
}
