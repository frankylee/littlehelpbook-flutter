import 'package:equatable/equatable.dart';
import 'package:littlehelpbook_flutter/shared/models/provider.dart';
import 'package:littlehelpbook_flutter/shared/utils/convert_text_to_list.dart';

typedef LocationId = String;

class Location extends Equatable {
  Location({
    required this.id,
    this.name,
    this.email,
    required this.isAccessible,
    required this.isMultilingual,
    required this.phones,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.zipCode,
    this.latitude,
    this.longitude,
    required this.providerId,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Location.fromMap(Map<String, dynamic> data) {
    return Location(
      id: data['id'] as LocationId,
      name: data['name']?.toString(),
      email: data['email']?.toString(),
      isAccessible: int.tryParse(data['is_wheelchair_access'].toString()) == 1,
      isMultilingual: int.tryParse(data['is_multilingual'].toString()) == 1,
      phones: convertTextToList(data['phones'] as String?),
      addressLine1: data['address_line_1'] as String?,
      addressLine2: data['address_line_2'] as String?,
      city: data['city'] as String?,
      state: data['state'] as String?,
      zipCode: data['zip_code'] as String?,
      latitude: double.tryParse(data['latitude'].toString()),
      longitude: double.tryParse(data['longitude'].toString()),
      providerId: data['provider_id'] as String,
      createdAt: data['created_at'] as String,
      updatedAt: data['updated_at'] as String?,
      deletedAt: data['deleted_at'] as String?,
    );
  }

  final LocationId id;
  final String? name;
  final String? email;
  final bool isAccessible;
  final bool isMultilingual;
  final List<String> phones;
  final String? addressLine1;
  final String? addressLine2;
  final String? city;
  final String? state;
  final String? zipCode;
  final double? latitude;
  final double? longitude;
  final ServiceProviderId providerId;
  final String createdAt;
  final String? updatedAt;
  final String? deletedAt;

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        isAccessible,
        isMultilingual,
        phones,
        addressLine1,
        addressLine2,
        city,
        state,
        zipCode,
        latitude,
        longitude,
        providerId,
        createdAt,
        updatedAt,
        deletedAt,
      ];

  @override
  bool? get stringify => true;

  Location copyWith({
    LocationId? id,
    String? name,
    String? email,
    bool? isAccessible,
    bool? isMultilingual,
    List<String>? phones,
    String? addressLine1,
    String? addressLine2,
    String? city,
    String? state,
    String? zipCode,
    double? latitude,
    double? longitude,
    ServiceProviderId? providerId,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
  }) {
    return Location(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      isAccessible: isAccessible ?? this.isAccessible,
      isMultilingual: isMultilingual ?? this.isMultilingual,
      phones: phones ?? this.phones,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      providerId: providerId ?? this.providerId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  /// Format the address by combining the first and second line if the second line
  /// is short, like a suite number, and combining the city, state, and zipcode.
  List<String> formatAddress() {
    String? line1;
    String line3 = '';
    if (city != null && state != null) {
      line3 = '$city, $state';
      if (zipCode != null) line3 += ' $zipCode';
    }
    if (addressLine1 != null &&
        addressLine2 != null &&
        addressLine2!.length < 6) {
      line1 = '$addressLine1 $addressLine2';
      return [line1, '', line3];
    }
    return [addressLine1 ?? '', addressLine2 ?? '', line3];
  }

  bool hasAddress() {
    return addressLine1 != null ||
        addressLine2 != null ||
        city != null ||
        state != null ||
        zipCode != null;
  }
}
