import 'package:dio/dio.dart';
import 'package:github_repo_viewer/core/utils/constant.dart';
import '../models/user_model.dart';
import '../models/repo_model.dart';

class GithubApiService {
  late Dio _dio;

  GithubApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        headers: {
          'Accept': 'application/vnd.github.v3+json',
        },
      ),
    );

    // Add interceptors for logging
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  // Get user information
  Future<UserModel> getUserInfo(String username) async {
    try {
      final response = await _dio.get('${AppConstants.userEndpoint}/$username');
      
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message: 'Failed to fetch user info',
        );
      }
    } on DioException catch (e) {
      print("DDDDDDDDDDDDDDDDDDDDDDDDDDIO DioException $e");
      if (e.response?.statusCode == 404) {
        throw Exception(AppConstants.userNotFound);
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception(AppConstants.networkError);
      } else {
        throw Exception(AppConstants.genericError);
      }
    } catch (e) {
      throw Exception(AppConstants.genericError);
    }
  }

  // Get user repositories
  Future<List<RepoModel>> getUserRepos(String username) async {
    try {
      final response = await _dio.get(
        '${AppConstants.userEndpoint}/$username/repos',
        queryParameters: {
          'per_page': 100,
          'sort': 'updated',
        },
      );

      if (response.statusCode == 200) {
        List<RepoModel> repos = [];
        for (var repo in response.data) {
          repos.add(RepoModel.fromJson(repo));
        }
        return repos;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message: 'Failed to fetch repositories',
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw Exception(AppConstants.userNotFound);
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception(AppConstants.networkError);
      } else {
        throw Exception(AppConstants.genericError);
      }
    } catch (e) {
      print("EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEError $e");
      throw Exception(AppConstants.genericError);
    }
  }
}