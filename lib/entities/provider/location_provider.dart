import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/shared/models/location.dart';
import 'package:littlehelpbook_flutter/shared/models/provider.dart';
import 'package:littlehelpbook_flutter/shared/powersync/powersync.dart';

final locationsStreamProvider = StreamProvider<List<Location>>((ref) {
  return db
      .watch("SELECT * FROM locations ORDER BY name ASC GROUP BY provider_id")
      .map((res) => res.map(Location.fromMap).toList(growable: false));
});

final locationByServiceProviderProvider =
    StreamProvider.family<List<Location>, ServiceProviderId>((ref, id) {
  return db.watch(
    '''SELECT * FROM locations WHERE provider_id = '${id}' ORDER BY name ASC''',
  ).map((res) => res.map(Location.fromMap).toList(growable: false));
});
