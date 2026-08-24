import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Brand extends Equatable {
  const Brand({
    required this.id,
    required this.name,
    required this.imagePath,
    this.createdAt,
    this.updatedAt,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json['id'] is int
        ? json['id'] as int
        : (int.tryParse('${json['id']}') ?? 0),
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
    name: json['name'] as String? ?? '',
    imagePath: json['image_path'] as String? ?? '',
  );

  final int id;
  final String? createdAt;
  final String? updatedAt;
  final String name;
  final String imagePath;

  Map<String, dynamic> toJson() => {
    'id': id,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'name': name,
    'image_path': imagePath,
  };

  @override
  List<Object?> get props => [id, createdAt, updatedAt, name, imagePath];
}
