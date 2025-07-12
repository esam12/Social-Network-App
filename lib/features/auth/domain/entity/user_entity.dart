import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String avatar;
  final String? bio;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
    this.bio,
  });

  @override
  List<Object?> get props => [id, name, email, avatar, bio];

  UserEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? avatar,
    String? bio,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      bio: bio ?? this.bio,
    );
  }

  toMap() => {
    'uid': id,
    'name': name,
    'email': email,
    'avatar': avatar,
    'bio': bio,
  };
}
