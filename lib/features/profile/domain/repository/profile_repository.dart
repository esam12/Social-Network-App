import 'package:dartz/dartz.dart';
import 'package:social_network_app/core/errors/failures.dart';
import 'package:social_network_app/features/auth/domain/entity/user_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, void>> updateUser(UserEntity user);
  Future<Either<Failure, UserEntity>> getUserById(String id);
}
