import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/entities/service/service_provider.dart';
import 'package:littlehelpbook_flutter/shared/extensions/async_value.ext.dart';
import 'package:littlehelpbook_flutter/shared/extensions/build_context.ext.dart';
import 'package:littlehelpbook_flutter/shared/models/category.dart';
import 'package:littlehelpbook_flutter/shared/models/service.dart';

class ServicesList extends ConsumerWidget {
  const ServicesList({
    super.key,
    required this.categoryId,
  });

  final CategoryId categoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<List<Service>>>(
      servicesStreamProvider(categoryId),
      (_, state) => state.showSnackbarOnError(context),
    );
    // TODO: This needs a lot of work and is pretty ugly right now.
    // This just proves that the services for the category exist.
    return ref.watch(servicesStreamProvider(categoryId)).maybeWhen(
          data: (services) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: services
                .map(
                  (j) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        j.nameEn,
                        style: context.textTheme.bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      if (j.nameEs != null)
                        Text(j.nameEs!, style: context.textTheme.bodyMedium),
                    ],
                  ),
                )
                .toList(),
          ),
          orElse: () => Center(child: CircularProgressIndicator()),
        );
  }
}
