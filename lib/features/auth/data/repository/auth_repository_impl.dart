import 'package:dio/dio.dart';
import 'package:social_network_app/core/common/models/either.dart';
import 'package:social_network_app/core/common/models/failure.dart';
import 'package:social_network_app/core/services/data_service.dart';
import 'package:social_network_app/features/auth/domain/entity/user_entity.dart';
import 'package:social_network_app/features/auth/domain/repository/auth_repository.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthService firebaseAuthService;
  final DatabaseService databaseService;

  AuthRepositoryImpl({
    required this.databaseService,
    required this.firebaseAuthService,
  });

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credentail = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final firebaseCredential = await FirebaseAuth.instance
          .signInWithCredential(credentail);

      final token = await firebaseCredential.user?.getIdToken();
      if (token != null) {
        return Right(await authRemoteDatasource.signInWithGoogle(token));
      } else {
        return Left(AuthFailure(message: 'Auth Failure!'));
      }
    } on DioException catch (e) {
      return Left(AuthFailure(message: e.response?.data['message'] ?? ''));
    } catch (e) {
      return Left(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logOut() async {
    try {
      FirebaseAuth.instance.signOut();
      return Right(null);
    } on DioException catch (e) {
      return Left(AuthFailure(message: e.response?.data['message'] ?? ''));
    } catch (e) {
      return Left(AuthFailure(message: e.toString()));
    }
  }
}
