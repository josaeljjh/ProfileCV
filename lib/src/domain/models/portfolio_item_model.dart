import 'package:equatable/equatable.dart';

/// Framework-agnostic portfolio entry. [iconKey] is a plain string
/// identifier resolved to a Flutter IconData only in the UI layer (see
/// home_page_content.dart / portfolio_page_content.dart) — the domain
/// layer stays free of Flutter imports. Portfolio cards render on a plain
/// white background now, so there's no per-item color to carry here.
class PortfolioItemModel extends Equatable {
  const PortfolioItemModel({
    required this.title,
    required this.iconKey,
  });

  final String title;
  final String iconKey;

  @override
  List<Object?> get props => [title, iconKey];
}
