import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/shared/extensions/build_context.ext.dart';
import 'package:littlehelpbook_flutter/shared/extensions/text_style.ext.dart';
import 'package:littlehelpbook_flutter/shared/models/location.dart';
import 'package:littlehelpbook_flutter/widgets/bordered_container.dart';

class LocationsList extends ConsumerWidget {
  const LocationsList({
    super.key,
    this.physics,
    required this.locations,
    this.shrinkWrap,
  });

  final ScrollPhysics? physics;
  final bool? shrinkWrap;
  final List<Location> locations;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (locations.isEmpty) return const SizedBox.shrink();
    return Column(
      children: List.generate(
        locations.length,
        (index) {
          final location = locations[index];
          final hasAddress = location.hasAddress();
          final address = location.formatAddress();
          return BorderedContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                if (location.name != null)
                  Text(
                    location.name!,
                    style: context.textTheme.bodyLarge?.white
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (address[0].isNotEmpty)
                          Text(
                            address[0],
                            style: context.textTheme.bodyMedium?.white,
                            softWrap: true,
                          ),
                        if (address[1].isNotEmpty)
                          Text(
                            address[1],
                            style: context.textTheme.bodyMedium?.white,
                            softWrap: true,
                          ),
                        if (address[2].isNotEmpty)
                          Text(
                            address[2],
                            style: context.textTheme.bodyMedium?.white,
                            softWrap: true,
                          ),
                      ],
                    ),
                    const SizedBox(width: 8.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (hasAddress && location.isMultilingual)
                          Text(
                            context.l10n.multilingual,
                            style: context.textTheme.bodyMedium?.white,
                          ),
                        if (hasAddress && location.isAccessible)
                          Text(
                            context.l10n.wheelchairAccess,
                            style: context.textTheme.bodyMedium?.white,
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
