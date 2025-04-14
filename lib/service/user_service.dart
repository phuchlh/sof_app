import 'package:sof_app/models/language_response.dart';
import 'package:sof_app/utils/enums.dart';

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

  Future<int> getTotal({required int userId, required ETypeParams type}) async {
    try {
      String typeString = '';
      switch (type) {
        case ETypeParams.ANSWER:
          typeString = 'answers';
          break;
        case ETypeParams.QUESTIONS:
          typeString = 'questions';
          break;
        case ETypeParams.COMMENTS:
          typeString = 'comments';
          break;
      }
      final response = await _dioClient.get(
        '/users/$userId/$typeString',
        queryParameters: {'filter': 'total', 'site': 'stackoverflow'},
      );

      if (response.statusCode != 200) {
        throw Exception(
          'Failed to fetch user reputation: ${response.statusCode}',
        );
      }

      // Parse the response data into ReputationResponse
      return response.data['total'] as int;
    } catch (e) {
      rethrow;
    }
  }

  Future<LanguageResponse> getTopLanguages({required int userId}) async {
    try {
      final response = await _dioClient.get(
        '/users/$userId/tags',
        queryParameters: {
          'page': 1,
          'pagesize': 5,
          'order': 'desc',
          'sort': 'popular',
          'site': 'stackoverflow',
        },
      );


      if (response.statusCode != 200) {
        throw Exception('Failed to fetch users: ${response.statusCode}');
      }

      // Parse the response data into UserResponse
      return LanguageResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
