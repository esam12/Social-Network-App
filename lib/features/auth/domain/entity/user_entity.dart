import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String? email;
  final String? avatar;
  final String? bio;

  const UserEntity({
    required this.id,
    required this.name,
    this.email,
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

  // Empty Constructor
  const UserEntity.empty()
      : id = '',
        name = '',
        email = '',
        avatar = '',
        bio = '';

  toMap() => {
    'id': id,
    'name': name,
    'email': email,
    'avatar': avatar,
    'bio': bio,
  };

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    avatar: json['avatar'],
    bio: json['bio'],
  );
}
