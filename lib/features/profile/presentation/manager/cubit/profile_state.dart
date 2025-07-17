import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_network_app/features/auth/domain/entity/user_entity.dart';

enum ProfileStatus { initial, loading, success, error }

class ProfileState extends Equatable {
  final UserEntity user;
  // final XFile? imageFile;
  final ProfileStatus status;
  final String? errorMessage;

  const ProfileState({
    required this.user,
    // required this.imageFile,
    required this.status,
    this.errorMessage,
  });

  factory ProfileState.initial() => ProfileState(
    user: UserEntity.empty(),
    // imageFile: null,
    status: ProfileStatus.initial,
    errorMessage: null,
  );

  ProfileState copyWith({
    UserEntity? user,
    XFile? imageFile,
    ProfileStatus? status,
    String? errorMessage,
  }) {
    return ProfileState(
      user: user ?? this.user,
      // imageFile: imageFile ?? this.imageFile,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    user, // imageFile?.path,
    status, errorMessage,
  ];
}
