import 'package:dio/dio.dart';
import 'package:social_network_app/features/auth/domain/entity/user_entity.dart';

class UserRemoteDatasource {
  final Dio dio;

  UserRemoteDatasource({required this.dio});

  Future<UserEntity> getUser() async {

    final response = await dio.get(
      '/user',
    
    );
    return UserEntity.fromJson(response.data);
  }
}
