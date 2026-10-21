import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/resources/sizes.dart';
import '../../../config/tools/locale_resolver.dart';
import '../../../core/resources/translations_constant.dart';
import '../../../presentation/widgets/feedback/error_view.dart';
import '../../../presentation/widgets/feedback/loading_view.dart';
import '../../../presentation/widgets/text/generic_label.dart';
import 'cubit/projects_cubit.dart';
import 'cubit/projects_ui_state.dart';
import 'widgets/project_tile.dart';

/// "Proyectos" tab content: personal GitHub repositories.
class ProjectsPageContent extends StatelessWidget {
  const ProjectsPageContent({Key? key}) : super(key: key);

  static Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // An explicit empty TextStyle forces GenericLabel to inherit the
      // ambient AppBar title style instead of its own (unsuitable) default.
      appBar: AppBar(title: GenericLabel(label: PROJECTS_TITLE.i18n(), style: const TextStyle())),
      body: BlocBuilder<ProjectsCubit, ProjectsUiState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const LoadingView();
          }
          if (state.hasError) {
            return ErrorView(
              message: ERROR_PROJECTS.i18n(),
              onRetry: () => context.read<ProjectsCubit>().loadData(resolveAppLocale()),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(paddingLG),
            itemCount: state.projects.length,
            separatorBuilder: (_, __) => const SizedBox(height: paddingSM + 2),
            itemBuilder: (context, index) {
              final project = state.projects[index];
              return ProjectTile(project: project, onTap: () => _open(project.url));
            },
          );
        },
      ),
    );
  }
}
