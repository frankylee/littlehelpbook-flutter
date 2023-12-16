import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/shared/models/category.dart';
import 'package:littlehelpbook_flutter/shared/powersync/powersync.dart';

final categoriesStreamProvider = StreamProvider<List<Category>>((ref) {
  return db.watch(
    '''SELECT * FROM categories WHERE EXISTS (
      SELECT * FROM services WHERE EXISTS (
        SELECT * FROM providers WHERE providers.services LIKE '%'||services.id||'%'
      )
      AND services.category_id = categories.id
    ) ORDER BY name_en ASC''',
  ).map((res) => res.map(Category.fromMap).toList(growable: false));
});
