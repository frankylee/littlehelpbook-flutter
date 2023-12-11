// This file performs setup of the PowerSync database.
// Credit: https://github.com/journeyapps/powersync-supabase-flutter-demo/blob/main/lib/powersync.dart
import 'dart:io';

import 'package:littlehelpbook_flutter/shared/powersync/fatal_response_codes.dart';
import 'package:littlehelpbook_flutter/shared/supabase/edge_function.dart';
import 'package:littlehelpbook_flutter/shared/supabase/supabase.dart';
import 'package:logging/logging.dart';
import 'package:powersync/powersync.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Use Supabase for authentication and data upload.
class SupabaseConnector extends PowerSyncBackendConnector {
  SupabaseConnector(this.db);

  PowerSyncDatabase db;

  final _logger = Logger('SupabaseConnector');

  /// Get a Supabase token to authenticate against the PowerSync instance.
  @override
  Future<PowerSyncCredentials?> fetchCredentials() async {
    try {
      // Get PowerSync token using a Supabase edge function.
      final authResponse = await supabaseClient.functions.invoke(
        EdgeFunction.powersyncAuthAnonymous.name,
        method: HttpMethod.get,
      );
      if (authResponse.status != 200) {
        throw HttpException(
          "Failed to get PowerSync Token, code=${authResponse.status}",
        );
      }
      return PowerSyncCredentials(
        endpoint: authResponse.data['powersync_url'] as String,
        token: authResponse.data['token'] as String,
      );
    } catch (e) {
      _logger.severe('Credentials could not be retrieved', e);
      return null;
    }
  }

  // Upload pending changes to Supabase.
  @override
  Future<void> uploadData(PowerSyncDatabase database) async {
    // This function is called whenever there is data to upload, whether the
    // device is online or offline.
    // If this call throws an error, it is retried periodically.
    final transaction = await database.getNextCrudTransaction();
    if (transaction == null) {
      return;
    }
    CrudEntry? lastOp;
    try {
      // Note: If transactional consistency is important, use database functions
      // or edge functions to process the entire transaction in a single call.
      for (var op in transaction.crud) {
        lastOp = op;
        final table = supabaseClient.rest.from(op.table);
        if (op.op == UpdateType.put) {
          var data = Map<String, dynamic>.of(op.opData!);
          data['id'] = op.id;
          await table.upsert(data);
        } else if (op.op == UpdateType.patch) {
          await table.update(op.opData!).eq('id', op.id);
        } else if (op.op == UpdateType.delete) {
          await table.delete().eq('id', op.id);
        }
      }
      // All operations successful.
      await transaction.complete();
    } on PostgrestException catch (e) {
      if (e.code != null &&
          fatalResponseCodes.any((re) => re.hasMatch(e.code!))) {
        /// Instead of blocking the queue with these errors,
        /// discard the (rest of the) transaction.
        ///
        /// Note that these errors typically indicate a bug in the application.
        /// If protecting against data loss is important, save the failing records
        /// elsewhere instead of discarding, and/or notify the user.
        _logger.severe('Data upload error - discarding $lastOp', e);
        await transaction.complete();
      } else {
        // Error may be retryable - e.g. network error or temporary server error.
        // Throwing an error here causes this call to be retried after a delay.
        rethrow;
      }
    }
  }
}
