import 'package:gemini_test/features/repositories/domain/entities/repository_entity.dart';

class RepositoryModel extends RepositoryEntity {
  const RepositoryModel({
    required String name,
    String? description,
    required int stargazersCount,
    required OwnerModel owner,
  }) : super(
          name: name,
          description: description,
          stargazersCount: stargazersCount,
          owner: owner,
        );

  factory RepositoryModel.fromJson(Map<String, dynamic> json) {
    return RepositoryModel(
      name: json['name'] as String,
      description: json['description'] as String?,
      stargazersCount: json['stargazers_count'] as int,
      owner: OwnerModel.fromJson(json['owner'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'stargazers_count': stargazersCount,
      'owner': (owner as OwnerModel).toJson(),
    };
  }
}

class OwnerModel extends Owner {
  const OwnerModel({
    required String login,
    required String avatarUrl,
  }) : super(login: login, avatarUrl: avatarUrl);

  factory OwnerModel.fromJson(Map<String, dynamic> json) {
    return OwnerModel(
      login: json['login'] as String,
      avatarUrl: json['avatar_url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'avatar_url': avatarUrl,
    };
  }
}
