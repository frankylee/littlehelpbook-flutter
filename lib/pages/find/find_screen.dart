import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:littlehelpbook_flutter/app/config/app_config.dart';
import 'package:littlehelpbook_flutter/entities/provider/location_provider.dart';
import 'package:littlehelpbook_flutter/shared/extensions/build_context.ext.dart';
import 'package:littlehelpbook_flutter/shared/models/location.dart';
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
    print(e);
    return [];
  }
});

class FindScreen extends ConsumerStatefulWidget {
  const FindScreen({super.key});

  @override
  ConsumerState<FindScreen> createState() => FindScreenState();
}

class FindScreenState extends ConsumerState<FindScreen> {
  final MapController _controller = MapController();

  @override
  Widget build(BuildContext context) {
    final mapStyleLoader = ref.watch(mapStyleProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colorTheme.inversePrimary,
        title: Text(context.l10n.findServiceProviders),
      ),
      body: mapStyleLoader.when(
        data: (mapStyle) => FlutterMap(
          mapController: _controller,
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
            MarkerLayer(
              markers: ref.watch(validLocationsProvider).maybeWhen(
                    data: (locations) {
                      return locations
                          .map(
                            (location) => Marker(
                              point: LatLng(
                                location.latitude!,
                                location.longitude!,
                              ),
                              child: Icon(
                                Icons.business_rounded,
                                color: context.colorTheme.primary,
                              ),
                            ),
                          )
                          .toList();
                    },
                    orElse: () => [],
                  ),
              // markers: [
              //   Marker(
              //     point: LatLng(44.0521, -123.0868),
              //     child: Icon(
              //       Icons.business_rounded,
              //       color: context.colorTheme.primary,
              //     ),
              //   ),
              // ],
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
        error: (err, _) {
          print(err);
          return const SizedBox.shrink();
        },
        loading: () => const SizedBox.shrink(),
      ),
    );
  }
}
