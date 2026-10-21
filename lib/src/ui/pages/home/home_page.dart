import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/di/service_locator.dart';
import 'cubit/home_cubit.dart';
import 'home_page_content.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) => const HomePage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeCubit>()..loadData(Localizations.localeOf(context)),
      child: const HomePageContent(),
    );
  }
}
