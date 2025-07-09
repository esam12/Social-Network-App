import 'package:social_network_app/features/auth/domain/entity/user_entity.dart';

abstract class UserEvent {
}

class SignInWithGoogleEvent extends UserEvent {}

class GetUserEvent extends UserEvent {}

class SignOutEvent extends UserEvent {}

class UpdateUserEvent extends UserEvent {
  final UserEntity userEntity;
  UpdateUserEvent({required this.userEntity});
}