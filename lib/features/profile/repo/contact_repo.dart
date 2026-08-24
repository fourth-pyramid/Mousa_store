// ignore_for_file: avoid_dynamic_calls

import 'package:mousa_store/core/service/dio_helper.dart';
import 'package:mousa_store/features/profile/model/contact_model.dart';

class ContactRepo {
  // ponytail: native Dart record replaces dartz Either dependency
  Future<({String? error, ContactModel? data})> getContactInfo() async {
    try {
      final response = await DioHelper.getData(url: 'contacts');

      if (response.data['success'] == true) {
        final data = response.data['data'] as List<dynamic>;
        if (data.isNotEmpty) {
          return (error: null, data: ContactModel.fromJson(data.first as Map<String, dynamic>));
        } else {
          return (error: 'No contact information found', data: null);
        }
      } else {
        return (error: (response.data['message'] ?? 'Unknown error').toString(), data: null);
      }
    } on Exception catch (e) {
      if (e is CustomDioError) {
        return (error: e.message, data: null);
      }
      return (error: e.toString(), data: null);
    }
  }
}
