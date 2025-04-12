import 'package:sof_app/models/user_response.dart';
import 'package:sof_app/models/reputation_response.dart';
import 'package:sof_app/service/dio_client.dart';
import 'package:dio/dio.dart';
import '../models/user_model.dart';
import '../models/reputation_history_model.dart';
import '../models/api_response.dart';

class UserService {
  final Dio _dioClient;

  UserService({Dio? dioClient}) : _dioClient = dioClient ?? Dio();

  Future<UserResponse> getUsers({
    required int page,
    required int pageSize,
    String order = 'desc',
    String sort = 'reputation',
    String site = 'stackoverflow',
  }) async {
    try {
      final response = await _dioClient.get(
        '/users',
        queryParameters: {
          'page': page,
          'pagesize': pageSize,
          'order': order,
          'sort': sort,
          'site': site,
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to fetch users: ${response.statusCode}');
      }

      // Parse the response data into UserResponse
      return UserResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ReputationResponse> getUserReputation({
    required int userId,
    required int page,
    required int pageSize,
  }) async {
    try {
      final response = await _dioClient.get(
        '/users/$userId/reputation-history',
        queryParameters: {'page': page, 'pagesize': pageSize},
      );

      if (response.statusCode != 200) {
        throw Exception(
          'Failed to fetch user reputation: ${response.statusCode}',
        );
      }

      // Parse the response data into ReputationResponse
      return ReputationResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
