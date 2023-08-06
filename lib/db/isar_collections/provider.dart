// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';

part 'provider.g.dart';

@collection
class Provider {
  Id isarId = Isar.autoIncrement;

  late String id;

  @Index()
  late String name;

  late String description;

  late String descriptionEs;

  late String email;

  late String phoneNumber;

  late String website;

  late List<String> services;

  @override
  String toString() {
    return 'Provider(isarId: $isarId, id: $id, name: $name, description: $description, descriptionEs: $descriptionEs, email: $email, phoneNumber: $phoneNumber, website: $website, services: $services)';
  }
}
