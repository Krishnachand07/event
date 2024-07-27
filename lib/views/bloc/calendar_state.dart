part of 'calendar_bloc.dart';

class CalendarState extends Equatable {
  final bool loading;
  final List<Event> events;
  final List<Event> event;

  const CalendarState(
      {this.loading = false, this.events = const [], this.event = const []});

  CalendarState copyWith({
    List<Event>? event,
    bool? loading,
    List<Event>? events,
  }) =>
      CalendarState(
        event: event ?? this.event,
        loading: loading ?? this.loading,
        events: events ?? this.events,
      );

  @override
  List<Object> get props => [loading, events, event];
}
