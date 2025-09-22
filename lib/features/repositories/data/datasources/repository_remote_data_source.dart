import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:gemini_test/features/repositories/data/models/repository_model.dart';
import 'package:gemini_test/core/error/exceptions.dart';

abstract class RepositoryRemoteDataSource {
  Future<List<RepositoryModel>> getTopRepositories(String technology);
}

class RepositoryRemoteDataSourceImpl implements RepositoryRemoteDataSource {
  final Dio dio;

  RepositoryRemoteDataSourceImpl({required this.dio});
  // https://api.github.com/search/repositories?q=language:swift&sort=stars&order=desc  // swift
  // 'https://api.github.com/search/repositories?q=language:$technology&sort=stars&order=desc&per_page=50',
  // https://api.github.com/search/repositories?q=language:kotlin&sort=stars&order=desc // kotlin
  // https://api.github.com/search/repositories?q=language:dart&sort=stars&order=desc //fluttter
  // https://api.github.com/search/repositories?q=topic:react-native&sort=stars&order=desc //reactnative
  @override
  Future<List<RepositoryModel>> getTopRepositories(String technology) async {
    if (kDebugMode) {
      print('technology $technology');
    }
    final response = await dio.get(
      'https://api.github.com/search/repositories?q=$technology&sort=stars&order=desc',
    );
    if (response.statusCode == 200) {
      final items = response.data['items'] as List;
      return items.map((item) => RepositoryModel.fromJson(item)).toList();
    } else {
      throw ServerException();
    }
  }
}
