import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/shared/app_version/app_update_provider.dart';
import 'package:mockito/mockito.dart';

class CurrentAppUpdateNotifierMock extends AsyncNotifier<AppUpdateEnum>
    with Mock
    implements AppUpdateNotifier {
  @override
  FutureOr<AppUpdateEnum> build() {
    return AppUpdateEnum.current;
  }
}

class HardAppUpdateNotifierMock extends AsyncNotifier<AppUpdateEnum>
    with Mock
    implements AppUpdateNotifier {
  @override
  FutureOr<AppUpdateEnum> build() {
    return AppUpdateEnum.hardUpdate;
  }
}

class SoftAppUpdateNotifierMock extends AsyncNotifier<AppUpdateEnum>
    with Mock
    implements AppUpdateNotifier {
  @override
  FutureOr<AppUpdateEnum> build() {
    return AppUpdateEnum.softUpdate;
  }
}
