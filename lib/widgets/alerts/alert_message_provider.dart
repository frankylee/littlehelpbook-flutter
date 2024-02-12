import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/app/toggle/lhb_toggles.dart';

final alertMessageToggleProvider = Provider<String?>((ref) {
  final alertMessage = LhbToggles.alertMessage;
  return alertMessage != null && alertMessage.isNotEmpty ? alertMessage : null;
});
