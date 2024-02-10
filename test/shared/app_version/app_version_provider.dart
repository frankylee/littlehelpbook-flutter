import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/shared/app_version/app_version_provider.dart';
import 'package:mockito/mockito.dart';

class CurrentAppVersionNotifierMock extends AsyncNotifier<AppVersionEnum>
    with Mock
    implements AppVersionNotifier {
  @override
  FutureOr<AppVersionEnum> build() {
    return AppVersionEnum.current;
  }
}

class HardAppVersionNotifierMock extends AsyncNotifier<AppVersionEnum>
    with Mock
    implements AppVersionNotifier {
  @override
  FutureOr<AppVersionEnum> build() {
    return AppVersionEnum.hardUpdate;
  }
}

class SoftAppVersionNotifierMock extends AsyncNotifier<AppVersionEnum>
    with Mock
    implements AppVersionNotifier {
  @override
  FutureOr<AppVersionEnum> build() {
    return AppVersionEnum.softUpdate;
  }
}
