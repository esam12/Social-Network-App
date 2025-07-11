import 'package:social_network_app/core/common/models/either.dart';
import 'package:social_network_app/core/common/models/failure.dart';
import 'package:social_network_app/features/auth/domain/entity/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signInWithGoogle();

  /// Add User Data
  Future addUserData({required UserEntity user});

  /// Save User Data
  Future saveUserData({required UserEntity user});

  /// Get User Data
  Future<UserEntity> getUserData({required String uid});

  /// Log Out
  Future<Either<Failure, void>> logOut();
}
