import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/app/router/lhb_routes.dart';
import 'package:littlehelpbook_flutter/entities/category/category_provider.dart';
import 'package:littlehelpbook_flutter/entities/category/widgets/categories_list.dart';
import 'package:littlehelpbook_flutter/shared/extensions/async_value.ext.dart';
import 'package:littlehelpbook_flutter/shared/extensions/build_context.ext.dart';
import 'package:littlehelpbook_flutter/shared/models/category.dart';

class ServicesScreen extends ConsumerWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<List<Category>>>(
      categoriesStreamProvider,
      (_, state) => state.showSnackbarOnError(context),
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(context.l10n.services),
      ),
      body: ref.watch(categoriesStreamProvider).maybeWhen(
            data: ServicesDataView.new,
            orElse: () => Center(child: CircularProgressIndicator()),
          ),
    );
  }
}

class ServicesDataView extends StatelessWidget {
  @visibleForTesting
  const ServicesDataView(this.data, {super.key});

  final List<Category> data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            color: context.colorTheme.primaryContainer,
            elevation: 0,
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Text(
                context.l10n.servicesExploreByCategory,
                style: context.textTheme.titleLarge!
                    .copyWith(color: context.colorTheme.onPrimaryContainer),
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          data.isNotEmpty
              ? CategoriesList(
                  categories: data,
                  onTap: (category) => ServicesByCategoryRoute().go(
                    context,
                    data: ServicesByCategoryData(
                      categoryId: category.id,
                      categoryName: category.nameEn,
                    ),
                  ),
                )
              : Center(
                  child: Text(
                    context.l10n.servicesCouldNotBeFound,
                    style: context.textTheme.titleMedium,
                  ),
                ),
        ],
      ),
    );
  }
}
