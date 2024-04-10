import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/shared/app_version/app_update_provider.dart';
import 'package:mockito/mockito.dart';

class AppUpdateNotifierMock extends AsyncNotifier<AppUpdateEnum>
    with Mock
    implements AppUpdateNotifier {
  AppUpdateNotifierMock({required this.returnValue});

  final AppUpdateEnum returnValue;

  @override
  FutureOr<AppUpdateEnum> build() {
    return returnValue;
  }
}
