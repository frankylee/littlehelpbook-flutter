import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/entities/category/category.dart';
import 'package:littlehelpbook_flutter/shared/powersync/powersync.dart';
import 'package:logging/logging.dart';

final categoryClientProvider = Provider((ref) => CategoryClient());

/// The Category Client manages interactions with the datasource.
class CategoryClient {
  final _logger = Logger('CategoryClient');

  Future<List<Category>> getAll() async {
    try {
      final result = await db
          .getAll('SELECT * FROM categories')
          .then((res) => res.map(Category.fromMap).toList());
      result.sort();
      return result;
    } catch (e) {
      _logger.info('Categories could not be retrieved', e);
      // TODO: Support better error handling. For now, this will be bubbled
      // up to be caught and handled before being presented in the UI.
      rethrow;
    }
  }
}
