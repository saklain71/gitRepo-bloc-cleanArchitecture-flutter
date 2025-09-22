import 'package:dartz/dartz.dart';
import 'package:gemini_test/core/error/failure.dart';
import 'package:gemini_test/features/repositories/domain/entities/repository_entity.dart';

abstract class RepositoryRepository {
  Future<Either<Failure, List<RepositoryEntity>>> getTopRepositories(String technology);
}
