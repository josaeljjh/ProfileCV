import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/di/service_locator.dart';
import 'cubit/projects_cubit.dart';
import 'projects_page_content.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProjectsCubit>()..loadData(),
      child: const ProjectsPageContent(),
    );
  }
}
