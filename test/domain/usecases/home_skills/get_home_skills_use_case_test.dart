import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:profile_cv/src/core/resources/data_state.dart';
import 'package:profile_cv/src/core/usecase/usecase.dart';
import 'package:profile_cv/src/domain/repositories/cv_repository.dart';
import 'package:profile_cv/src/domain/usecases/get_home_skills_use_case.dart';

class MockCvRepository extends Mock implements CvRepository {}

void main() {
  late MockCvRepository mockRepository;
  late GetHomeSkillsUseCase useCase;

  const skills = ['Flutter', 'Kotlin'];

  setUp(() {
    mockRepository = MockCvRepository();
    useCase = GetHomeSkillsUseCase(mockRepository);
  });

  test('calls repository.getHomeSkills and returns its success data', () async {
    when(() => mockRepository.getHomeSkills()).thenAnswer((_) async => const DataSuccess(skills));

    final result = await useCase(params: const NoParams());

    expect(result, isA<DataSuccess<List<String>>>());
    expect((result as DataSuccess<List<String>>).data, skills);
    verify(() => mockRepository.getHomeSkills()).called(1);
  });

  test('propagates DataError from the repository', () async {
    final error = Exception('failed');
    when(() => mockRepository.getHomeSkills()).thenAnswer((_) async => DataError(error));

    final result = await useCase(params: const NoParams());

    expect(result, isA<DataError<List<String>>>());
  });
}
