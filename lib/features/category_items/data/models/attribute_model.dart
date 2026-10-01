import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mousa_store/features/category_items/data/models/category_items_response/brand.dart';

part 'attribute_model.freezed.dart';

@Freezed(toJson: false, fromJson: false)
abstract class AttributeValue with _$AttributeValue {
  const AttributeValue._();

  const factory AttributeValue({
    required int id,
    required String value,
  }) = _AttributeValue;

  factory AttributeValue.fromJson(Map<String, dynamic> json) => AttributeValue(
        id: json['id'] as int? ?? 0,
        value: json['value'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {'id': id, 'value': value};
}

@Freezed(toJson: false, fromJson: false)
abstract class AttributeResponse with _$AttributeResponse {
  const AttributeResponse._();

  const factory AttributeResponse({
    required bool success,
    required String message,
    required AttributeResponseData data,
  }) = _AttributeResponse;

  factory AttributeResponse.fromJson(Map<String, dynamic> json) =>
      AttributeResponse(
        success: json['success'] as bool? ?? false,
        message: json['message'] as String? ?? '',
        data: json['data'] != null
            ? AttributeResponseData.fromJson(
                json['data'] as Map<String, dynamic>,
              )
            : AttributeResponseData.empty(),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data.toJson(),
      };
}

@Freezed(toJson: false, fromJson: false)
abstract class AttributeResponseData with _$AttributeResponseData {
  const AttributeResponseData._();

  const factory AttributeResponseData({
    @Default([]) List<AttributeData> attributes,
    @Default([]) List<Brand> brands,
    @Default('0') String minPrice,
    @Default('0') String maxPrice,
  }) = _AttributeResponseData;

  factory AttributeResponseData.empty() => const AttributeResponseData();

  factory AttributeResponseData.fromJson(Map<String, dynamic> json) =>
      AttributeResponseData(
        attributes: (json['attributes'] as List<dynamic>?)
                ?.map((e) => AttributeData.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        brands: (json['brands'] as List<dynamic>?)
                ?.map((e) => Brand.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        minPrice: json['min_price']?.toString() ?? '0',
        maxPrice: json['max_price']?.toString() ?? '0',
      );

  Map<String, dynamic> toJson() => {
        'attributes': attributes.map((e) => e.toJson()).toList(),
        'brands': brands.map((e) => e.toJson()).toList(),
        'min_price': minPrice,
        'max_price': maxPrice,
      };
}

@Freezed(toJson: false, fromJson: false)
abstract class AttributeData with _$AttributeData {
  const AttributeData._();

  const factory AttributeData({
    required String key,
    required List<AttributeValue> values,
  }) = _AttributeData;

  factory AttributeData.fromJson(Map<String, dynamic> json) => AttributeData(
        key: json['key'] as String? ?? '',
        values: (json['values'] as List<dynamic>?)
                ?.map((e) => AttributeValue.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
      );

  Map<String, dynamic> toJson() => {
        'key': key,
        'values': values.map((e) => e.toJson()).toList(),
      };
}
