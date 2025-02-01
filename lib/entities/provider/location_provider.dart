import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/shared/models/location.dart';
import 'package:littlehelpbook_flutter/shared/models/provider.dart';
import 'package:littlehelpbook_flutter/shared/models/schedule.dart';
import 'package:littlehelpbook_flutter/shared/powersync/powersync.dart';

final locationsStreamProvider = StreamProvider<List<Location>>((ref) {
  return db
      .watch('SELECT * FROM locations ORDER BY name ASC')
      .map((res) => res.map(Location.fromMap).toList(growable: false));
});

final locationByServiceProviderProvider =
    StreamProvider.family<List<Location>, ServiceProviderId>((ref, id) {
  return db.watch(
    '''SELECT * FROM locations WHERE provider_id = '${id}' ORDER BY name ASC''',
  ).map((res) => res.map(Location.fromMap).toList(growable: false));
});

final schedulesByLocationProvider =
    StreamProvider.family<List<Schedule>, LocationId>((ref, id) {
  return db
      .watch("SELECT * FROM schedules WHERE location_id = '${id}'")
      .map((res) {
    final schedules = res
        .map(Schedule.fromMap)
        .where((e) => e.isActive())
        .toList(growable: false);
    schedules.sort();
    return schedules;
  });
});
