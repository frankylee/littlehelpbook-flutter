import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/features/favorite/favorite_provider.dart';
import 'package:littlehelpbook_flutter/shared/models/provider.dart';

class FavoriteIconToggle extends ConsumerWidget {
  const FavoriteIconToggle({
    super.key,
    required this.providerId,
  });

  final ServiceProviderId providerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(favoritesProvider);
    final isFavorite =
        ref.read(favoritesProvider.notifier).isFavorite(providerId);
    return GestureDetector(
      child: Icon(isFavorite ? Icons.favorite : Icons.favorite_border_rounded),
      onTap: () async {
        ref.read(favoritesProvider.notifier).toggleFavorite(providerId);
      },
    );
  }
}
