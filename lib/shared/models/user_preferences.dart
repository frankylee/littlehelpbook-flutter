import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

typedef UserId = String;

class UserPreferences extends Equatable {
  UserPreferences({
    required this.id,
    required this.appTheme,
    required this.createdAt,
    this.updatedAt,
  });

  factory UserPreferences.fromMap(Map<String, dynamic> data) {
    return UserPreferences(
      id: data['id'] as UserId,
      appTheme: _toThemeMode(data['app_theme']),
      createdAt: data['created_at'] as String,
      updatedAt: data['updated_at'] as String?,
    );
  }

  final UserId id;
  final ThemeMode appTheme;
  final String createdAt;
  final String? updatedAt;

  @override
  List<Object?> get props => [
        id,
        appTheme,
        createdAt,
        updatedAt,
      ];

  @override
  bool? get stringify => true;

  UserPreferences copyWith({
    UserId? id,
    ThemeMode? appTheme,
    String? createdAt,
    String? updatedAt,
  }) {
    return UserPreferences(
      id: id ?? this.id,
      appTheme: appTheme ?? this.appTheme,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

/// Map the string type in the datastore to the ThemeMode enum.
ThemeMode _toThemeMode(dynamic data) {
  final theme = data as String;
  switch (theme) {
    case 'dark':
      return ThemeMode.dark;
    case 'light':
      return ThemeMode.light;
    default:
      return ThemeMode.system;
  }
}
