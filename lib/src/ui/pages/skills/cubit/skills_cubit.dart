import 'dart:ui' show Locale;

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../domain/usecases/get_skill_groups_use_case.dart';
import 'skills_ui_state.dart';

class SkillsCubit extends Cubit<SkillsUiState> {
  SkillsCubit({required this.getSkillGroupsUseCase}) : super(SkillsUiState.initial());

  final GetSkillGroupsUseCase getSkillGroupsUseCase;

  Future<void> loadData(Locale locale) async {
    emit(state.copyWith(isLoading: true, hasError: false));

    final result = await getSkillGroupsUseCase(params: LocaleParams(locale));

    if (result is DataSuccess) {
      emit(state.copyWith(isLoading: false, hasError: false, skillGroups: result.data));
    } else {
      emit(state.copyWith(isLoading: false, hasError: true));
    }
  }
}
