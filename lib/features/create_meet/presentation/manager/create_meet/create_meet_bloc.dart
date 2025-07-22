import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_app/features/create_meet/presentation/manager/create_meet/create_meet_event.dart';
import 'package:social_network_app/features/create_meet/presentation/manager/create_meet/create_meet_state.dart';
import 'package:social_network_app/features/meet/domain/repository/meet_repository.dart';

class CreateMeetBloc extends Bloc<CreateMeetEvent, CreateMeetState> {
  final MeetRepository meetRepository;
  CreateMeetBloc({required this.meetRepository})
    : super(CreateMeetState.initial()) {
    on<CreateMeetEvent>(onCreateMeetEvent);
  }

  Future<void> onCreateMeetEvent(
    CreateMeetEvent event,
    Emitter<CreateMeetState> emit,
  ) async {
    emit(state.copyWith(status: CreateMeetStatus.loading));
    final result = await meetRepository.createMeet(
      title: event.title,
      description: event.description,
      time: event.time,
      location: event.location,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: CreateMeetStatus.error,
          errorMessage: failure.message,
        ),
      ),
      (r) => emit(state.copyWith(status: CreateMeetStatus.success)),
    );
  }
}
