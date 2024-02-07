import 'package:littlehelpbook_flutter/app/toggle/lhb_toggles.dart';

void overrideToggles({
  Map<String, dynamic>? attributes,
  Map<String, dynamic>? overrides,
  List<Map<String, dynamic>>? rules,
  Map<String, dynamic>? seeds,
}) {
  LhbToggles.shared.initForTests(
    attributes: attributes,
    overrides: overrides,
    rules: rules,
    seeds: seeds,
  );
}
