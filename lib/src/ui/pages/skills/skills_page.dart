import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/di/service_locator.dart';
import 'cubit/skills_cubit.dart';
import 'skills_page_content.dart';

class SkillsPage extends StatelessWidget {
  const SkillsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SkillsCubit>()..loadData(),
      child: const SkillsPageContent(),
    );
  }
}
