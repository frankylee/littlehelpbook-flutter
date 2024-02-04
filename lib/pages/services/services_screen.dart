import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/app/router/lhb_routes.dart';
import 'package:littlehelpbook_flutter/app/theme/lhb_style_constants.dart';
import 'package:littlehelpbook_flutter/entities/category/category_provider.dart';
import 'package:littlehelpbook_flutter/entities/category/widgets/categories_list.dart';
import 'package:littlehelpbook_flutter/shared/extensions/async_value.ext.dart';
import 'package:littlehelpbook_flutter/shared/extensions/build_context.ext.dart';
import 'package:littlehelpbook_flutter/shared/extensions/text_style.ext.dart';
import 'package:littlehelpbook_flutter/shared/models/category.dart';
import 'package:littlehelpbook_flutter/widgets/gradient_container.dart';
import 'package:responsive_builder/responsive_builder.dart';

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
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: LhbStyleConstants.maxPageContentWidth,
          ),
          child: ref.watch(categoriesStreamProvider).maybeWhen(
                data: ServicesDataView.new,
                orElse: () => Center(child: CircularProgressIndicator()),
              ),
        ),
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
    final deviceType = getDeviceType(MediaQuery.of(context).size);
    return SingleChildScrollView(
      child: Column(
        children: [
          GradientContainer(
            borderRadius: deviceType == DeviceScreenType.tablet &&
                    MediaQuery.of(context).orientation == Orientation.landscape
                ? null
                : BorderRadius.zero,
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Text(
                context.l10n.servicesExploreByCategory,
                style: context.textTheme.titleLarge?.white,
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          data.isNotEmpty
              ? CategoriesList(
                  categories: data,
                  onTap: (category) => ServicesByCategoryRoute().push(
                    context,
                    data: ServicesByCategoryData(
                      categoryId: category.id,
                      categoryName: category.nameEn,
                    ),
                  ),
                )
              : SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.25,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 48.0),
                      child: Text(
                        context.l10n
                            .entityCouldNotBeFound(context.l10n.services),
                        style: context.textTheme.titleMedium,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
