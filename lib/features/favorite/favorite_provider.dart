import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/entities/provider/service_provider_provider.dart';
import 'package:littlehelpbook_flutter/shared/models/provider.dart';
import 'package:littlehelpbook_flutter/shared/powersync/powersync.dart';
import 'package:powersync/powersync.dart';

final favoritesProvider =
    AsyncNotifierProvider<FavoriteNotifier, List<ServiceProvider>>(
  FavoriteNotifier.new,
);

class FavoriteNotifier extends AsyncNotifier<List<ServiceProvider>> {
  @override
  FutureOr<List<ServiceProvider>> build() async {
    ref.watch(favoriteProvidersStreamProvider);
    return await ref.watch(favoriteProvidersStreamProvider.future);
  }

  Future<void> addFavorite(ServiceProviderId id) async {
    await db.execute('''
      INSERT INTO favorites(id, provider_id, created_at)
      VALUES('${uuid.v4()}', '$id', datetime())
    ''');
  }

  bool isFavorite(ServiceProviderId id) {
    final favorites = state.valueOrNull ?? [];
    final match = favorites.firstWhereOrNull((i) => i.id == id);
    return match != null;
  }

  Future<void> removeFavorite(ServiceProviderId id) async {
    await db.execute("DELETE FROM favorites WHERE provider_id = '$id'");
  }

  Future<void> toggleFavorite(ServiceProviderId id) async {
    if (isFavorite(id)) {
      return removeFavorite(id);
    }
    return addFavorite(id);
  }
}
