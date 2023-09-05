import 'package:equatable/equatable.dart';

typedef CategoryId = String;

class Category extends Equatable implements Comparable<Category> {
  Category({
    required this.id,
    required this.nameEn,
    this.nameEs,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Category.fromMap(Map<String, dynamic> data) {
    return Category(
      id: data['id'] as String,
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
}
