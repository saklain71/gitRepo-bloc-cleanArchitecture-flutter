import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'features/repositories/data/datasources/repository_local_data_source.dart';
import 'features/repositories/data/datasources/repository_remote_data_source.dart';
import 'features/repositories/data/repositories/repository_repository_impl.dart';
import 'features/repositories/domain/repositories/repository_repository.dart';
import 'features/repositories/domain/usecases/get_top_repositories.dart';
import 'features/repositories/presentation/bloc/repository_bloc.dart';
import 'core/network/network_info.dart';
import 'core/network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features
  sl.registerFactory(
    () => RepositoryBloc(getTopRepositories: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetTopRepositories(sl()));

  // Repository
  sl.registerLazySingleton<RepositoryRepository>(
    () => RepositoryRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<RepositoryRemoteDataSource>(
    () => RepositoryRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<RepositoryLocalDataSource>(
    () => RepositoryLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  if (kIsWeb) {
    sl.registerLazySingleton(() => Connectivity());
  } else {
    sl.registerLazySingleton(() => InternetConnectionChecker());
  }
}