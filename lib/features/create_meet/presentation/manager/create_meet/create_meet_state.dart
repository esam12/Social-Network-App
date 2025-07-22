import 'package:equatable/equatable.dart';
import 'package:social_network_app/features/meet/domain/entity/meet_entity.dart';

enum CreateMeetStatus { initial, loading, success, error }

class CreateMeetState extends Equatable {
  final CreateMeetStatus status;
  final String? errorMessage;
  final MeetEntity? meet;

  const CreateMeetState._({
    this.status = CreateMeetStatus.initial,
    this.errorMessage,
    this.meet,
  });

  factory CreateMeetState.initial() => const CreateMeetState._(status: CreateMeetStatus.initial);

  CreateMeetState copyWith({
    CreateMeetStatus? status,
    String? errorMessage,
    MeetEntity? meet,
  }) => CreateMeetState._(
    status: status ?? this.status,
    errorMessage: errorMessage ?? this.errorMessage,
    meet: meet ?? this.meet,
  );

  @override
  List<Object?> get props => [status, errorMessage, meet];
}
