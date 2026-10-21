import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:profile_cv/src/core/resources/data_state.dart';
import 'package:profile_cv/src/core/usecase/usecase.dart';
import 'package:profile_cv/src/domain/models/profile_model.dart';
import 'package:profile_cv/src/domain/repositories/cv_repository.dart';
import 'package:profile_cv/src/domain/usecases/get_profile_use_case.dart';

class MockCvRepository extends Mock implements CvRepository {}

void main() {
  late MockCvRepository mockRepository;
  late GetProfileUseCase useCase;

  const locale = Locale('es', 'ES');
  const profile = ProfileModel(
    name: 'Test Name',
    title: 'Test Title',
    location: 'Test Location',
    objective: 'Test objective',
    avatarAsset: 'assets/images/profile.jpg',
  );

  setUp(() {
    mockRepository = MockCvRepository();
    useCase = GetProfileUseCase(mockRepository);
  });

  test('calls repository.getProfile with the given locale and returns its success data', () async {
    when(() => mockRepository.getProfile(locale)).thenAnswer((_) async => const DataSuccess(profile));

    final result = await useCase(params: const LocaleParams(locale));

    expect(result, isA<DataSuccess<ProfileModel>>());
    expect((result as DataSuccess<ProfileModel>).data, profile);
    verify(() => mockRepository.getProfile(locale)).called(1);
  });

  test('propagates DataError from the repository', () async {
    final error = Exception('failed');
    when(() => mockRepository.getProfile(locale)).thenAnswer((_) async => DataError(error));

    final result = await useCase(params: const LocaleParams(locale));

    expect(result, isA<DataError<ProfileModel>>());
    expect((result as DataError<ProfileModel>).error, error);
  });
}
