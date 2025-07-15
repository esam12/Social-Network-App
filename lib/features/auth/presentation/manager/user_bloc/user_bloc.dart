import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_app/core/errors/failures.dart';
import 'package:social_network_app/features/auth/domain/entity/user_entity.dart';
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
    return emit.onEach<Either<Failure, UserEntity?>>(
      authRepository.authStateChanges(), 
      onData: (either) => either.fold(
        (failure) => emit(
          state.copyWith(
            userStatus: UserStatus.error,
            errorMessage: failure.message,
          ),
        ),
        (userEntity) {
          if (userEntity == null) {
            emit(state.copyWith(userStatus: UserStatus.logout));
          } else {
            emit(
              state.copyWith(
                userStatus: UserStatus.success,
                userEntity: userEntity,
              ),
            );
          }
        },
      ),
      onError: (_, __) => emit(state.copyWith(userStatus: UserStatus.error)),
    );
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
  }
}
