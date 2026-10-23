import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';

import '../../../config/resources/sizes.dart';
import '../../../core/resources/translations_constant.dart';
import '../../../presentation/widgets/feedback/error_view.dart';
import '../../../presentation/widgets/feedback/loading_view.dart';
import '../../../presentation/widgets/text/generic_label.dart';
import 'cubit/portfolio_cubit.dart';
import 'cubit/portfolio_ui_state.dart';
import 'widgets/portfolio_grid_item.dart';

/// "Portfolio" screen: the full list of apps/projects, reached by tapping
/// Home's "Portfolio" section title. Same plain-white card treatment as
/// the Home carousel, just laid out as a scrollable grid instead of a
/// horizontal strip since this is the "see everything" screen.
class PortfolioPageContent extends StatelessWidget {
  const PortfolioPageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // An explicit empty TextStyle forces GenericLabel to inherit the
      // ambient AppBar title style instead of its own (unsuitable) default.
      appBar: AppBar(title: GenericLabel(label: PORTFOLIO_TITLE.i18n(), style: const TextStyle())),
      body: BlocBuilder<PortfolioCubit, PortfolioUiState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const LoadingView();
          }
          if (state.hasError) {
            return ErrorView(
              message: ERROR_PORTFOLIO.i18n(),
              onRetry: () => context.read<PortfolioCubit>().loadData(),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(paddingXL),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: paddingMD,
              crossAxisSpacing: paddingMD,
              childAspectRatio: 1,
            ),
            itemCount: state.portfolio.length,
            itemBuilder: (context, index) => PortfolioGridItem(item: state.portfolio[index]),
          );
        },
      ),
    );
  }
}
