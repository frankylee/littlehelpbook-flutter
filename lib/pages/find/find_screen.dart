import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:littlehelpbook_flutter/app/config/app_config.dart';
import 'package:littlehelpbook_flutter/entities/provider/location_provider.dart';
import 'package:littlehelpbook_flutter/entities/provider/service_provider_provider.dart';
import 'package:littlehelpbook_flutter/entities/provider/widgets/provider_details_bottomsheet.dart';
import 'package:littlehelpbook_flutter/logger.dart';
import 'package:littlehelpbook_flutter/shared/extensions/build_context.ext.dart';
import 'package:littlehelpbook_flutter/shared/models/location.dart';
import 'package:logging/logging.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';

final mapStyleProvider = FutureProvider((ref) async {
  final style = await StyleReader(
    uri: 'mapbox://styles/mapbox/streets-v12?access_token={key}',
    apiKey: AppConfig.mapboxApiKey,
  ).read();

  return style;
});

final validLocationsProvider = FutureProvider<List<Location>>((ref) async {
  try {
    final locations = await ref.watch(locationsStreamProvider.future);
    final nonNullLocations = locations
        .where(
          (element) => element.latitude != null && element.longitude != null,
        )
        .toList();
    return nonNullLocations;
  } catch (e) {
    Logger('validLocationsProvider').severe(
      'Unable to find locations.',
      e,
      StackTrace.current,
    );
    return [];
  }
});

class FindScreen extends ConsumerStatefulWidget {
  const FindScreen({super.key});

  @override
  ConsumerState<FindScreen> createState() => FindScreenState();
}

class FindScreenState extends ConsumerState<FindScreen>
    with TickerProviderStateMixin, LoggerMixin {
  late final _animatedMapController = AnimatedMapController(
    vsync: this,
    curve: Curves.easeInToLinear,
  );

  @override
  Widget build(BuildContext context) {
    final mapStyleLoader = ref.watch(mapStyleProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.findServiceProviders),
        centerTitle: true,
      ),
      body: mapStyleLoader.when(
        data: (mapStyle) => FlutterMap(
          mapController: _animatedMapController.mapController,
          options: MapOptions(
            initialCenter: LatLng(44.0521, -123.0868),
            initialZoom: 15.0,
          ),
          children: [
            VectorTileLayer(
              tileProviders: mapStyle.providers,
              theme: mapStyle.theme,
              sprites: mapStyle.sprites,
              maximumZoom: 22,
              tileOffset: TileOffset.mapbox,
              layerMode: VectorTileLayerMode.vector,
            ),
            MarkerClusterLayerWidget(
              options: MarkerClusterLayerOptions(
                maxClusterRadius: 45,
                size: const Size(40, 40),
                alignment: Alignment.center,
                markers: ref.watch(validLocationsProvider).maybeWhen(
                      data: (locations) {
                        return locations
                            .map(
                              (location) => Marker(
                                point: LatLng(
                                  location.latitude!,
                                  location.longitude!,
                                ),
                                child: GestureDetector(
                                  onTap: () async {
                                    final serviceProvider = await ref.read(
                                      providerByIdProvider(
                                        location.providerId,
                                      ).future,
                                    );
                                    ProviderDetailsBottomSheet.show(
                                      context,
                                      serviceProvider,
                                    );
                                  },
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: context.colorTheme.tertiary,
                                    ),
                                    child: Icon(
                                      Icons.health_and_safety,
                                      color: context.colorTheme.onTertiary,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList();
                      },
                      orElse: () => [],
                    ),
                builder: (context, markers) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: context.colorTheme.tertiaryContainer,
                    ),
                    child: Center(
                      child: Text(
                        markers.length.toString(),
                        style: context.textTheme.labelLarge,
                      ),
                    ),
                  );
                },
              ),
            ),
            CurrentLocationLayer(
              alignPositionOnUpdate: AlignOnUpdate.once,
            ),
            RichAttributionWidget(
              attributions: [
                TextSourceAttribution(
                  'OpenStreetMap contributors',
                  onTap: () => launchUrl(
                    Uri.parse('https://openstreetmap.org/copyright'),
                  ),
                ),
              ],
            ),
          ],
        ),
        error: (err, st) {
          logger.severe('Unable to display locations', err, st);
          return const SizedBox.shrink();
        },
        loading: () => const SizedBox.shrink(),
      ),
    );
  }
}
