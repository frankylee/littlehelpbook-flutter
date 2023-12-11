import 'package:flutter/material.dart';
import 'package:littlehelpbook_flutter/data/category/category.dart';
import 'package:littlehelpbook_flutter/shared/extensions/build_context.ext.dart';
import 'package:littlehelpbook_flutter/ui/services/widgets/services_list.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({
    super.key,
    required this.categories,
  });

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList.radio(
      elevation: 0,
      children: categories
          .map(
            (i) => ExpansionPanelRadio(
              value: i.id,
              backgroundColor: context.colorTheme.surface,
              canTapOnHeader: true,
              headerBuilder: (context, isExpanded) => ListTile(
                title: Text(i.nameEn),
                subtitle: Text(i.nameEs ?? ''),
              ),
              body: ServicesList(categoryId: i.id),
            ),
          )
          .toList(),
    );
  }
}
