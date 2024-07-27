// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventEntity _$EventEntityFromJson(Map<String, dynamic> json) => EventEntity(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      status: json['status'] == null
          ? EventStatus.cancel
          : statusFromJson(json['status']),
      createdAt: dateFromJson(json['createdAt']),
      startedAt: json['startAt'] == null
          ? null
          : DateTime.parse(json['startAt'] as String),
      duration: (json['duration'] as num?)?.toInt() ?? -1,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$EventEntityToJson(EventEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'status': statusToJson(instance.status),
      'createdAt': dateToJson(instance.createdAt),
      'startAt': instance.startedAt?.toIso8601String(),
      'duration': instance.duration,
      'images': instance.images,
    };
