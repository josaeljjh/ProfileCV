import 'package:equatable/equatable.dart';

/// Framework-agnostic portfolio entry. [iconKey] and [colorKey] are plain
/// string identifiers resolved to a Flutter IconData/Color only in the UI
/// layer (see home_page_content.dart) — the domain layer stays free of
/// Flutter imports.
class PortfolioItemModel extends Equatable {
  const PortfolioItemModel({
    required this.title,
    required this.iconKey,
    required this.colorKey,
  });

  final String title;
  final String iconKey;
  final String colorKey;

  @override
  List<Object?> get props => [title, iconKey, colorKey];
}
