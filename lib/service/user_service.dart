import '../models/reputation_response.dart';
import '../models/user_response.dart';
import 'dio_client.dart';

class UserService {
  final _dioClient = DioClient();

  Future<UserResponse> getUsers({
    required int page,
    required int pageSize,
    String order = 'desc',
    String sort = 'reputation',
    String site = 'stackoverflow',
    String inname = '',
  }) async {
    try {
      final response = await _dioClient.get(
        '/users',
        queryParameters: {
          'page': page,
          'pagesize': pageSize,
          'order': order,
          'sort': sort,
          'inname': inname,
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
        queryParameters: {
          'page': page,
          'pagesize': pageSize,
          'site': 'stackoverflow',
        },
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
