import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:profile_cv/src/core/resources/data_state.dart';
import 'package:profile_cv/src/core/usecase/usecase.dart';
import 'package:profile_cv/src/domain/models/project_model.dart';
import 'package:profile_cv/src/domain/repositories/cv_repository.dart';
import 'package:profile_cv/src/domain/usecases/get_projects_use_case.dart';

class MockCvRepository extends Mock implements CvRepository {}

void main() {
  late MockCvRepository mockRepository;
  late GetProjectsUseCase useCase;

  const locale = Locale('es', 'ES');
  const projects = [
    ProjectModel(name: 'ProfileCV', description: 'Desc', tech: 'Flutter', url: 'https://example.com'),
  ];

  setUp(() {
    mockRepository = MockCvRepository();
    useCase = GetProjectsUseCase(mockRepository);
  });

  test('calls repository.getProjects with the given locale and returns its success data', () async {
    when(() => mockRepository.getProjects(locale)).thenAnswer((_) async => const DataSuccess(projects));

    final result = await useCase(params: const LocaleParams(locale));

    expect(result, isA<DataSuccess<List<ProjectModel>>>());
    expect((result as DataSuccess<List<ProjectModel>>).data, projects);
    verify(() => mockRepository.getProjects(locale)).called(1);
  });

  test('propagates DataError from the repository', () async {
    final error = Exception('failed');
    when(() => mockRepository.getProjects(locale)).thenAnswer((_) async => DataError(error));

    final result = await useCase(params: const LocaleParams(locale));

    expect(result, isA<DataError<List<ProjectModel>>>());
  });
}
