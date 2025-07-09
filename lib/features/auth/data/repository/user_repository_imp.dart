import 'package:dio/dio.dart';
import 'package:social_network_app/core/common/models/either.dart';
import 'package:social_network_app/core/common/models/failure.dart';
import 'package:social_network_app/features/auth/data/datasource/user_remote_datasource.dart';
import 'package:social_network_app/features/auth/domain/entity/user_entity.dart';
import 'package:social_network_app/features/auth/domain/repository/user_repository.dart';

class UserRepositoryImp implements UserRepository {
  final UserRemoteDatasource userRemoteDatasource;

  UserRepositoryImp({required this.userRemoteDatasource});
  @override
  Future<Either<Failure, UserEntity>> getUser() async {
    try {
      return Right(await userRemoteDatasource.getUser());
    } on DioException catch (e) {
      return Left(UserFailure(message: e.response?.data['message'] ?? ''));
    } catch (e) {
      return Left(UserFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateUser(UserEntity user) async {
    try {
      return Right(await userRemoteDatasource.updateUser(user));
    } on DioException catch (e) {
      return Left(UserFailure(message: e.response?.data['message'] ?? ''));
    } catch (e) {
      return Left(UserFailure(message: e.toString()));
    }
  }
}
