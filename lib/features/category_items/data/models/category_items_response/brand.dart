class Brand {
  Brand({this.id, this.name, this.imagePath});

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json['id'] as int?,
    name: json['name'] as String?,
    imagePath: json['image_path'] as String?,
  );
  int? id;
  String? name;
  String? imagePath;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image_path': imagePath,
  };
}
