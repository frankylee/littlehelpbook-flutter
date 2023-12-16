import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/shared/models/provider.dart';

class ProvidersList extends ConsumerWidget {
  const ProvidersList({
    super.key,
    this.physics,
    required this.providers,
    this.shrinkWrap,
  });

  final ScrollPhysics? physics;
  final bool? shrinkWrap;
  final List<ServiceProvider> providers;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: providers.length,
      physics: physics,
      shrinkWrap: shrinkWrap ?? false,
      itemBuilder: (context, index) {
        final provider = providers[index];
        return ListTile(
          title: Text(provider.name),
          subtitle: Text(
            provider.descriptionEn,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
          trailing: Icon(Icons.chevron_right_rounded),
          onTap: () {}, // TODO: Route to Provider Detail.
        );
      },
    );
  }
}
