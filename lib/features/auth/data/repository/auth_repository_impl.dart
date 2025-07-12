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
  final FirebaseAuthService firebaseAuthService;
  final DatabaseService databaseService;

  AuthRepositoryImpl({
    required this.databaseService,
    required this.firebaseAuthService,
  });

  @override
  Future<Either<ServerFailure, UserEntity>> signInWithGoogle() async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithGoogle();

      var userEntity = UserModel.fromFirebaseUser(user);
      var isUserExist = await databaseService.checkIfDataExists(
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
        await firebaseAuthService.deleteUser();
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
    await databaseService.addData(
      path: BackendEndpoint.addUserData,
      data: user.toMap(),
      documentId: user.id,
    );
  }

  @override
  Future<UserEntity> getUserData({required String id}) async {
    var userData = await databaseService.getData(
      path: BackendEndpoint.getUsersData,
      documentId: id,
    );
    return UserModel.fromJson(userData);
  }

  @override
  Future saveUserData({required UserEntity user}) async {
    var jsonData = jsonEncode(UserModel.fromEntity(user).toMap());
    await SharedPreferencesSingleton.setString(kUserData, jsonData);
  }
}
