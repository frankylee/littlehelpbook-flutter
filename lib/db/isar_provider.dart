import 'package:flutter_riverpod/flutter_riverpod.dart' as rp;
import 'package:isar/isar.dart';
import 'package:littlehelpbook_flutter/db/isar_collections/category.dart';
import 'package:littlehelpbook_flutter/db/isar_collections/location.dart';
import 'package:littlehelpbook_flutter/db/isar_collections/provider.dart';
import 'package:littlehelpbook_flutter/db/isar_collections/schedule.dart';
import 'package:littlehelpbook_flutter/db/isar_collections/service.dart';
import 'package:path_provider/path_provider.dart';

final isarProvider = rp.Provider<Isar>((ref) {
  //The return type Future<Isar> isn’t a ‘Isar’, as required by the closure’s context
  //Code Reference: https://codewithandrea.com/videos/flutter-state-management-riverpod
  throw UnimplementedError();
});

Future<Isar> openIsar() async {
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [
      CategorySchema,
      ServiceSchema,
      ScheduleSchema,
      LocationSchema,
      ProviderSchema,
    ],
    directory: dir.path,
  );
  return isar;
}
