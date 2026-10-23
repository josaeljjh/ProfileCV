import 'package:flutter/material.dart';

import '../../../../config/resources/sizes.dart';
import '../../../../config/theme/app_theme.dart';
import '../../../../domain/models/portfolio_item_model.dart';
import '../../../../presentation/widgets/portfolio/portfolio_icon.dart';
import '../../../../presentation/widgets/text/generic_label.dart';

/// One card in the full Portfolio screen's grid: icon and title both
/// inside the bordered white card (unlike Home's carousel, where the
/// title sits below the card - see
/// ui/pages/home/widgets/portfolio_carousel.dart).
class PortfolioGridItem extends StatelessWidget {
  const PortfolioGridItem({Key? key, required this.item}) : super(key: key);

  final PortfolioItemModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(borderRadiusXL),
        border: Border.all(color: context.colors.border),
      ),
      padding: const EdgeInsets.all(paddingMD),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(portfolioIconFor(item.iconKey), size: iconSizeLG, color: context.colors.iconStrong),
          const SizedBox(height: paddingSM),
          GenericLabel(
            label: item.title,
            lines: 2,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: fontSize14, color: context.colors.textPrimary),
          ),
        ],
      ),
    );
  }
}
