import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/shared/models/user_preferences.dart';
import 'package:littlehelpbook_flutter/shared/powersync/powersync.dart';

/// We do not require users to authenticate to the application at this time. As
/// such, we will use the device's unique identifer or model as the user id for
/// the local-only user preferences table.
final userIdProvider = FutureProvider<UserId>((ref) async {
  final deviceInfo = DeviceInfoPlugin();
  return Platform.isAndroid
      ? await deviceInfo.androidInfo.then((info) => info.serialNumber)
      : await deviceInfo.iosInfo
          .then((info) => info.identifierForVendor ?? info.model);
});

final userPreferencesProvider =
    AsyncNotifierProvider<UserPreferencesNotifier, UserPreferences>(
  UserPreferencesNotifier.new,
);

class UserPreferencesNotifier extends AsyncNotifier<UserPreferences> {
  late UserId userId;

  @override
  FutureOr<UserPreferences> build() async {
    userId = await ref.read(userIdProvider.future);
    final result = await db
        .getOptional("SELECT * FROM user_preferences WHERE id = '$userId'");
    // If the preferences have not yet been created, create with default values.
    if (result == null) {
      await _insert();
      return UserPreferences(
        id: userId,
        appTheme: ThemeMode.system,
        createdAt: DateTime.now().toIso8601String(),
      );
    }
    // Otherwise return the user's preferences.
    return UserPreferences.fromMap(result);
  }

  Future<void> updateAppTheme(ThemeMode theme) async {
    await db.execute('''
      UPDATE user_preferences 
      SET app_theme = '${theme.name}', updated_at = datetime()
      WHERE id = '$userId'
    ''');
    await update((state) => state.copyWith(appTheme: theme));
  }

  Future<void> _insert() async {
    await db.execute('''
      INSERT INTO user_preferences(id, app_theme, created_at, updated_at)
      VALUES('${userId}', '${ThemeMode.system.name}', datetime(), datetime())
    ''');
  }
}
