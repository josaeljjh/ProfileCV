import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../data/repositories/cv_repository_impl.dart';
import '../../domain/repositories/cv_repository.dart';
import '../../domain/usecases/get_contact_use_case.dart';
import '../../domain/usecases/get_experience_use_case.dart';
import '../../domain/usecases/get_home_skills_use_case.dart';
import '../../domain/usecases/get_portfolio_use_case.dart';
import '../../domain/usecases/get_profile_use_case.dart';
import '../../domain/usecases/get_projects_use_case.dart';
import '../../domain/usecases/get_skill_groups_use_case.dart';
import '../../ui/pages/contact/cubit/contact_cubit.dart';
import '../../ui/pages/home/cubit/home_cubit.dart';
import '../../ui/pages/projects/cubit/projects_cubit.dart';
import '../../ui/pages/skills/cubit/skills_cubit.dart';
import '../routes/navigation_service.dart';
import '../tools/connection_info.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  //navigation service
  sl.registerLazySingleton(() => NavigationService());

  // Dio
  sl.registerLazySingleton<Dio>(() => getDio());

  // ConnectionInfo
  sl.registerLazySingleton<ConnectionInfo>(() => ConnectionInfoImpl(sl()));

  // InternetConnectionChecker
  sl.registerLazySingleton(() => InternetConnectionChecker());

  // Repositories
  sl.registerLazySingleton<CvRepository>(() => CvRepositoryImpl());

  // Use cases
  sl.registerLazySingleton(() => GetProfileUseCase(sl()));
  sl.registerLazySingleton(() => GetPortfolioUseCase(sl()));
  sl.registerLazySingleton(() => GetHomeSkillsUseCase(sl()));
  sl.registerLazySingleton(() => GetExperienceUseCase(sl()));
  sl.registerLazySingleton(() => GetSkillGroupsUseCase(sl()));
  sl.registerLazySingleton(() => GetProjectsUseCase(sl()));
  sl.registerLazySingleton(() => GetContactUseCase(sl()));

  // Cubits
  sl.registerFactory(() => HomeCubit(
        getProfileUseCase: sl(),
        getPortfolioUseCase: sl(),
        getHomeSkillsUseCase: sl(),
        getExperienceUseCase: sl(),
      ));
  sl.registerFactory(() => SkillsCubit(getSkillGroupsUseCase: sl()));
  sl.registerFactory(() => ProjectsCubit(getProjectsUseCase: sl()));
  sl.registerFactory(() => ContactCubit(getContactUseCase: sl()));
}

Dio getDio() {
  final dio = Dio(
    BaseOptions(
      validateStatus: (status) {
        return true;
      },
      followRedirects: false,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );
  return dio;
}
