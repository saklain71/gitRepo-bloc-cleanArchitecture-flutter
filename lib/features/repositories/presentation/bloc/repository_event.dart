import 'package:equatable/equatable.dart';

abstract class RepositoryEvent extends Equatable {
  const RepositoryEvent();

  @override
  List<Object> get props => [];
}

class GetRepositories extends RepositoryEvent {
  final String technology;

  const GetRepositories(this.technology);

  @override
  List<Object> get props => [technology];
}
