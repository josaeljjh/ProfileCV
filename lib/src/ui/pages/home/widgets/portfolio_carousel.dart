import 'package:flutter/material.dart';

import '../../../../config/resources/colors.dart';
import '../../../../config/resources/sizes.dart';
import '../../../../domain/models/portfolio_item_model.dart';
import '../../../../presentation/widgets/portfolio/portfolio_icon.dart';
import '../../../../presentation/widgets/text/generic_label.dart';

/// Horizontal preview of the portfolio on Home: an icon card with the
/// title below it, outside the card. The full Portfolio screen (reached
/// via the "Portfolio" section title) shows the same items with a
/// different card layout (title inside the card) - see
/// ui/pages/portfolio/widgets/portfolio_grid_item.dart.
class PortfolioCarousel extends StatelessWidget {
  const PortfolioCarousel({Key? key, required this.portfolio}) : super(key: key);

  final List<PortfolioItemModel> portfolio;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: portfolioCarouselHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: paddingXL),
        itemCount: portfolio.length,
        separatorBuilder: (_, __) => const SizedBox(width: paddingMD),
        itemBuilder: (context, index) {
          final item = portfolio[index];
          return SizedBox(
            width: portfolioCardSize,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: portfolioCardSize,
                  height: portfolioCardSize,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(borderRadiusXL),
                    border: Border.all(color: athensGray),
                  ),
                  child: Icon(portfolioIconFor(item.iconKey), size: iconSizeLG, color: carbon500),
                ),
                const SizedBox(height: paddingSM),
                GenericLabel(
                  label: item.title,
                  lines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: fontSize14, color: black),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
