import 'package:equatable/equatable.dart';

class BannerModel extends Equatable {
  const BannerModel({
    required this.id,
    required this.title,
    required this.desc,
    required this.imagePath,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
    id: json['id'] as int? ?? 0,
    title: json['title'] as String? ?? '',
    desc: json['desc'] as String? ?? '',
    imagePath: json['image_path'] as String? ?? '',
  );

  final int id;
  final String title;
  final String desc;
  final String imagePath;

  @override
  List<Object?> get props => [id, title, desc, imagePath];
}
