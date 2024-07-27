import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event/controllers/service_repository.dart';
import 'package:event/models/entities/event_entity.dart';
import 'package:event/models/event.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final ServiceRepository repository;
  CalendarBloc(this.repository) : super(const CalendarState()) {
    on<CalendarEvent>((event, emit) async {
      if (event is GetEvent) {
        await _mapGetEventToState(event, emit);
      } else if (event is SpecificEvent) {
        _mapSpecificEvent(event, emit);
      }
    });
  }

  Future<void> _mapGetEventToState(
      GetEvent event, Emitter<CalendarState> emit) async {
    emit(state.copyWith(loading: true));
    try {
      final response = await repository.getEvents();
      if (response["data"] != null) {
        emit(state.copyWith(
            loading: false,
            events: (response["data"] as List)
                .map((data) => Event.fromEntity(EventEntity.fromJson(data)))
                .toList()));
        return;
      }
      emit(state.copyWith(loading: false));
    } on Exception catch (e) {
      emit(state.copyWith(loading: false));
      throw Exception(e);
    }
  }

  void _mapSpecificEvent(SpecificEvent event, Emitter<CalendarState> emit) {
    final particularEvent = state.events.where(
      (calendarEvent) {
        final startedAt = DateTime(calendarEvent.startedAt!.year,
            calendarEvent.startedAt!.month, calendarEvent.startedAt!.day);
        final date =
            DateTime(event.date.year, event.date.month, event.date.day);
        if (startedAt.compareTo(date) == 0) {
          return true;
        } else {
          return false;
        }
      },
    ).toList();
    emit(state.copyWith(event: particularEvent));
  }
}
