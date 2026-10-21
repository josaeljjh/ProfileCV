import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localization/localization.dart';
import 'package:mocktail/mocktail.dart';
import 'package:profile_cv/src/domain/models/portfolio_item_model.dart';
import 'package:profile_cv/src/ui/pages/portfolio/cubit/portfolio_cubit.dart';
import 'package:profile_cv/src/ui/pages/portfolio/cubit/portfolio_ui_state.dart';
import 'package:profile_cv/src/ui/pages/portfolio/portfolio_page_content.dart';

class MockPortfolioCubit extends MockCubit<PortfolioUiState> implements PortfolioCubit {}

void main() {
  late MockPortfolioCubit mockCubit;

  setUpAll(() {
    LocalJsonLocalization.delegate.directories = ['res/i18n'];
  });

  setUp(() {
    mockCubit = MockPortfolioCubit();
  });

  Widget buildTestWidget(PortfolioUiState state) {
    when(() => mockCubit.state).thenReturn(state);
    when(() => mockCubit.stream).thenAnswer((_) => Stream.value(state));
    return MaterialApp(
      locale: const Locale('es', 'ES'),
      supportedLocales: const [Locale('es', 'ES'), Locale('en', 'US')],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        LocalJsonLocalization.delegate,
      ],
      home: BlocProvider<PortfolioCubit>.value(
        value: mockCubit,
        child: const PortfolioPageContent(),
      ),
    );
  }

  group('PortfolioPageContent', () {
    testWidgets('shows a loading indicator when loading', (tester) async {
      await tester.pumpWidget(buildTestWidget(PortfolioUiState.initial()));
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows a retry button on error', (tester) async {
      final errorState = PortfolioUiState.initial().copyWith(isLoading: false, hasError: true);
      await tester.pumpWidget(buildTestWidget(errorState));
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Reintentar'), findsOneWidget);
    });

    testWidgets('shows portfolio item titles when loaded', (tester) async {
      const loadedState = PortfolioUiState(
        isLoading: false,
        hasError: false,
        portfolio: [
          PortfolioItemModel(title: 'N1CO App', iconKey: 'account_balance_wallet_outlined'),
        ],
      );
      await tester.pumpWidget(buildTestWidget(loadedState));
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('N1CO App'), findsOneWidget);
    });
  });
}
