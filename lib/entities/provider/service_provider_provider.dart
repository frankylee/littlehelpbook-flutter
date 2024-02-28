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

final providerByIdProvider =
    StreamProvider.family<ServiceProvider, ServiceProviderId>((ref, id) {
  return db.watch(
    '''SELECT * FROM providers where id = '$id' ''',
  ).map((res) => res.map(ServiceProvider.fromMap).first);
});

final favoriteProvidersStreamProvider =
    StreamProvider<List<ServiceProvider>>((ref) {
  return db.watch('''
    SELECT * FROM favorites f
    LEFT JOIN providers p ON p.id = f.provider_id
    ORDER BY p.name ASC
  ''').map((res) => res.map(ServiceProvider.fromMap).toList(growable: false));
});

final emergencyCrisisLinesProvider =
    StreamProvider<List<ServiceProvider>>((ref) {
  return db.watch(
    '''SELECT * FROM providers p
      WHERE EXISTS (
        SELECT s.id FROM categories c
        LEFT JOIN services s ON s.category_id = c.id
        WHERE c.name_en = 'Crisis Lines'
        AND p.services LIKE '%'||s.id||'%'
      )
      ORDER BY p.name ASC''',
  ).map((res) => res.map(ServiceProvider.fromMap).toList(growable: false));
});
