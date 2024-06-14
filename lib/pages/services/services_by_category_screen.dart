import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:littlehelpbook_flutter/app/router/lhb_extra_params.dart';
import 'package:littlehelpbook_flutter/app/router/lhb_route_params.dart';
import 'package:littlehelpbook_flutter/app/router/lhb_routes.dart';
import 'package:littlehelpbook_flutter/app/theme/lhb_style_constants.dart';
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
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: LhbStyleConstants.maxPageContentWidth,
          ),
          child: ref.watch(servicesStreamProvider(categoryId)).maybeWhen(
                data: (data) => ServicesList(
                  services: data,
                  onTap: (service) async => context.pushNamed(
                    LhbRoute.providersByService.name,
                    pathParameters: {
                      LhbRouteParams.categoryId.name: categoryId,
                      LhbRouteParams.serviceId.name: service.id,
                    },
                    extra: {
                      LhbExtraParams.serviceName.name: service.nameEn,
                    },
                  ),
                ),
                orElse: () => Center(child: CircularProgressIndicator()),
              ),
        ),
      ),
    );
  }
}
