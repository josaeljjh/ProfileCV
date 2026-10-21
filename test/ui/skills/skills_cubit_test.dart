import 'dart:ui';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:profile_cv/src/core/resources/data_state.dart';
import 'package:profile_cv/src/core/usecase/usecase.dart';
import 'package:profile_cv/src/domain/models/skill_group_model.dart';
import 'package:profile_cv/src/domain/usecases/get_skill_groups_use_case.dart';
import 'package:profile_cv/src/ui/pages/skills/cubit/skills_cubit.dart';
import 'package:profile_cv/src/ui/pages/skills/cubit/skills_ui_state.dart';

class MockGetSkillGroupsUseCase extends Mock implements GetSkillGroupsUseCase {}

void main() {
  late MockGetSkillGroupsUseCase mockUseCase;
  late SkillsCubit cubit;

  const locale = Locale('es', 'ES');
  const groups = [
    SkillGroupModel(category: 'Flutter / Dart', skills: ['Flutter', 'Dart']),
  ];

  setUp(() {
    mockUseCase = MockGetSkillGroupsUseCase();
    cubit = SkillsCubit(getSkillGroupsUseCase: mockUseCase);
  });

  tearDown(() => cubit.close());

  test('initial state is loading with no groups', () {
    expect(cubit.state.isLoading, true);
    expect(cubit.state.skillGroups, isEmpty);
  });

  blocTest<SkillsCubit, SkillsUiState>(
    'emits loading then success with skill groups',
    build: () {
      when(() => mockUseCase(params: const LocaleParams(locale))).thenAnswer((_) async => const DataSuccess(groups));
      return cubit;
    },
    act: (cubit) => cubit.loadData(locale),
    expect: () => [
      isA<SkillsUiState>().having((s) => s.isLoading, 'isLoading', true),
      isA<SkillsUiState>()
          .having((s) => s.isLoading, 'isLoading', false)
          .having((s) => s.hasError, 'hasError', false)
          .having((s) => s.skillGroups, 'skillGroups', groups),
    ],
  );

  blocTest<SkillsCubit, SkillsUiState>(
    'emits loading then error when the use case fails',
    build: () {
      when(() => mockUseCase(params: const LocaleParams(locale))).thenAnswer((_) async => DataError(Exception('failed')));
      return cubit;
    },
    act: (cubit) => cubit.loadData(locale),
    expect: () => [
      isA<SkillsUiState>().having((s) => s.isLoading, 'isLoading', true),
      isA<SkillsUiState>().having((s) => s.hasError, 'hasError', true),
    ],
  );
}
