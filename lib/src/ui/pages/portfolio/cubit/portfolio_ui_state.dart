import 'package:equatable/equatable.dart';

import '../../../../domain/models/portfolio_item_model.dart';

class PortfolioUiState extends Equatable {
  const PortfolioUiState({
    required this.isLoading,
    required this.hasError,
    required this.portfolio,
  });

  factory PortfolioUiState.initial() => const PortfolioUiState(
        isLoading: true,
        hasError: false,
        portfolio: [],
      );

  final bool isLoading;
  final bool hasError;
  final List<PortfolioItemModel> portfolio;

  PortfolioUiState copyWith({
    bool? isLoading,
    bool? hasError,
    List<PortfolioItemModel>? portfolio,
  }) {
    return PortfolioUiState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      portfolio: portfolio ?? this.portfolio,
    );
  }

  @override
  List<Object?> get props => [isLoading, hasError, portfolio];
}
