import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:profile_cv/src/core/resources/data_state.dart';
import 'package:profile_cv/src/core/usecase/usecase.dart';
import 'package:profile_cv/src/domain/models/portfolio_item_model.dart';
import 'package:profile_cv/src/domain/usecases/get_portfolio_use_case.dart';
import 'package:profile_cv/src/ui/pages/portfolio/cubit/portfolio_cubit.dart';
import 'package:profile_cv/src/ui/pages/portfolio/cubit/portfolio_ui_state.dart';

class MockGetPortfolioUseCase extends Mock implements GetPortfolioUseCase {}

void main() {
  late MockGetPortfolioUseCase mockUseCase;
  late PortfolioCubit cubit;

  const portfolio = [
    PortfolioItemModel(title: 'N1CO App', iconKey: 'account_balance_wallet_outlined', url: 'https://example.com'),
  ];

  setUp(() {
    mockUseCase = MockGetPortfolioUseCase();
    cubit = PortfolioCubit(getPortfolioUseCase: mockUseCase);
  });

  tearDown(() => cubit.close());

  test('initial state is loading with no portfolio items', () {
    expect(cubit.state.isLoading, true);
    expect(cubit.state.portfolio, isEmpty);
  });

  blocTest<PortfolioCubit, PortfolioUiState>(
    'emits loading then success with portfolio items',
    build: () {
      when(() => mockUseCase(params: const NoParams())).thenAnswer((_) async => const DataSuccess(portfolio));
      return cubit;
    },
    act: (cubit) => cubit.loadData(),
    expect: () => [
      isA<PortfolioUiState>().having((s) => s.isLoading, 'isLoading', true),
      isA<PortfolioUiState>()
          .having((s) => s.isLoading, 'isLoading', false)
          .having((s) => s.hasError, 'hasError', false)
          .having((s) => s.portfolio, 'portfolio', portfolio),
    ],
  );

  blocTest<PortfolioCubit, PortfolioUiState>(
    'emits loading then error when the use case fails',
    build: () {
      when(() => mockUseCase(params: const NoParams())).thenAnswer((_) async => DataError(Exception('failed')));
      return cubit;
    },
    act: (cubit) => cubit.loadData(),
    expect: () => [
      isA<PortfolioUiState>().having((s) => s.isLoading, 'isLoading', true),
      isA<PortfolioUiState>().having((s) => s.hasError, 'hasError', true),
    ],
  );
}
