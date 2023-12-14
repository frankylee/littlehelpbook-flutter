import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/entities/service/service_provider.dart';
import 'package:littlehelpbook_flutter/shared/extensions/async_value.ext.dart';
import 'package:littlehelpbook_flutter/shared/models/category.dart';
import 'package:littlehelpbook_flutter/shared/models/service.dart';

class ServicesList extends ConsumerWidget {
  const ServicesList({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  final CategoryId categoryId;
  final String categoryName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<List<Service>>>(
      servicesStreamProvider(categoryId),
      (_, state) => state.showSnackbarOnError(context),
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(categoryName),
      ),
      body: ref.watch(servicesStreamProvider(categoryId)).maybeWhen(
            data: (services) => ListView.builder(
              itemCount: services.length,
              itemBuilder: (context, index) {
                final service = services[index];
                return ListTile(
                  title: Text(service.nameEn),
                  subtitle: Text(service.nameEs ?? ''),
                  trailing: Icon(Icons.chevron_right_rounded),
                  onTap: () {}, // TODO: Route to Providers.
                );
              },
            ),
            orElse: () => Center(child: CircularProgressIndicator()),
          ),
    );
  }
}
