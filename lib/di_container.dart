import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';


import 'helper/network_info.dart';
// service locator object
// final sl = GetIt.instance;

Future<void> init() async {
  // Core
  // sl.registerLazySingleton(() => NetworkInfo(sl()));
  // sl.registerLazySingleton(() => DioClient(AppConstants.BASE_URL, dio:sl(), loggingInterceptor: sl(), prefs: sl()));

  // Repository
  // sl.registerLazySingleton(() => CategoryRepo(dioClient: sl()));


  // controllers
  // sl.registerFactory(() => CategoryProvider(categoryRepo: sl()));


  // External
  // final sharedPreferences = await SharedPreferences.getInstance();
  // sl.registerLazySingleton(() => sharedPreferences);
  // sl.registerLazySingleton(() => Dio());
  // sl.registerLazySingleton(() => LoggingInterceptor());
  // sl.registerLazySingleton(() => Connectivity());
}
