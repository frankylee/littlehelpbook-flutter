import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:littlehelpbook_flutter/shared/extensions/build_context.ext.dart';
import 'package:littlehelpbook_flutter/shared/models/location.dart';
import 'package:littlehelpbook_flutter/shared/utils/convert_text_to_datetime.dart';
import 'package:littlehelpbook_flutter/shared/utils/convert_text_to_list.dart';
import 'package:littlehelpbook_flutter/shared/utils/convert_time_of_day.dart';
import 'package:littlehelpbook_flutter/shared/utils/get_ordinal_suffix.dart';

typedef ScheduleId = String;

class Schedule extends Equatable implements Comparable<Schedule> {
  Schedule({
    required this.id,
    required this.weekDays,
    this.numericDay,
    this.opensAt,
    this.closesAt,
    this.validFrom,
    this.validTo,
    required this.locationId,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Schedule.fromMap(Map<String, dynamic> data) {
    return Schedule(
      id: data['id'] as ScheduleId,
      weekDays: convertTextToList(data['week_days'] as String?),
      numericDay: int.tryParse(data['numeric_day'].toString()),
      opensAt: convertTextToTimeOfDay(data['opens_at'] as String?),
      closesAt: convertTextToTimeOfDay(data['closes_at'] as String?),
      validFrom: convertTextToDateTime(data['valid_to'] as String?),
      validTo: convertTextToDateTime(data['valid_to'] as String?),
      locationId: data['location_id'] as String,
      createdAt: data['created_at'] as String,
      updatedAt: data['updated_at'] as String?,
      deletedAt: data['deleted_at'] as String?,
    );
  }

  final ScheduleId id;
  final List<String> weekDays;
  final int? numericDay;
  final TimeOfDay? opensAt;
  final TimeOfDay? closesAt;
  final DateTime? validFrom;
  final DateTime? validTo;
  final LocationId locationId;
  final String createdAt;
  final String? updatedAt;
  final String? deletedAt;

  /// Sort Schedules by hours of operation.
  @override
  int compareTo(Schedule other) {
    // By default, compare by most recurring schedule.
    int result = other.weekDays.length.compareTo(this.weekDays.length);
    // Then compare by time of day opened in ascending order.
    if (this.opensAt != null && other.opensAt != null) {
      result += this.opensAt!.hour.compareTo(other.opensAt!.hour);
    }
    // If the schedules are day of month only, sort ascending.
    if (this.isDayOfMonth() && other.isDayOfMonth()) {
      result += this.numericDay!.compareTo(other.numericDay!);
    }
    return result;
  }

  @override
  List<Object?> get props => [
        id,
        weekDays,
        numericDay,
        opensAt,
        closesAt,
        validFrom,
        validTo,
        locationId,
        createdAt,
        updatedAt,
        deletedAt,
      ];

  @override
  bool? get stringify => true;

  Schedule copyWith({
    ScheduleId? id,
    List<String>? weekDays,
    int? numericDay,
    TimeOfDay? opensAt,
    TimeOfDay? closesAt,
    DateTime? validFrom,
    DateTime? validTo,
    LocationId? locationId,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
  }) {
    return Schedule(
      id: id ?? this.id,
      weekDays: weekDays ?? this.weekDays,
      numericDay: numericDay ?? this.numericDay,
      opensAt: opensAt ?? this.opensAt,
      closesAt: closesAt ?? this.closesAt,
      validFrom: validFrom ?? this.validFrom,
      validTo: validTo ?? this.validTo,
      locationId: locationId ?? this.locationId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  String? formatSchedule(BuildContext context) {
    if (weekDays.isEmpty && numericDay == null) return null;
    if (isDayOfMonth()) {
      // Example: Monthly on the 11th
      return context.l10n
          .monthlyOnTheOrdinal('$numericDay${getOrdinalSuffix(numericDay!)}');
    }
    if (isOccurrenceOfWeekDay()) {
      // Example: 4th Saturday
      return context.l10n.occurrenceOfWeekDay(
        '$numericDay${getOrdinalSuffix(numericDay!)}',
        '${weekDays[0][0].toUpperCase()}${weekDays[0].substring(1).toLowerCase()}',
      );
    }
    // Present the entire list of days by first letter, and remove the parentheses.
    final result = weekDays.map((e) => e[0]).toString();
    return result.substring(1, result.length - 1);
  }

  /// Validate current schedule. If not active, then return false.
  bool isActive() {
    final today = DateTime.now();
    if (validFrom != null && validTo != null) {
      if (today.isBefore(validTo!) || today.isAfter(validFrom!)) return false;
    }
    return true;
  }

  bool isDayOfMonth() {
    return weekDays.isEmpty && numericDay != null;
  }

  bool isOccurrenceOfWeekDay() {
    return weekDays.isNotEmpty && numericDay != null;
  }
}
