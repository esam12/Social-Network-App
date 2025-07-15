import 'package:dartz/dartz.dart';
import 'package:social_network_app/core/errors/failures.dart';
import 'package:social_network_app/features/auth/domain/entity/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signInWithGoogle();

  /// Add User Data
  Future addUserData({required UserEntity user});

  /// Save User Data
  Future saveUserData({required UserEntity user});

  /// Get User Data
  Future<Either<Failure, UserEntity>> getUserData({required String id});

  /// Auth State Changes
  Stream<Either<Failure, UserEntity?>> authStateChanges();

  /// Log Out
  Future<Either<Failure, void>> logOut();
}
