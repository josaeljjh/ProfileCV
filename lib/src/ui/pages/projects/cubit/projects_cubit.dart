import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../domain/usecases/get_projects_use_case.dart';
import 'projects_ui_state.dart';

class ProjectsCubit extends Cubit<ProjectsUiState> {
  ProjectsCubit({required this.getProjectsUseCase}) : super(ProjectsUiState.initial());

  final GetProjectsUseCase getProjectsUseCase;

  Future<void> loadData() async {
    emit(state.copyWith(isLoading: true, hasError: false));

    final result = await getProjectsUseCase(params: const NoParams());

    if (result is DataSuccess) {
      emit(state.copyWith(isLoading: false, hasError: false, projects: result.data));
    } else {
      emit(state.copyWith(isLoading: false, hasError: true));
    }
  }
}
