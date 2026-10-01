import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';

@Freezed(toJson: false, fromJson: false)
abstract class Category with _$Category {
  const Category._();

  const factory Category({
    required int id,
    required String name,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? imagePath,
    int? parentId,
    int? sortOrder,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'] as int? ?? 0,
        parentId: json['parent_id'] as int?,
        sortOrder: json['sort_order'] as int?,
        createdAt: json['created_at'] != null
            ? DateTime.tryParse(json['created_at'].toString())
            : null,
        updatedAt: json['updated_at'] != null
            ? DateTime.tryParse(json['updated_at'].toString())
            : null,
        name: json['name'] as String? ?? '',
        imagePath: json['image_path'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'parent_id': parentId,
        'sort_order': sortOrder,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'name': name,
        'image_path': imagePath,
      };
}
