import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:profile_cv/src/core/resources/data_state.dart';
import 'package:profile_cv/src/core/usecase/usecase.dart';
import 'package:profile_cv/src/domain/models/experience_model.dart';
import 'package:profile_cv/src/domain/repositories/cv_repository.dart';
import 'package:profile_cv/src/domain/usecases/get_experience_use_case.dart';

class MockCvRepository extends Mock implements CvRepository {}

void main() {
  late MockCvRepository mockRepository;
  late GetExperienceUseCase useCase;

  const locale = Locale('es', 'ES');
  const experience = [
    CompanyExperienceModel(
      company: 'Test Co',
      logoInitials: 'T',
      logoColorKey: 'black',
      roles: [
        RoleModel(title: 'Engineer', period: '2020 - 2021', duration: '1 año', skills: ''),
      ],
    ),
  ];

  setUp(() {
    mockRepository = MockCvRepository();
    useCase = GetExperienceUseCase(mockRepository);
  });

  test('calls repository.getExperience with the given locale and returns its success data', () async {
    when(() => mockRepository.getExperience(locale)).thenAnswer((_) async => const DataSuccess(experience));

    final result = await useCase(params: const LocaleParams(locale));

    expect(result, isA<DataSuccess<List<CompanyExperienceModel>>>());
    expect((result as DataSuccess<List<CompanyExperienceModel>>).data, experience);
    verify(() => mockRepository.getExperience(locale)).called(1);
  });

  test('propagates DataError from the repository', () async {
    final error = Exception('failed');
    when(() => mockRepository.getExperience(locale)).thenAnswer((_) async => DataError(error));

    final result = await useCase(params: const LocaleParams(locale));

    expect(result, isA<DataError<List<CompanyExperienceModel>>>());
  });
}
