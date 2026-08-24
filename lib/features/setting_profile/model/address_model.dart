class Address {
  Address({
    required this.id,
    required this.nameAddress,
    required this.address,
    this.governorate,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: (json['id'] as num?)?.toInt() ?? 0,
    nameAddress: json['name_address']?.toString() ?? '',
    address: json['address']?.toString() ?? '',
    governorate: json['governorate']?.toString(),
  );

  final int id;
  final String nameAddress;
  final String address;
  final String? governorate;
}
