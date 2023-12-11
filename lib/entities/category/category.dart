import 'package:equatable/equatable.dart';
import 'package:littlehelpbook_flutter/entities/service/service.dart';

typedef CategoryId = String;

class Category extends Equatable implements Comparable<Category> {
  Category({
    required this.id,
    required this.nameEn,
    this.nameEs,
    this.services = const <Service>[],
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Category.fromMap(Map<String, dynamic> data) {
    return Category(
      id: data['id'] as CategoryId,
      nameEn: data['name_en'] as String,
      nameEs: data['name_es'] as String?,
      createdAt: data['created_at'] as String,
      updatedAt: data['updated_at'] as String?,
      deletedAt: data['deleted_at'] as String?,
    );
  }

  final CategoryId id;
  final String nameEn;
  final String? nameEs;
  final List<Service> services;
  final String createdAt;
  final String? updatedAt;
  final String? deletedAt;

  /// Sort categories by name in ascending order.
  @override
  int compareTo(Category other) {
    return this.nameEn.compareTo(other.nameEn);
  }

  @override
  List<Object?> get props => [
        id,
        nameEn,
        nameEs,
        createdAt,
        updatedAt,
        deletedAt,
      ];

  @override
  bool? get stringify => true;

  Category copyWith({
    CategoryId? id,
    String? nameEn,
    String? nameEs,
    List<Service>? services,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
  }) {
    return Category(
      id: id ?? this.id,
      nameEn: nameEn ?? this.nameEn,
      nameEs: nameEs ?? this.nameEs,
      services: services ?? this.services,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}
