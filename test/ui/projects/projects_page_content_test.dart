import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:profile_cv/src/domain/models/project_model.dart';
import 'package:profile_cv/src/ui/pages/projects/cubit/projects_cubit.dart';
import 'package:profile_cv/src/ui/pages/projects/cubit/projects_ui_state.dart';
import 'package:profile_cv/src/ui/pages/projects/projects_page_content.dart';

class MockProjectsCubit extends MockCubit<ProjectsUiState> implements ProjectsCubit {}

void main() {
  late MockProjectsCubit mockCubit;

  setUp(() {
    mockCubit = MockProjectsCubit();
  });

  Widget buildTestWidget(ProjectsUiState state) {
    when(() => mockCubit.state).thenReturn(state);
    when(() => mockCubit.stream).thenAnswer((_) => Stream.value(state));
    return MaterialApp(
      home: BlocProvider<ProjectsCubit>.value(
        value: mockCubit,
        child: const ProjectsPageContent(),
      ),
    );
  }

  group('ProjectsPageContent', () {
    testWidgets('shows a loading indicator when loading', (tester) async {
      await tester.pumpWidget(buildTestWidget(ProjectsUiState.initial()));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows a retry button on error', (tester) async {
      final errorState = ProjectsUiState.initial().copyWith(isLoading: false, hasError: true);
      await tester.pumpWidget(buildTestWidget(errorState));
      await tester.pump();

      expect(find.text('Reintentar'), findsOneWidget);
    });

    testWidgets('shows project names when loaded', (tester) async {
      const loadedState = ProjectsUiState(
        isLoading: false,
        hasError: false,
        projects: [
          ProjectModel(name: 'ProfileCV', description: 'Desc', tech: 'Flutter', url: 'https://example.com'),
        ],
      );
      await tester.pumpWidget(buildTestWidget(loadedState));
      await tester.pump();

      expect(find.text('ProfileCV'), findsOneWidget);
    });
  });
}
