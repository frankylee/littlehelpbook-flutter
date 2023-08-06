import 'package:isar/isar.dart';

part 'category.g.dart';

@collection
class Category {
  Id isarId = Isar.autoIncrement;

  late String id;
  late String name;
  late String nameEs;
}
