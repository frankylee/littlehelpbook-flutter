import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/data/category/category.dart';
import 'package:littlehelpbook_flutter/pages/services/providers.dart';
import 'package:littlehelpbook_flutter/shared/extensions/async_value.ext.dart';
import 'package:littlehelpbook_flutter/shared/extensions/build_context.ext.dart';

class ServicesList extends ConsumerWidget {
  const ServicesList({
    super.key,
    required this.categoryId,
  });

  final CategoryId categoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<Category>>(
      servicesByCategoryIdProvider(categoryId),
      (_, state) => state.showSnackbarOnError(context),
    );
    // TODO: This needs a lot of work and is pretty ugly right now.
    // This just proves that the services for the category exist.
    return ref.watch(servicesByCategoryIdProvider(categoryId)).maybeWhen(
          data: (category) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: category.services
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
