import 'package:social_network_app/core/common/models/either.dart';
import 'package:social_network_app/core/common/models/failure.dart';
import 'package:social_network_app/features/auth/domain/entity/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getUser();
  Future<Either<Failure, void>> updateUser(UserEntity user);
}