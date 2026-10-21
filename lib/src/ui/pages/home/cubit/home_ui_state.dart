import 'package:equatable/equatable.dart';

import '../../../../domain/models/experience_model.dart';
import '../../../../domain/models/portfolio_item_model.dart';
import '../../../../domain/models/profile_model.dart';

class HomeUiState extends Equatable {
  const HomeUiState({
    required this.isLoading,
    required this.hasError,
    required this.profile,
    required this.portfolio,
    required this.homeSkills,
    required this.experience,
  });

  factory HomeUiState.initial() => const HomeUiState(
        isLoading: true,
        hasError: false,
        profile: null,
        portfolio: [],
        homeSkills: [],
        experience: [],
      );

  final bool isLoading;
  final bool hasError;
  final ProfileModel? profile;
  final List<PortfolioItemModel> portfolio;
  final List<String> homeSkills;
  final List<CompanyExperienceModel> experience;

  HomeUiState copyWith({
    bool? isLoading,
    bool? hasError,
    ProfileModel? profile,
    List<PortfolioItemModel>? portfolio,
    List<String>? homeSkills,
    List<CompanyExperienceModel>? experience,
  }) {
    return HomeUiState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      profile: profile ?? this.profile,
      portfolio: portfolio ?? this.portfolio,
      homeSkills: homeSkills ?? this.homeSkills,
      experience: experience ?? this.experience,
    );
  }

  @override
  List<Object?> get props => [isLoading, hasError, profile, portfolio, homeSkills, experience];
}
