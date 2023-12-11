import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/entities/category/category.dart';
import 'package:littlehelpbook_flutter/entities/service/service.dart';
import 'package:littlehelpbook_flutter/shared/powersync/powersync.dart';
import 'package:logging/logging.dart';

final serviceClientProvider = Provider((ref) => ServiceClient());

/// The Service Client manages interactions with the datasource.
class ServiceClient {
  final _logger = Logger('ServiceClient');

  Future<List<Service>> getByCategoryId(CategoryId id) async {
    try {
      final result = await db
          .getAll("SELECT * FROM services WHERE services.category_id = '$id'")
          .then((res) => res.map(Service.fromMap).toList());
      result.sort();
      return result;
    } catch (e) {
      _logger.info('Services could not be retrieved', e);
      // TODO: Support better error handling. For now, this will be bubbled
      // up to be caught and handled before being presented in the UI.
      rethrow;
    }
  }
}
