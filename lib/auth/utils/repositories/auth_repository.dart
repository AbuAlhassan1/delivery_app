import 'dart:developer';
import 'package:delivery/auth/utils/interfaces/auth_interface.dart';
import 'package:delivery/common/utils/global.dart';
import 'package:delivery/common/utils/interfaces/http_request_interface.dart';
import 'package:delivery/common/utils/interfaces/storage_interface.dart';
import 'package:delivery/constants/secure_storage.dart';
import 'package:delivery/helper/toast.dart';
import 'package:dio/dio.dart';

class AuthRepository implements AuthInterface {

  HttpRequestInterFace httpRequest = locator.get<HttpRequestInterFace>();
  final StorageInterFace storage = locator.get<StorageInterFace>();

  @override
  Future<Response?> login(String email, String password) async {
    Response? response;
    try {
      response = await httpRequest.post(
        path: '/User/DriverLogin',
        payload: {
          'email': email,
          'password': password,
        },
      );
    } on DioException catch (e) {
      log(e.response.toString());
      if ( e.response != null && e.response!.data['message'] != null) {
        showToast(
          message: e.response!.data['message'],
          toastType: ToastType.error,
        );
      } else {
        showToast(
          message: "حدث خطأ ما",
          toastType: ToastType.error,
        );
      }
    }

    if (response != null && response.statusCode == 200) {
      storage.store(secureStorageUserInfo, response.data['data']['token']);
      // show Toast
      showToast(
        message: "تم تسجيل الدخول بنجاح",
        toastType: ToastType.success,
      );
    } else if (response != null && response.statusCode != 200) {
      if ( response.data['message'] != null) {
        showToast(
          message: response.data['message'],
          toastType: ToastType.error,
        );
      } else {
        showToast(
          message: "حدث خطأ ما",
          toastType: ToastType.error,
        );
      }
    }

    return response;
  }
  
  @override
  Future<Response?> registerToken(String token) async {
    // /Notification/RegisterFcmToken/register-fcm-token?token=asdasd
    Response? response;

    try{
      response = await httpRequest.post(path: '/Notification/RegisterFcmToken/register-fcm-token?token=$token');
    } on DioException catch (e) {
      log(e.response.toString());
    }

    return response;
    
  }
}