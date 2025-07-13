import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_app/core/services/firebase_auth_service.dart';
import 'package:social_network_app/features/auth/data/model/user_model.dart';
import 'package:social_network_app/features/auth/domain/repository/auth_repository.dart';
import 'package:social_network_app/features/auth/presentation/manager/user_bloc/user_event.dart';
import 'package:social_network_app/features/auth/presentation/manager/user_bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthRepository authRepository;

  UserBloc({required this.authRepository}) : super(UserState.initial()) {
    on<SignInWithGoogleEvent>(onSignInWithGoogleEvent);
    on<UserEvent>(onGetUserEvent);
    on<SignOutEvent>(onSignOutEvent);
  }

  Future<void> onSignInWithGoogleEvent(
    SignInWithGoogleEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(userStatus: UserStatus.loading));
    final result = await authRepository.signInWithGoogle();
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            userStatus: UserStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
      (userEntity) {
        emit(
          state.copyWith(
            userStatus: UserStatus.success,
            userEntity: userEntity,
          ),
        );
      },
    );
  }

  Future<void> onGetUserEvent(UserEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(userStatus: UserStatus.loading));
    FirebaseAuth.instance.authStateChanges().listen((firebaseUser) async {
      if (firebaseUser != null) {
        // إذا أردت بيانات Firestore:
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseUser.uid)
            .get();
        final user = UserModel.fromSnapshot(doc);
        emit(state.copyWith(userStatus: UserStatus.success, userEntity: user));
      } else {
        emit(state.copyWith(userStatus: UserStatus.logout));
      }
    });
  }

  Future<void> onSignOutEvent(
    SignOutEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(userStatus: UserStatus.loading));

    var result = await authRepository.logOut();
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            userStatus: UserStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
      (userEntity) {
        emit(state.copyWith(userStatus: UserStatus.logout));
      },
    );
    emit(state.copyWith(userStatus: UserStatus.logout));
  }
}
