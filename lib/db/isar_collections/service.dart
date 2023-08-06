// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';

part 'service.g.dart';

@collection
class Service {
  Id isarId = Isar.autoIncrement;

  late String id;

  @Index()
  late String name;

  late String nameEs;

  late String categoryId;

  @override
  String toString() {
    return 'Service(isarId: $isarId, id: $id, name: $name, nameEs: $nameEs, categoryId: $categoryId)';
  }
}
