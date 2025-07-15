import 'dart:convert';
import 'package:social_network_app/core/errors/exception.dart';
import 'package:social_network_app/core/errors/failures.dart';
import 'package:social_network_app/core/services/data_service.dart';
import 'package:social_network_app/core/services/firebase_auth_service.dart';
import 'package:social_network_app/core/services/shared_preferences_singleton.dart';
import 'package:social_network_app/core/utils/backend_endpoint.dart';
import 'package:social_network_app/core/utils/constants/constants.dart';
import 'package:social_network_app/features/auth/data/model/user_model.dart';
import 'package:social_network_app/features/auth/domain/entity/user_entity.dart';
import 'package:social_network_app/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthService _authService;
  final DatabaseService _dbService;

  AuthRepositoryImpl(this._dbService, this._authService);

  @override
  Future<Either<ServerFailure, UserEntity>> signInWithGoogle() async {
    User? user;
    try {
      user = await _authService.signInWithGoogle();

      var userEntity = UserModel.fromFirebaseUser(user);
      var isUserExist = await _dbService.checkIfDataExists(
        path: BackendEndpoint.isUserExists,
        documentId: user.uid,
      );

      if (isUserExist) {
        await getUserData(id: user.uid);
      } else {
        await addUserData(user: userEntity);
      }

      return right(userEntity);
    } on CustomException catch (e) {
      if (user != null) {
        await _authService.deleteUser();
      }
      return left(ServerFailure(e.message));
    } catch (_) {
      return left(ServerFailure('There was an error, please try again.'));
    }
  }

  @override
  Future<Either<Failure, void>> logOut() async {
    try {
      FirebaseAuth.instance.signOut();
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future addUserData({required UserEntity user}) async {
    await _dbService.addData(
      path: BackendEndpoint.addUserData,
      data: user.toMap(),
      documentId: user.id,
    );
  }

  @override
  Future<Either<Failure, UserEntity>> getUserData({required String id}) async {
    try {
      var userData = await _dbService.getData(
        path: BackendEndpoint.getUsersData,
        documentId: id,
      );
      return right(UserModel.fromEntity(userData));
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future saveUserData({required UserEntity user}) async {
    var jsonData = jsonEncode(UserModel.fromEntity(user).toMap());
    await SharedPreferencesSingleton.setString(kUserData, jsonData);
  }

  @override
  Stream<Either<Failure, UserEntity?>> authStateChanges() async* {
    await for (final fbUser in _authService.authStateChanges) {
      if (fbUser == null) {
        yield right(null);
      } else {
        try {
          final raw = await _dbService.getData(
            path: BackendEndpoint.getUsersData,
            documentId: fbUser.uid,
          );
          final userEntity = UserModel.fromJson(raw as Map<String, dynamic>);
          yield right(userEntity);
        } on CustomException catch (e) {
          yield left(ServerFailure(e.message));
        } catch (_) {
          yield left(ServerFailure('Unexpected error'));
        }
      }
    }
  }
}
