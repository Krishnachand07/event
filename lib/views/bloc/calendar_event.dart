part of 'calendar_bloc.dart';

class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object> get props => [];
}

class GetEvent extends CalendarEvent {}

class SpecificEvent extends CalendarEvent {
  final DateTime date;

  const SpecificEvent({required this.date});
  @override
  List<Object> get props => [date];
}
