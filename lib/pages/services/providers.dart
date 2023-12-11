import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/entities/category/category.dart';
import 'package:littlehelpbook_flutter/entities/category/category_client.dart';
import 'package:littlehelpbook_flutter/entities/service/service_client.dart';

final categoriesProvider =
    FutureProvider.autoDispose<List<Category>>((ref) async {
  return ref.watch(categoryClientProvider).getAll();
});

final categoryProvider =
    FutureProvider.autoDispose.family<Category, CategoryId>((ref, id) async {
  return (await ref.watch(categoriesProvider.future))
      .singleWhere((i) => i.id == id);
});

final servicesByCategoryIdProvider = FutureProvider.autoDispose
    .family<Category, CategoryId>((ref, categoryId) async {
  Category category = await ref.watch(categoryProvider(categoryId).future);
  final services =
      await ref.read(serviceClientProvider).getByCategoryId(categoryId);
  return category.copyWith(services: services);
});
