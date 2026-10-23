import 'package:equatable/equatable.dart';

/// Framework-agnostic portfolio entry. [iconKey] is a plain string
/// identifier resolved to a Flutter IconData only in the UI layer (see
/// home_page_content.dart / portfolio_page_content.dart) — the domain
/// layer stays free of Flutter imports. [url] is the app's real Play
/// Store listing (or store search, when there's no direct package id),
/// opened when the card is tapped.
class PortfolioItemModel extends Equatable {
  const PortfolioItemModel({
    required this.title,
    required this.iconKey,
    required this.url,
  });

  final String title;
  final String iconKey;
  final String url;

  @override
  List<Object?> get props => [title, iconKey, url];
}
