import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/data/category/category.dart';
import 'package:littlehelpbook_flutter/shared/extensions/async_value.ext.dart';
import 'package:littlehelpbook_flutter/shared/extensions/build_context.ext.dart';
import 'package:littlehelpbook_flutter/ui/services/providers.dart';
import 'package:littlehelpbook_flutter/ui/services/widgets/categories_list.dart';

class ServicesScreen extends ConsumerWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<List<Category>>>(
      categoriesProvider,
      (_, state) => state.showSnackbarOnError(context),
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(context.l10n.services),
      ),
      body: ref.watch(categoriesProvider).maybeWhen(
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
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        children: [
          Card(
            color: context.colorTheme.primaryContainer,
            elevation: 0,
            margin: EdgeInsets.zero,
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
              ? CategoriesList(categories: data)
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
