import 'package:equatable/equatable.dart';
import 'package:event/models/event.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_entity.g.dart';

EventStatus statusFromJson(json) {
  if (json != null) {
    switch (json) {
      case 'Confirmed':
        return EventStatus.confirm;
      case 'Cancelled':
        return EventStatus.cancel;
    }
  }
  return EventStatus.cancel;
}

String statusToJson(EventStatus? status) {
  if (status != null) {
    switch (status) {
      case EventStatus.confirm:
        return 'Confirmed';
      case EventStatus.cancel:
        return 'Cancelled';
    }
  }
  return 'Cancelled';
}

DateTime dateFromJson(json) {
  if (json != null) {
    return DateTime.parse(json);
  }
  return DateTime.now();
}

String dateToJson(DateTime? date) {
  if (date != null) {
    return DateFormat('yyyy-MM-ddThh:mm:ss.sssZ').format(date);
  }
  return '';
}

@JsonSerializable(explicitToJson: true)
class EventEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  @JsonKey(name: 'status', fromJson: statusFromJson, toJson: statusToJson)
  final EventStatus status;
  @JsonKey(name: 'createdAt', fromJson: dateFromJson, toJson: dateToJson)
  final DateTime? createdAt;
  @JsonKey(name: 'startAt')
  final DateTime? startedAt;
  final int duration;
  final List<String>? images;

  const EventEntity(
      {this.id = '',
      this.title = '',
      this.description = '',
      this.status = EventStatus.cancel,
      this.createdAt,
      this.startedAt,
      this.duration = -1,
      this.images});

  factory EventEntity.fromJson(Map<String, dynamic> json) =>
      _$EventEntityFromJson(json);

  Map<String, dynamic> toJson() => _$EventEntityToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        status,
        createdAt,
        startedAt,
        duration,
        images,
      ];
}
