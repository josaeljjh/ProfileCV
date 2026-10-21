import 'dart:ui';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:profile_cv/src/core/resources/data_state.dart';
import 'package:profile_cv/src/core/usecase/usecase.dart';
import 'package:profile_cv/src/domain/models/project_model.dart';
import 'package:profile_cv/src/domain/usecases/get_projects_use_case.dart';
import 'package:profile_cv/src/ui/pages/projects/cubit/projects_cubit.dart';
import 'package:profile_cv/src/ui/pages/projects/cubit/projects_ui_state.dart';

class MockGetProjectsUseCase extends Mock implements GetProjectsUseCase {}

void main() {
  late MockGetProjectsUseCase mockUseCase;
  late ProjectsCubit cubit;

  const locale = Locale('es', 'ES');
  const projects = [
    ProjectModel(name: 'ProfileCV', description: 'Desc', tech: 'Flutter', url: 'https://example.com'),
  ];

  setUp(() {
    mockUseCase = MockGetProjectsUseCase();
    cubit = ProjectsCubit(getProjectsUseCase: mockUseCase);
  });

  tearDown(() => cubit.close());

  test('initial state is loading with no projects', () {
    expect(cubit.state.isLoading, true);
    expect(cubit.state.projects, isEmpty);
  });

  blocTest<ProjectsCubit, ProjectsUiState>(
    'emits loading then success with projects',
    build: () {
      when(() => mockUseCase(params: const LocaleParams(locale))).thenAnswer((_) async => const DataSuccess(projects));
      return cubit;
    },
    act: (cubit) => cubit.loadData(locale),
    expect: () => [
      isA<ProjectsUiState>().having((s) => s.isLoading, 'isLoading', true),
      isA<ProjectsUiState>()
          .having((s) => s.isLoading, 'isLoading', false)
          .having((s) => s.hasError, 'hasError', false)
          .having((s) => s.projects, 'projects', projects),
    ],
  );

  blocTest<ProjectsCubit, ProjectsUiState>(
    'emits loading then error when the use case fails',
    build: () {
      when(() => mockUseCase(params: const LocaleParams(locale))).thenAnswer((_) async => DataError(Exception('failed')));
      return cubit;
    },
    act: (cubit) => cubit.loadData(locale),
    expect: () => [
      isA<ProjectsUiState>().having((s) => s.isLoading, 'isLoading', true),
      isA<ProjectsUiState>().having((s) => s.hasError, 'hasError', true),
    ],
  );
}
