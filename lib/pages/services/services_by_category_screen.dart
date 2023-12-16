import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/app/router/lhb_routes.dart';
import 'package:littlehelpbook_flutter/entities/service/service_provider.dart';
import 'package:littlehelpbook_flutter/entities/service/widgets/services_list.dart';
import 'package:littlehelpbook_flutter/shared/extensions/async_value.ext.dart';
import 'package:littlehelpbook_flutter/shared/models/category.dart';
import 'package:littlehelpbook_flutter/shared/models/service.dart';

class ServicesByCategoryScreen extends ConsumerWidget {
  const ServicesByCategoryScreen({
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
            data: (data) => ServicesList(
              services: data,
              onTap: (service) async {
                return ProvidersByServiceRoute().push(
                  context,
                  data: ProvidersByServiceData(
                    categoryId: categoryId,
                    categoryName: categoryName,
                    serviceId: service.id,
                    serviceName: service.nameEn,
                  ),
                );
              },
            ),
            orElse: () => Center(child: CircularProgressIndicator()),
          ),
    );
  }
}
