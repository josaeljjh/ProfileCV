import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:profile_cv/src/core/resources/data_state.dart';
import 'package:profile_cv/src/core/usecase/usecase.dart';
import 'package:profile_cv/src/domain/models/skill_group_model.dart';
import 'package:profile_cv/src/domain/repositories/cv_repository.dart';
import 'package:profile_cv/src/domain/usecases/get_skill_groups_use_case.dart';

class MockCvRepository extends Mock implements CvRepository {}

void main() {
  late MockCvRepository mockRepository;
  late GetSkillGroupsUseCase useCase;

  const groups = [
    SkillGroupModel(category: 'Flutter / Dart', skills: ['Flutter', 'Dart']),
  ];

  setUp(() {
    mockRepository = MockCvRepository();
    useCase = GetSkillGroupsUseCase(mockRepository);
  });

  test('calls repository.getSkillGroups and returns its success data', () async {
    when(() => mockRepository.getSkillGroups()).thenAnswer((_) async => const DataSuccess(groups));

    final result = await useCase(params: const NoParams());

    expect(result, isA<DataSuccess<List<SkillGroupModel>>>());
    expect((result as DataSuccess<List<SkillGroupModel>>).data, groups);
    verify(() => mockRepository.getSkillGroups()).called(1);
  });

  test('propagates DataError from the repository', () async {
    final error = Exception('failed');
    when(() => mockRepository.getSkillGroups()).thenAnswer((_) async => DataError(error));

    final result = await useCase(params: const NoParams());

    expect(result, isA<DataError<List<SkillGroupModel>>>());
  });
}
