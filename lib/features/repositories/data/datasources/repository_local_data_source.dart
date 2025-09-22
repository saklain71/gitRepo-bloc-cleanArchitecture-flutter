import 'package:shared_preferences/shared_preferences.dart';
import 'package:gemini_test/features/repositories/data/models/repository_model.dart';
import 'dart:convert';

abstract class RepositoryLocalDataSource {
  Future<List<RepositoryModel>> getLastRepositories(String technology);
  Future<void> cacheRepositories(String technology, List<RepositoryModel> repositoriesToCache);
}

class RepositoryLocalDataSourceImpl implements RepositoryLocalDataSource {
  final SharedPreferences sharedPreferences;

  RepositoryLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheRepositories(String technology, List<RepositoryModel> repositoriesToCache) {
    final jsonList = repositoriesToCache.map((repo) => repo.toJson()).toList();
    return sharedPreferences.setString(technology, json.encode(jsonList));
  }

  @override
  Future<List<RepositoryModel>> getLastRepositories(String technology) {
    final jsonString = sharedPreferences.getString(technology);
    if (jsonString != null) {
      final jsonList = json.decode(jsonString) as List;
      return Future.value(jsonList.map((repo) => RepositoryModel.fromJson(repo)).toList());
    } else {
      return Future.value([]);
    }
  }
}