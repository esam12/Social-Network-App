import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';
@JsonSerializable()
class UserEntity extends Equatable {
  @JsonKey(name: 'uid')
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

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  @override
  List<Object?> get props => [id, name, email, avatar, bio];

   Map<String, dynamic> toJson() {
    return {
      'name': name,
      'picture': avatar,
      'bio': bio,
    };
  }

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
}
