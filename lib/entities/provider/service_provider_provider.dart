import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/shared/models/provider.dart';
import 'package:littlehelpbook_flutter/shared/models/service.dart';
import 'package:littlehelpbook_flutter/shared/powersync/powersync.dart';

final providersStreamProvider = StreamProvider<List<ServiceProvider>>((ref) {
  return db
      .watch("SELECT * FROM providers ORDER BY name ASC")
      .map((res) => res.map(ServiceProvider.fromMap).toList(growable: false));
});

final providersByServiceProvider =
    StreamProvider.family<List<ServiceProvider>, ServiceId>((ref, id) {
  return db.watch(
    '''SELECT * FROM providers WHERE services LIKE '%${id}%' ORDER BY name ASC''',
  ).map((res) => res.map(ServiceProvider.fromMap).toList(growable: false));
});
