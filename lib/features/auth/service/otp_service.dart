import 'package:mousa_store/core/service/dio_helper.dart';
import 'package:mousa_store/features/auth/model/otp_response.dart';

class OtpService {
  Future<OtpResponse> resendOtp({required String email}) async {
    try {
      final res = await DioHelper.postData(
        url: 'resend-otp',
        data: {'email': email},
      );
      return OtpResponse.fromJson(res.data as Map<String, dynamic>);
    } on Exception {
      return OtpResponse(success: false, message: 'حدث خطأ، حاول مرة أخرى');
    }
  }

  Future<OtpResponse> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final res = await DioHelper.postData(
        url: 'verify-otp',
        data: {'email': email, 'otp': otp},
      );
      return OtpResponse.fromJson(res.data as Map<String, dynamic>);
    } on Exception {
      return OtpResponse(success: false, message: 'حدث خطأ، حاول مرة أخرى');
    }
  }

  Future<OtpResponse> sendEmailForForgetPassword({
    required String email,
  }) async {
    try {
      final res = await DioHelper.postData(
        url: 'sendEmail',
        data: {'email': email},
      );
      return OtpResponse.fromJson(res.data as Map<String, dynamic>);
    } on Exception {
      return OtpResponse(success: false, message: 'حدث خطأ، حاول مرة أخرى');
    }
  }

  Future<OtpResponse> sendCodeForForgetPassword({
    required String email,
    required String otp,
  }) async {
    try {
      final res = await DioHelper.postData(
        url: 'sendCode',
        data: {'email': email, 'otp': otp},
      );
      return OtpResponse.fromJson(res.data as Map<String, dynamic>);
    } on Exception {
      return OtpResponse(success: false, message: 'حدث خطأ، حاول مرة أخرى');
    }
  }

  Future<OtpResponse> resendOtpForForgetPassword({
    required String email,
  }) async {
    try {
      final res = await DioHelper.postData(
        url: 'forgotPassword/resend-otp',
        data: {'email': email},
      );
      return OtpResponse.fromJson(res.data as Map<String, dynamic>);
    } on Exception {
      return OtpResponse(success: false, message: 'حدث خطأ، حاول مرة أخرى');
    }
  }
}
