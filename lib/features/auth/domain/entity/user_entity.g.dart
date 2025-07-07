// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
  id: json['uid'] as String,
  name: json['name'] as String,
  email: json['email'] as String,
  avatar: json['picture'] as String,
  bio: json['bio'] as String?,
);

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'uid': instance.id,
      'name': instance.name,
      'email': instance.email,
      'picture': instance.avatar,
      'bio': instance.bio,
    };
