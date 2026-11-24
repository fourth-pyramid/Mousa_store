import 'package:mousa_store/core/utils/json_parsers.dart';

class Address {
  Address({
    required this.id,
    required this.nameAddress,
    required this.address,
    this.governorate,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: JsonParsers.toInt(json['id']),
    nameAddress: json['name_address']?.toString() ?? '',
    address: json['address']?.toString() ?? '',
    governorate: json['governorate']?.toString(),
  );

  final int id;
  final String nameAddress;
  final String address;
  final String? governorate;
}
