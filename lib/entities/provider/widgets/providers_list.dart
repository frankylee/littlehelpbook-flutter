import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/entities/provider/widgets/provider_details_bottomsheet.dart';
import 'package:littlehelpbook_flutter/shared/models/provider.dart';

class ProvidersList extends ConsumerWidget {
  const ProvidersList({
    super.key,
    this.physics,
    required this.providers,
    this.searchTerm,
    this.shrinkWrap,
  });

  final ScrollPhysics? physics;
  final List<ServiceProvider> providers;
  final String? searchTerm;
  final bool? shrinkWrap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasSearchTerm = searchTerm != null && searchTerm!.isNotEmpty;
    return ListView.builder(
      itemCount: providers.length,
      physics: physics,
      shrinkWrap: shrinkWrap ?? false,
      itemBuilder: (context, index) {
        final provider = providers[index];
        if (hasSearchTerm && !provider.isSearchResult(searchTerm!)) {
          return const SizedBox.shrink();
        }
        return ListTile(
          title: Text(provider.name),
          subtitle: Text(
            provider.descriptionEn,
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
