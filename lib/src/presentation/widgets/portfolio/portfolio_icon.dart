import 'package:flutter/material.dart';

/// Resolves a [PortfolioItemModel.iconKey] to its Flutter icon. The domain
/// layer stores the key as a plain string to stay framework-free; this is
/// the one place that maps it to an actual [IconData], shared by Home's
/// portfolio carousel and the full Portfolio screen's grid.
IconData portfolioIconFor(String key) {
  switch (key) {
    case 'account_balance_wallet_outlined':
      return Icons.account_balance_wallet_rounded;
    case 'storefront_outlined':
      return Icons.storefront_rounded;
    case 'delivery_dining_outlined':
      return Icons.delivery_dining_rounded;
    case 'account_balance_outlined':
      return Icons.account_balance_rounded;
    case 'payments_outlined':
      return Icons.payments_rounded;
    case 'savings_outlined':
      return Icons.savings_rounded;
    case 'restaurant_outlined':
      return Icons.restaurant_rounded;
    case 'fastfood_outlined':
      return Icons.fastfood_rounded;
    case 'business_outlined':
      return Icons.business_rounded;
    case 'directions_car_outlined':
      return Icons.directions_car_rounded;
    case 'shopping_bag_outlined':
      return Icons.shopping_bag_rounded;
    default:
      return Icons.apps_rounded;
  }
}
