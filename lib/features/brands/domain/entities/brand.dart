import 'package:freezed_annotation/freezed_annotation.dart';

part 'brand.freezed.dart';

@Freezed(toJson: false, fromJson: false)
abstract class Brand with _$Brand {
  const Brand._();

  const factory Brand({
    required int id,
    required String name,
    required String imagePath,
    String? createdAt,
    String? updatedAt,
  }) = _Brand;

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json['id'] is int
            ? json['id'] as int
            : (int.tryParse('${json['id']}') ?? 0),
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
        name: json['name'] as String? ?? '',
        imagePath: json['image_path'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'name': name,
        'image_path': imagePath,
      };
}
