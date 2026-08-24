import 'package:mousa_store/features/category_items/models/category_items_response/pivot.dart';

class ItemCategory {
  ItemCategory({this.id, this.name, this.imagePath, this.pivot});

  factory ItemCategory.fromJson(Map<String, dynamic> json) => ItemCategory(
    id: json['id'] as int?,
    name: json['name'] as String?,
    imagePath: json['image_path'] as String?,
    pivot: json['pivot'] == null
        ? null
        : Pivot.fromJson(json['pivot'] as Map<String, dynamic>),
  );
  int? id;
  String? name;
  String? imagePath;
  Pivot? pivot;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image_path': imagePath,
    'pivot': pivot?.toJson(),
  };
}
