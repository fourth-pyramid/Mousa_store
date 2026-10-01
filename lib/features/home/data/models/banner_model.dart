import 'package:freezed_annotation/freezed_annotation.dart';

part 'banner_model.freezed.dart';

@Freezed(toJson: false, fromJson: false)
abstract class BannerModel with _$BannerModel {
  const BannerModel._();

  const factory BannerModel({
    required int id,
    required String title,
    required String desc,
    required String imagePath,
  }) = _BannerModel;

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        id: json['id'] as int? ?? 0,
        title: json['title'] as String? ?? '',
        desc: json['desc'] as String? ?? '',
        imagePath: json['image_path'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'desc': desc,
        'image_path': imagePath,
      };
}
