import 'package:equatable/equatable.dart';
import 'package:littlehelpbook_flutter/shared/models/service.dart';
import 'package:littlehelpbook_flutter/shared/utils/convert_text_to_list.dart';

typedef ServiceProviderId = String;

class ServiceProvider extends Equatable implements Comparable<ServiceProvider> {
  ServiceProvider({
    required this.id,
    required this.name,
    required this.descriptionEn,
    this.descriptionEs,
    this.email,
    this.phone,
    this.website,
    required this.services,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory ServiceProvider.fromMap(Map<String, dynamic> data) {
    return ServiceProvider(
      id: data['id'] as ServiceProviderId,
      name: data['name'] as String,
      descriptionEn: data['description_en'] as String,
      descriptionEs: data['description_es'] as String?,
      email: data['email'] as String?,
      phone: data['phone'] as String?,
      website: data['website'] as String?,
      services: convertTextToList(data['services'] as String),
      createdAt: data['created_at'] as String,
      updatedAt: data['updated_at'] as String?,
      deletedAt: data['deleted_at'] as String?,
    );
  }

  final ServiceProviderId id;
  final String name;
  final String descriptionEn;
  final String? descriptionEs;
  final String? email;
  final String? phone;
  final String? website;
  final List<ServiceId> services;
  final String createdAt;
  final String? updatedAt;
  final String? deletedAt;

  /// Sort Providers by name in ascending order.
  @override
  int compareTo(ServiceProvider other) {
    return this.name.compareTo(other.name);
  }

  @override
  List<Object?> get props => [
        id,
        name,
        descriptionEn,
        descriptionEs,
        email,
        phone,
        website,
        services,
        createdAt,
        updatedAt,
        deletedAt,
      ];

  @override
  bool? get stringify => true;

  ServiceProvider copyWith({
    ServiceProviderId? id,
    String? name,
    String? descriptionEn,
    String? descriptionEs,
    String? email,
    String? phone,
    String? website,
    List<ServiceId>? services,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
  }) {
    return ServiceProvider(
      id: id ?? this.id,
      name: name ?? this.name,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      descriptionEs: descriptionEs ?? this.descriptionEs,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      website: website ?? this.website,
      services: services ?? this.services,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  String getDescription(bool isEn) {
    return isEn ? descriptionEn : descriptionEs ?? descriptionEn;
  }

  /// Determine if a provider matches a search term. The term is matched against
  /// the name and description.
  bool isSearchResult(String searchTerm) {
    final term = searchTerm.toUpperCase();
    return name.toUpperCase().contains(term) ||
        descriptionEn.toUpperCase().contains(term) ||
        (descriptionEs != null && descriptionEs!.toUpperCase().contains(term));
  }
}
