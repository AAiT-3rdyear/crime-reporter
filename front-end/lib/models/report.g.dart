// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Report _$ReportFromJson(Map<String, dynamic> json) => Report(
      title: json['title'] as String,
      location: json['location'] as String,
      time: json['time'] as String,
      description: json['description'] as String,
      imageURL: json['imageURL'] as String,
      reportTo: json['report_to'] as String,
      status: json['status'] as String,

      reporter: User.fromJson(json['reporter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'title': instance.title,
      'location': instance.location,
      'time': instance.time,
      'description': instance.description,
      'imageURL': instance.imageURL,
      'report_to': instance.reportTo,
       'status':instance.status,
      'reporter': instance.reporter.toJson(),
    };
