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
    id: json  ['id'],
    title: json['title'],
    description: json['description'],
    date: DateTime.parse(json['time']),
    attendees: List<UserEntity>.from(
      json['attendees']?.map((x) => UserEntity.fromJson(x)) ?? [],
    ),
    admin: UserEntity.fromJson(json['admin']),
    isFinished: json['isFinished'],
    isCancelled: json['isCancelled'],
    latitude: json['latitude']?.toDouble(),
    longitude: json['longitude']?.toDouble(),
  );

  // To map
  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'description': description,
    'time': date.toIso8601String(),
    'attendees': attendees.map((x) => x.toMap()).toList(),
    'admin': admin.toMap(),
    'isFinished': isFinished,
    'isCancelled': isCancelled,
    'latitude': latitude,
    'longitude': longitude,
  };
}
