import 'dart:ui';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:profile_cv/src/core/resources/data_state.dart';
import 'package:profile_cv/src/core/usecase/usecase.dart';
import 'package:profile_cv/src/domain/models/experience_model.dart';
import 'package:profile_cv/src/domain/models/portfolio_item_model.dart';
import 'package:profile_cv/src/domain/models/profile_model.dart';
import 'package:profile_cv/src/domain/usecases/get_experience_use_case.dart';
import 'package:profile_cv/src/domain/usecases/get_home_skills_use_case.dart';
import 'package:profile_cv/src/domain/usecases/get_portfolio_use_case.dart';
import 'package:profile_cv/src/domain/usecases/get_profile_use_case.dart';
import 'package:profile_cv/src/ui/pages/home/cubit/home_cubit.dart';
import 'package:profile_cv/src/ui/pages/home/cubit/home_ui_state.dart';

class MockGetProfileUseCase extends Mock implements GetProfileUseCase {}

class MockGetPortfolioUseCase extends Mock implements GetPortfolioUseCase {}

class MockGetHomeSkillsUseCase extends Mock implements GetHomeSkillsUseCase {}

class MockGetExperienceUseCase extends Mock implements GetExperienceUseCase {}

void main() {
  late MockGetProfileUseCase mockGetProfile;
  late MockGetPortfolioUseCase mockGetPortfolio;
  late MockGetHomeSkillsUseCase mockGetHomeSkills;
  late MockGetExperienceUseCase mockGetExperience;
  late HomeCubit cubit;

  const locale = Locale('es', 'ES');
  const profile = ProfileModel(
    name: 'Test Name',
    title: 'Test Title',
    location: 'Test Location',
    objective: 'Test objective',
    avatarAsset: 'assets/images/profile.jpg',
  );
  const portfolio = [
    PortfolioItemModel(title: 'App', iconKey: 'account_balance_wallet_outlined'),
  ];
  const homeSkills = ['Flutter', 'Kotlin'];
  const experience = [
    CompanyExperienceModel(
      company: 'Test Co',
      logoInitials: 'T',
      logoColorKey: 'black',
      roles: [
        RoleModel(title: 'Engineer', period: '2020 - 2021', duration: '1 año', skills: ''),
      ],
    ),
  ];

  setUp(() {
    mockGetProfile = MockGetProfileUseCase();
    mockGetPortfolio = MockGetPortfolioUseCase();
    mockGetHomeSkills = MockGetHomeSkillsUseCase();
    mockGetExperience = MockGetExperienceUseCase();
    cubit = HomeCubit(
      getProfileUseCase: mockGetProfile,
      getPortfolioUseCase: mockGetPortfolio,
      getHomeSkillsUseCase: mockGetHomeSkills,
      getExperienceUseCase: mockGetExperience,
    );
  });

  tearDown(() => cubit.close());

  test('initial state is loading with empty data', () {
    expect(cubit.state.isLoading, true);
    expect(cubit.state.hasError, false);
    expect(cubit.state.profile, isNull);
  });

  blocTest<HomeCubit, HomeUiState>(
    'emits loading then success with all four datasets when every use case succeeds',
    build: () {
      when(() => mockGetProfile(params: const LocaleParams(locale))).thenAnswer((_) async => const DataSuccess(profile));
      when(() => mockGetPortfolio(params: const NoParams())).thenAnswer((_) async => const DataSuccess(portfolio));
      when(() => mockGetHomeSkills(params: const NoParams())).thenAnswer((_) async => const DataSuccess(homeSkills));
      when(() => mockGetExperience(params: const LocaleParams(locale))).thenAnswer((_) async => const DataSuccess(experience));
      return cubit;
    },
    act: (cubit) => cubit.loadData(locale),
    expect: () => [
      isA<HomeUiState>().having((s) => s.isLoading, 'isLoading', true),
      isA<HomeUiState>()
          .having((s) => s.isLoading, 'isLoading', false)
          .having((s) => s.hasError, 'hasError', false)
          .having((s) => s.profile, 'profile', profile)
          .having((s) => s.portfolio, 'portfolio', portfolio)
          .having((s) => s.homeSkills, 'homeSkills', homeSkills)
          .having((s) => s.experience, 'experience', experience),
    ],
  );

  blocTest<HomeCubit, HomeUiState>(
    'emits loading then error when any use case fails',
    build: () {
      when(() => mockGetProfile(params: const LocaleParams(locale))).thenAnswer((_) async => DataError(Exception('failed')));
      when(() => mockGetPortfolio(params: const NoParams())).thenAnswer((_) async => const DataSuccess(portfolio));
      when(() => mockGetHomeSkills(params: const NoParams())).thenAnswer((_) async => const DataSuccess(homeSkills));
      when(() => mockGetExperience(params: const LocaleParams(locale))).thenAnswer((_) async => const DataSuccess(experience));
      return cubit;
    },
    act: (cubit) => cubit.loadData(locale),
    expect: () => [
      isA<HomeUiState>().having((s) => s.isLoading, 'isLoading', true),
      isA<HomeUiState>()
          .having((s) => s.isLoading, 'isLoading', false)
          .having((s) => s.hasError, 'hasError', true),
    ],
  );
}
