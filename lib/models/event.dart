import 'package:equatable/equatable.dart';
import 'package:event/models/entities/event_entity.dart';

enum EventStatus { confirm, cancel }

class Event extends Equatable {
  final String id;
  final String title;
  final String description;
  final EventStatus status;
  final DateTime? createdAt;
  final DateTime? startedAt;
  final int duration;
  final List<String>? images;

  const Event(
      {this.id = '',
      this.title = '',
      this.description = '',
      this.status = EventStatus.cancel,
      this.createdAt,
      this.startedAt,
      this.duration = -1,
      this.images});

  static Event fromEntity(EventEntity entity) => Event(
        id: entity.id,
        title: entity.title,
        description: entity.description,
        status: entity.status,
        createdAt: entity.createdAt,
        startedAt: entity.startedAt,
        duration: entity.duration,
        images: entity.images,
      );

  EventEntity toEntity() => EventEntity(
        id: id,
        title: title,
        description: description,
        status: status,
        createdAt: createdAt,
        startedAt: startedAt,
        duration: duration,
        images: images,
      );

  bool get isNotEmpty =>
      id.isNotEmpty &&
      title.isNotEmpty &&
      description.isNotEmpty &&
      !duration.isNaN;

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
