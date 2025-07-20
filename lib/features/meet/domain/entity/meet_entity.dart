import 'package:equatable/equatable.dart';
import 'package:social_network_app/features/auth/domain/entity/user_entity.dart';

class MeetEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final List<UserEntity> attendees;
  final UserEntity admin;
  final bool isFinished;
  final bool isCancelled;
  final double? latitude;
  final double? longitude;

  const MeetEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.attendees,
    required this.admin,
    required this.isFinished,
    required this.isCancelled,
    this.latitude,
    this.longitude,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    date,
    attendees,
    admin,
    isFinished,
    isCancelled,
    latitude,
    longitude,
  ];

  factory MeetEntity.fromJson(Map<String, dynamic> json) => MeetEntity(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    date: DateTime.parse(json['date']),
    attendees: List<UserEntity>.from(json['attendees'].map((x) => UserEntity.fromJson(x))),
    admin: UserEntity.fromJson(json['admin']),
    isFinished: json['isFinished'],
    isCancelled: json['isCancelled'],
    latitude: json['latitude']?.toDouble(),
    longitude: json['longitude']?.toDouble(),
  );
}
