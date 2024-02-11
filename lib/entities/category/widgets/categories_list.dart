import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/entities/user_preferences/user_preferences_provider.dart';
import 'package:littlehelpbook_flutter/shared/models/category.dart';

class CategoriesList extends ConsumerWidget {
  const CategoriesList({
    super.key,
    required this.categories,
    required this.onTap,
  });

  final List<Category> categories;
  final void Function(Category category) onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(userPreferencesProvider);
    final isEn = ref.read(userPreferencesProvider.notifier).isEn();
    return ListView.builder(
      itemCount: categories.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final category = categories[index];
        return ListTile(
          title: Text(category.getNamePrimary(isEn)),
          subtitle: Text(category.getNameSecondary(isEn)),
          trailing: Icon(Icons.chevron_right_rounded),
          onTap: () => onTap(category),
        );
      },
    );
  }
}
