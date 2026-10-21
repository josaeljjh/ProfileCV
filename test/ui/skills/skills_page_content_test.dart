import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localization/localization.dart';
import 'package:profile_cv/src/domain/models/skill_group_model.dart';
import 'package:profile_cv/src/ui/pages/skills/cubit/skills_cubit.dart';
import 'package:profile_cv/src/ui/pages/skills/cubit/skills_ui_state.dart';
import 'package:profile_cv/src/ui/pages/skills/skills_page_content.dart';

class MockSkillsCubit extends MockCubit<SkillsUiState> implements SkillsCubit {}

void main() {
  late MockSkillsCubit mockCubit;

  setUpAll(() {
    LocalJsonLocalization.delegate.directories = ['res/i18n'];
  });

  setUp(() {
    mockCubit = MockSkillsCubit();
  });

  Widget buildTestWidget(SkillsUiState state) {
    when(() => mockCubit.state).thenReturn(state);
    when(() => mockCubit.stream).thenAnswer((_) => Stream.value(state));
    return MaterialApp(
      locale: const Locale('es', 'ES'),
      supportedLocales: const [Locale('es', 'ES'), Locale('en', 'US')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        LocalJsonLocalization.delegate,
      ],
      home: BlocProvider<SkillsCubit>.value(
        value: mockCubit,
        child: const SkillsPageContent(),
      ),
    );
  }

  group('SkillsPageContent', () {
    testWidgets('shows a loading indicator when loading', (tester) async {
      await tester.pumpWidget(buildTestWidget(SkillsUiState.initial()));
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows a retry button on error', (tester) async {
      final errorState = SkillsUiState.initial().copyWith(isLoading: false, hasError: true);
      await tester.pumpWidget(buildTestWidget(errorState));
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Reintentar'), findsOneWidget);
    });

    testWidgets('shows skill group categories when loaded', (tester) async {
      const loadedState = SkillsUiState(
        isLoading: false,
        hasError: false,
        skillGroups: [
          SkillGroupModel(category: 'Flutter / Dart', skills: ['Flutter']),
        ],
      );
      await tester.pumpWidget(buildTestWidget(loadedState));
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Flutter / Dart'), findsOneWidget);
      expect(find.text('Flutter'), findsOneWidget);
    });
  });
}
