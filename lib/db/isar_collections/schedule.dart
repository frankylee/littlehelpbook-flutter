// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';

part 'schedule.g.dart';

@collection
class Schedule {
  Id isarId = Isar.autoIncrement;

  late String id;

  @Index()
  late String name;

  late String nameEs;

  @override
  String toString() {
    return 'Schedule(isarId: $isarId, id: $id, name: $name, nameEs: $nameEs)';
  }
}
