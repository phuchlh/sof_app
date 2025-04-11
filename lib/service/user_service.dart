import 'package:sof_app/models/user_response.dart';
import 'package:sof_app/service/dio_client.dart';

class UserService {
  final _dioClient = DioClient();

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
}
