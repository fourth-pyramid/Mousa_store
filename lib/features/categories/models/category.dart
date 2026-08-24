import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Category extends Equatable {
  const Category({
    required this.id,
    required this.name,
    this.createdAt,
    this.updatedAt,
    this.imagePath,
    this.parentId,
    this.sortOrder,
  });

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

  final int id;
  final int? parentId;
  final int? sortOrder;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String name;
  final String? imagePath;

  Map<String, dynamic> toJson() => {
    'id': id,
    'parent_id': parentId,
    'sort_order': sortOrder,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'name': name,
    'image_path': imagePath,
  };

  @override
  List<Object?> get props => [
    id,
    parentId,
    sortOrder,
    createdAt,
    updatedAt,
    name,
    imagePath,
  ];
}
