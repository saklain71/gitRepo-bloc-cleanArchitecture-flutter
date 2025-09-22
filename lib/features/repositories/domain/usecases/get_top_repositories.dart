import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gemini_test/core/error/failure.dart';
import 'package:gemini_test/core/usecases/usecase.dart';
import 'package:gemini_test/features/repositories/domain/entities/repository_entity.dart';
import 'package:gemini_test/features/repositories/domain/repositories/repository_repository.dart';

class GetTopRepositories implements UseCase<List<RepositoryEntity>, Params> {
  final RepositoryRepository repository;

  GetTopRepositories(this.repository);

  @override
  Future<Either<Failure, List<RepositoryEntity>>> call(Params params) async {
    return await repository.getTopRepositories(params.technology);
  }
}

class Params extends Equatable {
  final String technology;

  const Params({required this.technology});

  @override
  List<Object> get props => [technology];
}
