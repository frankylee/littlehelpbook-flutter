import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/app/toggle/lhb_toggles.dart';
import 'package:package_info_plus/package_info_plus.dart';

enum AppVersionEnum {
  current,
  hardUpdate,
  softUpdate,
}

final appVersionProvider =
    AsyncNotifierProvider<AppVersionNotifier, AppVersionEnum>(
  AppVersionNotifier.new,
);

class AppVersionNotifier extends AsyncNotifier<AppVersionEnum> {
  @override
  FutureOr<AppVersionEnum> build() async {
    final currentVersion = (await PackageInfo.fromPlatform()).version;
    if (!_isSupported(currentVersion, LhbToggles.appVersionHard)) {
      return AppVersionEnum.hardUpdate;
    }
    if (!_isSupported(currentVersion, LhbToggles.appVersionSoft)) {
      return AppVersionEnum.softUpdate;
    }
    return AppVersionEnum.current;
  }

  bool isHardUpdate() {
    return state.maybeWhen(
      data: (data) => data == AppVersionEnum.hardUpdate,
      orElse: () => false,
    );
  }

  bool isSoftUpdate() {
    return state.maybeWhen(
      data: (data) => data == AppVersionEnum.softUpdate,
      orElse: () => false,
    );
  }

  bool _isSupported(String currentVersion, String minVersion) {
    if (currentVersion == minVersion) return true;
    final current = _parseVersion(currentVersion);
    final min = _parseVersion(minVersion);
    for (int i = 0; i < current.length; i++) {
      if (current[i] > min[i]) {
        return true;
      }
    }
    return false;
  }

  List<int> _parseVersion(String version) {
    return version.split('.').map((x) => int.tryParse(x) ?? 0).toList();
  }
}
