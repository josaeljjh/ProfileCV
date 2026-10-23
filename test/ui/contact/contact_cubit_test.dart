import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:profile_cv/src/core/resources/data_state.dart';
import 'package:profile_cv/src/core/usecase/usecase.dart';
import 'package:profile_cv/src/domain/models/contact_model.dart';
import 'package:profile_cv/src/domain/usecases/get_contact_use_case.dart';
import 'package:profile_cv/src/ui/pages/contact/cubit/contact_cubit.dart';
import 'package:profile_cv/src/ui/pages/contact/cubit/contact_ui_state.dart';

class MockGetContactUseCase extends Mock implements GetContactUseCase {}

void main() {
  late MockGetContactUseCase mockUseCase;
  late ContactCubit cubit;

  const contact = ContactModel(
    email: 'test@example.com',
    phone: '+1 234',
    linkedinDisplay: 'linkedin.com/in/test',
    linkedinUrl: 'https://linkedin.com/in/test',
    githubUrl: 'https://github.com/test',
    cvDownloadUrl: 'https://example.com/cv.pdf',
  );

  setUp(() {
    mockUseCase = MockGetContactUseCase();
    cubit = ContactCubit(getContactUseCase: mockUseCase);
  });

  tearDown(() => cubit.close());

  test('initial state is loading with no contact', () {
    expect(cubit.state.isLoading, true);
    expect(cubit.state.contact, isNull);
  });

  blocTest<ContactCubit, ContactUiState>(
    'emits loading then success with contact',
    build: () {
      when(() => mockUseCase(params: const NoParams())).thenAnswer((_) async => const DataSuccess(contact));
      return cubit;
    },
    act: (cubit) => cubit.loadData(),
    expect: () => [
      isA<ContactUiState>().having((s) => s.isLoading, 'isLoading', true),
      isA<ContactUiState>()
          .having((s) => s.isLoading, 'isLoading', false)
          .having((s) => s.hasError, 'hasError', false)
          .having((s) => s.contact, 'contact', contact),
    ],
  );

  blocTest<ContactCubit, ContactUiState>(
    'emits loading then error when the use case fails',
    build: () {
      when(() => mockUseCase(params: const NoParams())).thenAnswer((_) async => DataError(Exception('failed')));
      return cubit;
    },
    act: (cubit) => cubit.loadData(),
    expect: () => [
      isA<ContactUiState>().having((s) => s.isLoading, 'isLoading', true),
      isA<ContactUiState>().having((s) => s.hasError, 'hasError', true),
    ],
  );
}
