import 'package:equatable/equatable.dart';
import 'package:gemini_test/features/repositories/domain/entities/repository_entity.dart';

abstract class RepositoryState extends Equatable {
  const RepositoryState();

  @override
  List<Object> get props => [];
}

class RepositoryInitial extends RepositoryState {}

class RepositoryLoading extends RepositoryState {}

class RepositoryLoaded extends RepositoryState {
  final List<RepositoryEntity> repositories;

  const RepositoryLoaded(this.repositories);

  @override
  List<Object> get props => [repositories];
}

class RepositoryError extends RepositoryState {
  final String message;

  const RepositoryError(this.message);

  @override
  List<Object> get props => [message];
}