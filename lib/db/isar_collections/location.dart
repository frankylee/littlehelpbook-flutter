// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';

part 'location.g.dart';

@collection
class Location {
  Id isarId = Isar.autoIncrement;

  late String id;

  late String providerId;

  @Index()
  late String name;

  late String email;

  late String phoneNumbers;

  late bool isMultilingual;

  late bool isWheelChairAccess;

  late String addressLineOne;

  late String addressLineTwo;

  late String city;

  late String state;

  late String zip;

  late LatLng latLng;

  @override
  String toString() {
    return 'Location(isarId: $isarId, id: $id, providerId: $providerId, name: $name, email: $email, phoneNumbers: $phoneNumbers, isMultilingual: $isMultilingual, isWheelChairAccess: $isWheelChairAccess, addressLineOne: $addressLineOne, addressLineTwo: $addressLineTwo, city: $city, state: $state, zip: $zip, latLng: $latLng)';
  }
}

@embedded
class LatLng {
  late float latitude;

  late float longitude;

  @override
  String toString() => 'LatLng(latitude: $latitude, longitude: $longitude)';
}
