import 'package:equatable/equatable.dart';
import 'package:social_network_app/features/auth/domain/entity/user_entity.dart';

enum UserStatus { initial, loading, success, error, logout }

class UserState extends Equatable {
  final UserStatus userStatus;
  final String? errorMessage;
  final UserEntity? userEntity;

  const UserState._({
    required this.userStatus,
    this.errorMessage,
    this.userEntity,
  });

  factory UserState.initial() =>
      const UserState._(userStatus: UserStatus.initial);

  UserState copyWith({
    UserStatus? userStatus,
    String? errorMessage,
    UserEntity? userEntity,
  }) => UserState._(
    userStatus: userStatus ?? this.userStatus,
    errorMessage: errorMessage ?? this.errorMessage,
    userEntity: userEntity ?? this.userEntity,
  );

  @override
  List<Object?> get props => [userStatus, errorMessage, userEntity];
}
