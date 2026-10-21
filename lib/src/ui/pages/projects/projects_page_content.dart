import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/resources/colors.dart';
import '../../../config/resources/sizes.dart';
import '../../../core/resources/translations_constant.dart';
import 'cubit/projects_cubit.dart';
import 'cubit/projects_ui_state.dart';

/// "Proyectos" tab content: personal GitHub repositories.
class ProjectsPageContent extends StatelessWidget {
  const ProjectsPageContent({Key? key}) : super(key: key);

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(PROJECTS_TITLE.i18n())),
      body: BlocBuilder<ProjectsCubit, ProjectsUiState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(ERROR_PROJECTS.i18n()),
                  const SizedBox(height: paddingMD),
                  ElevatedButton(
                    onPressed: () => context.read<ProjectsCubit>().loadData(Localizations.localeOf(context)),
                    child: Text(ACTION_RETRY.i18n()),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(paddingLG),
            itemCount: state.projects.length,
            separatorBuilder: (_, __) => const SizedBox(height: paddingSM + 2),
            itemBuilder: (context, index) {
              final project = state.projects[index];
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.code, color: niagara),
                  title: Text(
                    project.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: paddingXS),
                      Text(project.description),
                      const SizedBox(height: paddingXS),
                      Text(
                        project.tech,
                        style: const TextStyle(fontSize: fontSize12, color: slateGray),
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.open_in_new, size: iconSizeMD, color: slateGray),
                  isThreeLine: true,
                  onTap: () => _open(project.url),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
