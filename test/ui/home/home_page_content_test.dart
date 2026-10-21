import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localization/localization.dart';
import 'package:mocktail/mocktail.dart';
import 'package:profile_cv/src/domain/models/portfolio_item_model.dart';
import 'package:profile_cv/src/domain/models/profile_model.dart';
import 'package:profile_cv/src/ui/pages/home/cubit/home_cubit.dart';
import 'package:profile_cv/src/ui/pages/home/cubit/home_ui_state.dart';
import 'package:profile_cv/src/ui/pages/home/home_page_content.dart';

class MockHomeCubit extends MockCubit<HomeUiState> implements HomeCubit {}

void main() {
  late MockHomeCubit mockCubit;

  setUpAll(() {
    LocalJsonLocalization.delegate.directories = ['res/i18n'];
  });

  setUp(() {
    mockCubit = MockHomeCubit();
  });

  const profile = ProfileModel(
    name: 'Julio Josaél Hernández Peréz',
    title: 'Senior Mobile Engineer',
    location: 'El Salvador',
    objective: 'Test objective',
    avatarAsset: 'assets/images/profile.jpg',
  );
  const portfolio = [
    PortfolioItemModel(title: 'N1CO App', iconKey: 'account_balance_wallet_outlined'),
  ];

  Widget buildTestWidget(HomeUiState state) {
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
      home: BlocProvider<HomeCubit>.value(
        value: mockCubit,
        child: const HomePageContent(),
      ),
    );
  }

  group('HomePageContent', () {
    testWidgets('shows a loading indicator when loading', (tester) async {
      await tester.pumpWidget(buildTestWidget(HomeUiState.initial()));
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows a retry button on error', (tester) async {
      final errorState = HomeUiState.initial().copyWith(isLoading: false, hasError: true);
      await tester.pumpWidget(buildTestWidget(errorState));
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Reintentar'), findsOneWidget);
    });

    testWidgets('shows profile and section titles when loaded', (tester) async {
      final loadedState = HomeUiState(
        isLoading: false,
        hasError: false,
        profile: profile,
        portfolio: portfolio,
        homeSkills: const ['Flutter'],
        experience: const [],
      );
      await tester.pumpWidget(buildTestWidget(loadedState));
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text(profile.name), findsOneWidget);
      expect(find.text('Portfolio'), findsOneWidget);
      expect(find.text('Skills'), findsOneWidget);
      expect(find.text('Experiencia'), findsOneWidget);
      // Portfolio and Skills section titles are tappable shortcuts (chevron
      // affordance + InkWell); Experiencia has no destination screen.
      expect(find.byIcon(Icons.chevron_right), findsNWidgets(2));
      expect(find.byType(InkWell), findsNWidgets(2));
    });
  });
}
