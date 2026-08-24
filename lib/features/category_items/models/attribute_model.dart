import 'package:equatable/equatable.dart';
import 'package:mousa_store/features/category_items/models/category_items_response/brand.dart';

/// Represents a single attribute value with its ID and display value
class AttributeValue extends Equatable {
  const AttributeValue({required this.id, required this.value});

  factory AttributeValue.fromJson(Map<String, dynamic> json) => AttributeValue(
    id: json['id'] as int? ?? 0,
    value: json['value'] as String? ?? '',
  );

  final int id;
  final String value;

  Map<String, dynamic> toJson() => {'id': id, 'value': value};

  @override
  List<Object?> get props => [id, value];
}

class AttributeResponse extends Equatable {
  const AttributeResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AttributeResponse.fromJson(Map<String, dynamic> json) =>
      AttributeResponse(
        success: json['success'] as bool? ?? false,
        message: json['message'] as String? ?? '',
        data: json['data'] != null
            ? AttributeResponseData.fromJson(
                json['data'] as Map<String, dynamic>,
              )
            : const AttributeResponseData.empty(),
      );

  final bool success;
  final String message;
  final AttributeResponseData data;

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data.toJson(),
  };

  @override
  List<Object?> get props => [success, message, data];
}

class AttributeResponseData extends Equatable {
  const AttributeResponseData({
    required this.attributes,
    required this.brands,
    required this.minPrice,
    required this.maxPrice,
  });

  const AttributeResponseData.empty()
    : attributes = const [],
      brands = const [],
      minPrice = '0',
      maxPrice = '0';

  factory AttributeResponseData.fromJson(Map<String, dynamic> json) =>
      AttributeResponseData(
        attributes:
            (json['attributes'] as List<dynamic>?)
                ?.map((e) => AttributeData.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        brands:
            (json['brands'] as List<dynamic>?)
                ?.map((e) => Brand.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        minPrice: json['min_price']?.toString() ?? '0',
        maxPrice: json['max_price']?.toString() ?? '0',
      );

  final List<AttributeData> attributes;
  final List<Brand> brands;
  final String minPrice;
  final String maxPrice;

  Map<String, dynamic> toJson() => {
    'attributes': attributes.map((e) => e.toJson()).toList(),
    'brands': brands.map((e) => e.toJson()).toList(),
    'min_price': minPrice,
    'max_price': maxPrice,
  };

  @override
  List<Object?> get props => [attributes, brands, minPrice, maxPrice];
}

class AttributeData extends Equatable {
  const AttributeData({required this.key, required this.values});

  factory AttributeData.fromJson(Map<String, dynamic> json) => AttributeData(
    key: json['key'] as String? ?? '',
    values:
        (json['values'] as List<dynamic>?)
            ?.map((e) => AttributeValue.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
  );

  final String key;
  final List<AttributeValue> values;

  Map<String, dynamic> toJson() => {
    'key': key,
    'values': values.map((e) => e.toJson()).toList(),
  };

  @override
  List<Object?> get props => [key, values];
}
