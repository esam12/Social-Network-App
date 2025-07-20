import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_app/features/meet/domain/repository/meet_repository.dart';
import 'package:social_network_app/features/profile/presentation/manager/last_meets/last_meets_events.dart';
import 'package:social_network_app/features/profile/presentation/manager/last_meets/last_meets_state.dart';

class LastMeetsBoc extends Bloc<LastMeetsEvents, LastMeetsState> {
  final MeetRepository repository;

  LastMeetsBoc({required this.repository}) : super(LastMeetsState.initial()) {
    on<GetLastMeetsEvent>(onGetLastMeetsEvent);
  }

  Future<void> onGetLastMeetsEvent(
    GetLastMeetsEvent event,
    Emitter<LastMeetsState> emit,
  ) async {
    if (state.status == LastMeetsStatus.loading || state.isLastPage) {
      return;
    }
    if (event.refresh) {
      emit(state.copyWith(currentPage: 1, isLastPage: false, lastMeets: []));
    }
    emit(state.copyWith(status: LastMeetsStatus.loading));

    var result = await repository.getLastMeets(
      page: state.currentPage,
      limit: 10,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: LastMeetsStatus.error,
          errorMessage: failure.message,
        ),
      ),
      (lastMeets) => emit(
        state.copyWith(
          status: LastMeetsStatus.success,
          lastMeets: [...(state.lastMeets ?? []), ...lastMeets],
          isLastPage: lastMeets.length < 10,
          currentPage: state.currentPage + 1,
        ),
      ),
    );
  }
}
