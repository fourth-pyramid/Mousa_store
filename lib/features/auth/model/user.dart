class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userType,
    required this.email,
    required this.phone,
    required this.isVerified,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: (json['id'] as int?) ?? 0,
    firstName: json['first_name']?.toString() ?? '',
    lastName: json['last_name']?.toString() ?? '',
    userType: json['user_type']?.toString() ?? '',
    email: json['email']?.toString() ?? '',
    phone: json['phone']?.toString() ?? '',
    isVerified: (json['is_verfived'] ?? 0) == 1,
    createdAt: json['created_at'] != null
        ? DateTime.tryParse(json['created_at'] as String)
        : null,
    updatedAt: json['updated_at'] != null
        ? DateTime.tryParse(json['updated_at'] as String)
        : null,
  );
  final int id;
  final String firstName;
  final String lastName;
  final String userType;
  final String email;
  final String phone;
  final bool isVerified;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Map<String, dynamic> toJson() => {
    'id': id,
    'first_name': firstName,
    'last_name': lastName,
    'user_type': userType,
    'email': email,
    'phone': phone,
    'is_verfived': isVerified ? 1 : 0,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };
}
