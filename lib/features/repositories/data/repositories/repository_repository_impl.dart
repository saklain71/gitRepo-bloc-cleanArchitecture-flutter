import 'package:dartz/dartz.dart';
import 'package:gemini_test/core/error/failure.dart';
import 'package:gemini_test/core/network/network_info.dart';
import 'package:gemini_test/features/repositories/data/datasources/repository_local_data_source.dart';
import 'package:gemini_test/features/repositories/data/datasources/repository_remote_data_source.dart';
import 'package:gemini_test/features/repositories/domain/entities/repository_entity.dart';
import 'package:gemini_test/features/repositories/domain/repositories/repository_repository.dart';

import 'package:gemini_test/core/error/exceptions.dart';

class RepositoryRepositoryImpl implements RepositoryRepository {
  final RepositoryRemoteDataSource remoteDataSource;
  final RepositoryLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  RepositoryRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<RepositoryEntity>>> getTopRepositories(String technology) async {
    if (await networkInfo.isConnected) {
      // technology = 'swift';
      try {
        final remoteRepositories = await remoteDataSource.getTopRepositories(technology);
        localDataSource.cacheRepositories(technology, remoteRepositories);
        return Right(remoteRepositories);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localRepositories = await localDataSource.getLastRepositories(technology);
        return Right(localRepositories);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
