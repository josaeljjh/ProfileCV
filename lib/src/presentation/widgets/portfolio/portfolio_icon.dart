import 'package:flutter/material.dart';

/// Resolves a [PortfolioItemModel.iconKey] to its Flutter icon. The domain
/// layer stores the key as a plain string to stay framework-free; this is
/// the one place that maps it to an actual [IconData], shared by Home's
/// portfolio carousel and the full Portfolio screen's grid.
IconData portfolioIconFor(String key) {
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
    case 'business_outlined':
      return Icons.business_outlined;
    case 'directions_car_outlined':
      return Icons.directions_car_outlined;
    case 'shopping_bag_outlined':
      return Icons.shopping_bag_outlined;
    default:
      return Icons.apps_outlined;
  }
}
