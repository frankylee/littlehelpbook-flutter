import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/entities/provider/widgets/provider_details_bottomsheet.dart';
import 'package:littlehelpbook_flutter/entities/user_preferences/user_preferences_provider.dart';
import 'package:littlehelpbook_flutter/features/favorite/favorite_icon_toggle.dart';
import 'package:littlehelpbook_flutter/shared/models/provider.dart';

class ProvidersSliverList extends ConsumerWidget {
  const ProvidersSliverList({
    super.key,
    required this.providers,
    this.searchTerm,
  });

  final List<ServiceProvider> providers;
  final String? searchTerm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(userPreferencesProvider);
    final isEn = ref.read(userPreferencesProvider.notifier).isEn();
    final hasSearchTerm = searchTerm != null && searchTerm!.isNotEmpty;
    return SliverList.builder(
      itemCount: providers.length,
      itemBuilder: (context, index) {
        final provider = providers[index];
        if (hasSearchTerm && !provider.isSearchResult(searchTerm!)) {
          return const SizedBox.shrink();
        }
        return ListTile(
          leading: FavoriteIconToggle(providerId: provider.id),
          title: Text(provider.name),
          subtitle: Text(
            provider.getDescription(isEn),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
          trailing: Icon(Icons.chevron_right_rounded),
          onTap: () => ProviderDetailsBottomSheet.show(context, provider),
        );
      },
    );
  }
}
