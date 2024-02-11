import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

typedef UserId = String;

class UserPreferences extends Equatable {
  UserPreferences({
    required this.id,
    required this.appTheme,
    required this.locale,
    required this.createdAt,
    this.updatedAt,
  });

  factory UserPreferences.fromMap(Map<String, dynamic> data) {
    return UserPreferences(
      id: data['id'] as UserId,
      appTheme: _toThemeMode(data['app_theme']),
      locale: _toLocale(data['locale']),
      createdAt: data['created_at'] as String,
      updatedAt: data['updated_at'] as String?,
    );
  }

  factory UserPreferences.withDefault(UserId userId) {
    return UserPreferences(
      id: userId,
      appTheme: ThemeMode.system,
      locale: Locale('en'),
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );
  }

  final UserId id;
  final ThemeMode appTheme;
  final Locale locale;
  final String createdAt;
  final String? updatedAt;

  @override
  List<Object?> get props => [
        id,
        appTheme,
        locale,
        createdAt,
        updatedAt,
      ];

  @override
  bool? get stringify => true;

  UserPreferences copyWith({
    UserId? id,
    ThemeMode? appTheme,
    Locale? locale,
    String? createdAt,
    String? updatedAt,
  }) {
    return UserPreferences(
      id: id ?? this.id,
      appTheme: appTheme ?? this.appTheme,
      locale: locale ?? this.locale,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

/// Map the string type in the datastore to the Locale.
Locale _toLocale(dynamic data) {
  final theme = data as String?;
  switch (theme) {
    case 'es':
      return Locale('es');
    default:
      return Locale('en');
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
