import 'package:dio/dio.dart';
import 'package:social_network_app/features/auth/domain/entity/user_entity.dart';

class UserRemoteDatasource {
  final Dio dio;

  UserRemoteDatasource({required this.dio});

  Future<UserEntity> getUser() async {
    final response = await dio.get('/user');
    return UserEntity.fromJson(response.data);
  }

  Future<void> updateUser(UserEntity user) async {
    print("Sending update request: ${user.toJson()}");
    final res = await dio.put('/user-profile', data: user.toJson());
    print("Response status: ${res.statusCode}");
    print("Response data: ${res.data}");
    return;
  }
}
