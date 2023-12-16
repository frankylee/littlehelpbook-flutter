import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/shared/models/category.dart';
import 'package:littlehelpbook_flutter/shared/models/service.dart';
import 'package:littlehelpbook_flutter/shared/powersync/powersync.dart';

final servicesStreamProvider =
    StreamProvider.family<List<Service>, CategoryId?>((ref, categoryId) {
  final query = categoryId != null
      ? '''SELECT * FROM services WHERE EXISTS (
          SELECT * FROM providers WHERE providers.services LIKE '%'||services.id||'%'
        ) AND category_id = '${categoryId}'
        ORDER BY name_en ASC'''
      : '''SELECT * FROM services WHERE EXISTS (
          SELECT * FROM providers WHERE providers.services LIKE '%'||services.id||'%'
        ) ORDER BY name_en ASC''';
  return db.watch(query).map((res) {
    return res.map(Service.fromMap).toList(growable: false);
  });
});
