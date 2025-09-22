import 'package:equatable/equatable.dart';

class RepositoryEntity extends Equatable {
  final String name;
  final String? description;
  final int stargazersCount;
  final Owner owner;

  const RepositoryEntity({
    required this.name,
    this.description,
    required this.stargazersCount,
    required this.owner,
  });

  @override
  List<Object?> get props => [name, description, stargazersCount, owner];
}

class Owner extends Equatable {
  final String login;
  final String avatarUrl;

  const Owner({
    required this.login,
    required this.avatarUrl,
  });

  @override
  List<Object?> get props => [login, avatarUrl];
}
