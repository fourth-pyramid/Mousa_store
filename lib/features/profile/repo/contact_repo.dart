import 'package:mousa_store/core/service/dio_helper.dart';
import 'package:mousa_store/features/profile/model/contact_model.dart';

class ContactRepo {
  // ponytail: native Dart record replaces dartz Either dependency
  Future<({String? error, ContactModel? data})> getContactInfo() async {
    try {
      final response = await DioHelper.getData(url: 'contacts');
      final responseData = response.data is Map<String, dynamic>
          ? response.data as Map<String, dynamic>
          : (response.data is Map
                ? Map<String, dynamic>.from(response.data as Map)
                : <String, dynamic>{});

      if (responseData['success'] == true) {
        final data = responseData['data'];
        if (data is List && data.isNotEmpty) {
          final firstItem = data.first is Map
              ? Map<String, dynamic>.from(data.first as Map)
              : <String, dynamic>{};
          return (error: null, data: ContactModel.fromJson(firstItem));
        } else {
          return (error: 'No contact information found', data: null);
        }
      } else {
        return (
          error: (responseData['message'] ?? 'Unknown error').toString(),
          data: null,
        );
      }
    } on Exception catch (e) {
      if (e is CustomDioError) {
        return (error: e.message, data: null);
      }
      return (error: e.toString(), data: null);
    }
  }
}
