import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:littlehelpbook_flutter/entities/provider/widgets/hours_of_operation.dart';
import 'package:littlehelpbook_flutter/shared/extensions/build_context.ext.dart';
import 'package:littlehelpbook_flutter/shared/extensions/text_style.ext.dart';
import 'package:littlehelpbook_flutter/shared/models/location.dart';
import 'package:littlehelpbook_flutter/widgets/bordered_container.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationsList extends StatelessWidget {
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
  Widget build(BuildContext context) {
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
                      crossAxisAlignment: CrossAxisAlignment.end,
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
                HoursOfOperation(location: location),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (location.phones.isNotEmpty)
                      const SizedBox(height: 16.0),
                    ...List.generate(
                      location.phones.length,
                      (i) => Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              HapticFeedback.lightImpact();
                              launchUrl(Uri.parse('tel:${location.phones[i]}'));
                            },
                            child: Text(
                              location.phones[i],
                              style: context.textTheme.bodyMedium?.white,
                              softWrap: true,
                            ),
                          ),
                          if (i < location.phones.length - 1)
                            const SizedBox(height: 12.0),
                        ],
                      ),
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
