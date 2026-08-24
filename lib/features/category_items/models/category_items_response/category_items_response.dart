import 'package:mousa_store/features/category_items/models/category_items_response/category_items_data.dart';

class CategoryItemsResponse {
  CategoryItemsResponse({this.success, this.message, this.data});

  factory CategoryItemsResponse.fromJson(Map<String, dynamic> json) =>
      CategoryItemsResponse(
        success: json['success'] as bool?,
        message: json['message'] as String?,
        data: json['data'] == null
            ? null
            : CategoryItemsData.fromJson(json['data'] as Map<String, dynamic>),
      );
  bool? success;
  String? message;
  CategoryItemsData? data;

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data?.toJson(),
  };
}
