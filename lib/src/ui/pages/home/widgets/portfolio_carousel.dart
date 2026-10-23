import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/resources/app_colors.dart';
import '../../../../config/resources/sizes.dart';
import '../../../../domain/models/portfolio_item_model.dart';
import '../../../../presentation/widgets/portfolio/portfolio_icon.dart';
import '../../../../presentation/widgets/text/generic_label.dart';

/// Horizontal preview of the portfolio on Home: an icon card with the
/// title below it, outside the card. Tapping a card opens the app's real
/// Play Store listing. The full Portfolio screen (reached via the
/// "Portfolio" section title) shows the same items with a different card
/// layout (title inside the card) - see
/// ui/pages/portfolio/widgets/portfolio_grid_item.dart.
class PortfolioCarousel extends StatelessWidget {
  const PortfolioCarousel({Key? key, required this.portfolio}) : super(key: key);

  final List<PortfolioItemModel> portfolio;

  static Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
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
                InkWell(
                  borderRadius: BorderRadius.circular(borderRadiusXL),
                  onTap: () => _open(item.url),
                  child: Container(
                    width: portfolioCardSize,
                    height: portfolioCardSize,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: colors.cardSurface,
                      borderRadius: BorderRadius.circular(borderRadiusXL),
                      border: Border.all(color: colors.divider),
                    ),
                    child: Icon(portfolioIconFor(item.iconKey), size: iconSizeLG, color: colors.iconMuted),
                  ),
                ),
                const SizedBox(height: paddingSM),
                GenericLabel(
                  label: item.title,
                  lines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: fontSize14, color: colors.textPrimary),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
