import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/app/toggle/lhb_toggles.dart';
import 'package:littlehelpbook_flutter/shared/app_version/app_update_provider.dart';
import 'package:littlehelpbook_flutter/widgets/alerts/alert_message_provider.dart';

final refreshTogglesProvider =
    AutoDisposeNotifierProvider<RefreshTogglesNotifier, void>(
  RefreshTogglesNotifier.new,
);

class RefreshTogglesNotifier extends AutoDisposeNotifier<void> {
  RefreshTogglesNotifier();

  Timer? _togglesTimer;

  @override
  void build() {
    if (_togglesTimer == null || !_togglesTimer!.isActive) {
      _togglesTimer = Timer.periodic(const Duration(minutes: 20), (_) async {
        await LhbToggles.shared.refresh();
        // Refresh the alert message toggle provider to show/hide the alert message.
        ref.invalidate(alertMessageToggleProvider);
        // Refresh the app update provider to enforce hard app updates on route change.
        ref.invalidate(appUpdateProvider);
      });
    }
  }
}
