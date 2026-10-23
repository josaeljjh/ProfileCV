import 'package:flutter/material.dart';

import '../../../../config/resources/app_colors.dart';
import '../../../../config/resources/sizes.dart';
import '../../../../domain/models/portfolio_item_model.dart';
import '../../../../presentation/widgets/portfolio/portfolio_icon.dart';
import '../../../../presentation/widgets/text/generic_label.dart';

/// One card in the full Portfolio screen's grid: icon and title both
/// inside the bordered white card (unlike Home's carousel, where the
/// title sits below the card - see
/// ui/pages/home/widgets/portfolio_carousel.dart). Tapping it opens the
/// app's real Play Store listing via [onTap].
class PortfolioGridItem extends StatelessWidget {
  const PortfolioGridItem({Key? key, required this.item, required this.onTap}) : super(key: key);

  final PortfolioItemModel item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(borderRadiusXL),
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: colors.cardSurface,
          borderRadius: BorderRadius.circular(borderRadiusXL),
          border: Border.all(color: colors.divider),
        ),
        padding: const EdgeInsets.all(paddingMD),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(portfolioIconFor(item.iconKey), size: iconSizeLG, color: colors.iconMuted),
            const SizedBox(height: paddingSM),
            GenericLabel(
              label: item.title,
              lines: 2,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: fontSize14, color: colors.textPrimary),
            ),
          ],
        ),
      ),
    );
  }
}
