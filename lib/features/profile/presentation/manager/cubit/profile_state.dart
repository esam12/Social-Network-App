
import 'dart:io';

import 'package:equatable/equatable.dart';

enum ProfileStatus { initial, loading, success, error }

class ProfileState extends Equatable {
  final String userId;
  final String name;
  final String bio;
  final File? imageFile;
  final ProfileStatus status;
  final String? errorMessage;

  const ProfileState({
    required this.userId,
    required this.name,
    required this.bio,
    required this.imageFile,
    required this.status,
    this.errorMessage,
  });

  factory ProfileState.initial() => ProfileState(
    userId: '',
    name: '',
    bio: '',
    imageFile: null,
    status: ProfileStatus.initial,
    errorMessage: null,
  );

  ProfileState copyWith({
    String? userId,
    String? name,
    String? bio,
    File? imageFile,
    ProfileStatus? status,
    String? errorMessage,
  }) {
    return ProfileState(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      imageFile: imageFile ?? this.imageFile,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [userId, name, bio, imageFile?.path, status, errorMessage];
}
