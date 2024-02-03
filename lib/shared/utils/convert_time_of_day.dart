import 'package:flutter/material.dart';

/// Convert a timestamp to TimeOfDay.
TimeOfDay? convertTextToTimeOfDay(String? text) {
  if (text == null || text.isEmpty) return null;
  final [hour, minute, _] = text.split(':');
  return TimeOfDay(hour: int.parse(hour), minute: int.parse(minute));
}
