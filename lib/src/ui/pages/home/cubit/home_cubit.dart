import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../domain/usecases/get_experience_use_case.dart';
import '../../../../domain/usecases/get_home_skills_use_case.dart';
import '../../../../domain/usecases/get_portfolio_use_case.dart';
import '../../../../domain/usecases/get_profile_use_case.dart';
import 'home_ui_state.dart';

class HomeCubit extends Cubit<HomeUiState> {
  HomeCubit({
    required this.getProfileUseCase,
    required this.getPortfolioUseCase,
    required this.getHomeSkillsUseCase,
    required this.getExperienceUseCase,
  }) : super(HomeUiState.initial());

  final GetProfileUseCase getProfileUseCase;
  final GetPortfolioUseCase getPortfolioUseCase;
  final GetHomeSkillsUseCase getHomeSkillsUseCase;
  final GetExperienceUseCase getExperienceUseCase;

  Future<void> loadData() async {
    emit(state.copyWith(isLoading: true, hasError: false));

    final profileResult = await getProfileUseCase(params: const NoParams());
    final portfolioResult = await getPortfolioUseCase(params: const NoParams());
    final homeSkillsResult = await getHomeSkillsUseCase(params: const NoParams());
    final experienceResult = await getExperienceUseCase(params: const NoParams());

    if (profileResult is DataSuccess &&
        portfolioResult is DataSuccess &&
        homeSkillsResult is DataSuccess &&
        experienceResult is DataSuccess) {
      emit(state.copyWith(
        isLoading: false,
        hasError: false,
        profile: profileResult.data,
        portfolio: portfolioResult.data,
        homeSkills: homeSkillsResult.data,
        experience: experienceResult.data,
      ));
    } else {
      emit(state.copyWith(isLoading: false, hasError: true));
    }
  }
}
