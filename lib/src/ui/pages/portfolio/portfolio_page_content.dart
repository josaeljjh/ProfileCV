import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';

import '../../../config/resources/colors.dart';
import '../../../config/resources/sizes.dart';
import '../../../core/resources/translations_constant.dart';
import '../../../domain/models/portfolio_item_model.dart';
import 'cubit/portfolio_cubit.dart';
import 'cubit/portfolio_ui_state.dart';

/// "Portfolio" screen: the full list of apps/projects, reached by tapping
/// Home's "Portfolio" section title. Same plain-white card treatment as
/// the Home carousel, just laid out as a scrollable grid instead of a
/// horizontal strip since this is the "see everything" screen.
class PortfolioPageContent extends StatelessWidget {
  const PortfolioPageContent({Key? key}) : super(key: key);

  static IconData _iconFor(String key) {
    switch (key) {
      case 'account_balance_wallet_outlined':
        return Icons.account_balance_wallet_outlined;
      case 'storefront_outlined':
        return Icons.storefront_outlined;
      case 'delivery_dining_outlined':
        return Icons.delivery_dining_outlined;
      case 'account_balance_outlined':
        return Icons.account_balance_outlined;
      case 'payments_outlined':
        return Icons.payments_outlined;
      case 'savings_outlined':
        return Icons.savings_outlined;
      case 'restaurant_outlined':
        return Icons.restaurant_outlined;
      case 'fastfood_outlined':
        return Icons.fastfood_outlined;
      default:
        return Icons.apps_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(title: Text(PORTFOLIO_TITLE.i18n())),
      body: BlocBuilder<PortfolioCubit, PortfolioUiState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(ERROR_PORTFOLIO.i18n()),
                  const SizedBox(height: paddingMD),
                  ElevatedButton(
                    onPressed: () => context.read<PortfolioCubit>().loadData(),
                    child: Text(ACTION_RETRY.i18n()),
                  ),
                ],
              ),
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
            itemBuilder: (context, index) => _PortfolioCard(item: state.portfolio[index]),
          );
        },
      ),
    );
  }
}

class _PortfolioCard extends StatelessWidget {
  const _PortfolioCard({required this.item});

  final PortfolioItemModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(borderRadiusXL),
        border: Border.all(color: athensGray),
      ),
      padding: const EdgeInsets.all(paddingMD),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(PortfolioPageContent._iconFor(item.iconKey), size: iconSizeLG, color: carbon500),
          const SizedBox(height: paddingSM),
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: fontSize14, color: black),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
