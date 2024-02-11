import 'package:equatable/equatable.dart';
import 'package:littlehelpbook_flutter/shared/models/category.dart';

typedef ServiceId = String;

class Service extends Equatable implements Comparable<Service> {
  Service({
    required this.id,
    required this.nameEn,
    this.nameEs,
    required this.categoryId,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Service.fromMap(Map<String, dynamic> data) {
    return Service(
      id: data['id'] as ServiceId,
      nameEn: data['name_en'] as String,
      nameEs: data['name_es'] as String?,
      categoryId: data['category_id'] as CategoryId,
      createdAt: data['created_at'] as String,
      updatedAt: data['updated_at'] as String?,
      deletedAt: data['deleted_at'] as String?,
    );
  }

  final ServiceId id;
  final String nameEn;
  final String? nameEs;
  final CategoryId categoryId;
  final String createdAt;
  final String? updatedAt;
  final String? deletedAt;

  /// Sort services by name in ascending order.
  @override
  int compareTo(Service other) {
    return this.nameEn.compareTo(other.nameEn);
  }

  @override
  List<Object?> get props => [
        id,
        nameEn,
        nameEs,
        categoryId,
        createdAt,
        updatedAt,
        deletedAt,
      ];

  @override
  bool? get stringify => true;

  Service copyWith({
    ServiceId? id,
    String? nameEn,
    String? nameEs,
    CategoryId? categoryId,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
  }) {
    return Service(
      id: id ?? this.id,
      nameEn: nameEn ?? this.nameEn,
      nameEs: nameEs ?? this.nameEs,
      categoryId: categoryId ?? this.categoryId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  String getNamePrimary(bool isEn) {
    return isEn ? nameEn : nameEs ?? nameEn;
  }

  String getNameSecondary(bool isEn) {
    return isEn ? nameEs ?? nameEn : nameEn;
  }
}
