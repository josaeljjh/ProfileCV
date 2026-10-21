import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/di/service_locator.dart';
import 'cubit/portfolio_cubit.dart';
import 'portfolio_page_content.dart';

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PortfolioCubit>()..loadData(),
      child: const PortfolioPageContent(),
    );
  }
}
