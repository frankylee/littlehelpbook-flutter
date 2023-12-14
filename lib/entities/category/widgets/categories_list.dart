import 'package:flutter/material.dart';
import 'package:littlehelpbook_flutter/shared/models/category.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({
    super.key,
    required this.categories,
    required this.onTap,
  });

  final List<Category> categories;
  final void Function(Category category) onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final category = categories[index];
        return ListTile(
          title: Text(category.nameEn),
          subtitle: Text(category.nameEs ?? ''),
          trailing: Icon(Icons.chevron_right_rounded),
          onTap: () => onTap(category),
        );
      },
    );
  }
}
