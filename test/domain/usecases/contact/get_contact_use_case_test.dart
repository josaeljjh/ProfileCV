import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:profile_cv/src/core/resources/data_state.dart';
import 'package:profile_cv/src/core/usecase/usecase.dart';
import 'package:profile_cv/src/domain/models/contact_model.dart';
import 'package:profile_cv/src/domain/repositories/cv_repository.dart';
import 'package:profile_cv/src/domain/usecases/get_contact_use_case.dart';

class MockCvRepository extends Mock implements CvRepository {}

void main() {
  late MockCvRepository mockRepository;
  late GetContactUseCase useCase;

  const contact = ContactModel(
    email: 'test@example.com',
    phone: '+1 234',
    linkedinDisplay: 'linkedin.com/in/test',
    linkedinUrl: 'https://linkedin.com/in/test',
    githubUrl: 'https://github.com/test',
    cvDownloadUrl: 'https://example.com/cv.pdf',
  );

  setUp(() {
    mockRepository = MockCvRepository();
    useCase = GetContactUseCase(mockRepository);
  });

  test('calls repository.getContact and returns its success data', () async {
    when(() => mockRepository.getContact()).thenAnswer((_) async => const DataSuccess(contact));

    final result = await useCase(params: const NoParams());

    expect(result, isA<DataSuccess<ContactModel>>());
    expect((result as DataSuccess<ContactModel>).data, contact);
    verify(() => mockRepository.getContact()).called(1);
  });

  test('propagates DataError from the repository', () async {
    final error = Exception('failed');
    when(() => mockRepository.getContact()).thenAnswer((_) async => DataError(error));

    final result = await useCase(params: const NoParams());

    expect(result, isA<DataError<ContactModel>>());
  });
}
