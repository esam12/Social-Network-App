import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_app/features/auth/domain/repository/auth_repository.dart';
import 'package:social_network_app/features/auth/domain/repository/user_repository.dart';
import 'package:social_network_app/features/auth/presentation/manager/user_bloc/user_event.dart';
import 'package:social_network_app/features/auth/presentation/manager/user_bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  UserBloc({required this.authRepository, required this.userRepository})
    : super(UserState.initial()) {
    on<SignInWithGoogleEvent>(onSignInWithGoogleEvent);
    on<GetUserEvent>(onGetUserEvent);
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

  Future<void> onGetUserEvent(
    GetUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(userStatus: UserStatus.loading));
    final result = await userRepository.getUser();
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
}
