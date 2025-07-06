import 'package:dio/dio.dart';
import 'package:social_network_app/features/auth/domain/entity/user_entity.dart';

class AuthRemoteDatasource {
  final Dio _dio;
  AuthRemoteDatasource({required Dio dio}) : _dio = dio;

  Future<UserEntity> signInWithGoogle(String token) async {
    final request = await _dio.post('/auth/google', data: {'idToken': token});


    return UserEntity.fromJson(request.data);
  }
}
