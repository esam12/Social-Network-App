// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
  id: json['_id'] as String,
  name: json['name'] as String,
  email: json['email'] as String,
  avatar: json['avatar'] as String,
  bio: json['bio'] as String?,
);

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'avatar': instance.avatar,
      'bio': instance.bio,
    };
