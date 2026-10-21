import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

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
