import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:profile_cv/src/core/resources/data_state.dart';
import 'package:profile_cv/src/core/usecase/usecase.dart';
import 'package:profile_cv/src/domain/models/portfolio_item_model.dart';
import 'package:profile_cv/src/domain/repositories/cv_repository.dart';
import 'package:profile_cv/src/domain/usecases/get_portfolio_use_case.dart';

class MockCvRepository extends Mock implements CvRepository {}

void main() {
  late MockCvRepository mockRepository;
  late GetPortfolioUseCase useCase;

  const portfolio = [
    PortfolioItemModel(title: 'App', iconKey: 'account_balance_wallet_outlined', url: 'https://example.com'),
  ];

  setUp(() {
    mockRepository = MockCvRepository();
    useCase = GetPortfolioUseCase(mockRepository);
  });

  test('calls repository.getPortfolio and returns its success data', () async {
    when(() => mockRepository.getPortfolio()).thenAnswer((_) async => const DataSuccess(portfolio));

    final result = await useCase(params: const NoParams());

    expect(result, isA<DataSuccess<List<PortfolioItemModel>>>());
    expect((result as DataSuccess<List<PortfolioItemModel>>).data, portfolio);
    verify(() => mockRepository.getPortfolio()).called(1);
  });

  test('propagates DataError from the repository', () async {
    final error = Exception('failed');
    when(() => mockRepository.getPortfolio()).thenAnswer((_) async => DataError(error));

    final result = await useCase(params: const NoParams());

    expect(result, isA<DataError<List<PortfolioItemModel>>>());
  });
}
