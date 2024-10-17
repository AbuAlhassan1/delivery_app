// ignore_for_file: override_on_non_overriding_member

import 'dart:developer';
import 'package:delivery/common/models/log_storage_model.dart';
import 'package:delivery/common/utils/global.dart';
import 'package:delivery/common/utils/interfaces/http_request_interface.dart';
import 'package:delivery/common/utils/interfaces/storage_interface.dart';
import 'package:delivery/constants/secure_storage.dart';
import 'package:delivery/helper/toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class HttpRequestRepository implements HttpRequestInterFace {

  @override
  String get baseUrl => "https://devdmisapi.muraba.dev";
  // String get testBaseUrl => "http://159.223.25.119";

  final LogStorage logs = LogStorage();


  Dio dio = Dio(BaseOptions(baseUrl: "https://devdmisapi.muraba.dev/api", followRedirects: false))
  ..interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      compact: false,
      request: true,
      maxWidth: 90,
      logPrint: (object) {
        if (kDebugMode) {
          print(object);
        }
        LogStorage.addLog(object.toString());
      },
    ));
  StorageInterFace storage = locator.get<StorageInterFace>();

  @override
  Future<Response?> get({
    required String path,
    Options? headers,
    Map<String, dynamic>? queryParameters,
    ResponseType? responseType
  }) async {

    String? token = await storage.read(secureStorageUserInfo);
    
    if( token != null ){
      dio.options.headers = {
        'Authorization': 'Bearer ',
        "Accept-Language": "ar",
        'X-Requested-With': 'XMLHttpRequest',
        'dmis-app': "dmis-app"
      };
    } else {
      dio.options.headers = {
        'Authorization': 'Bearer ',
        'X-Requested-With': 'XMLHttpRequest',
        'dmis-app': "dmis-app"
      };
    }

    dio.options.contentType = "application/json";

    dio.options.method = "GET";
    if(responseType != null){
      dio.options.responseType = responseType;
    }else{
      dio.options.responseType = ResponseType.json;
    }
    
    // handelErrorMessage();

    return await dio.request(path, queryParameters: queryParameters);
  }

  @override
  Future<Response?> post<T>({
    required String path,
    Options? headers,
    String? contentType,
    T? payload,
    ResponseType? responseType,
    Map<String, dynamic>? queryParameters,
  }) async {
    log("1");
    String? token = await storage.read(secureStorageUserInfo);

    
    if( token != null ){
      dio.options.headers = {
        'Authorization': 'Bearer ',
        "Accept-Language": "ar",
        'X-Requested-With': 'XMLHttpRequest',
        'dmis-app': "dmis-app"
      };
    } else {
      dio.options.headers = {
        'Authorization': 'Bearer ',
        'X-Requested-With': 'XMLHttpRequest',
        'dmis-app': "dmis-app"
      };
    }

    dio.options.method = "POST";
    dio.options.contentType = contentType?? "application/json";
    if(responseType != null){
      dio.options.responseType = responseType;
    }else{
      dio.options.responseType = ResponseType.json;
    }
    Response? response;
    
    try{
      response = await dio.request(path, data: payload, queryParameters: queryParameters);
    } on DioException catch(e){
      handelErrorMessage(e.response);
      return e.response!;
    }

    // handelErrorMessage(response);

    return response;
  }

  @override
  Future<Response?> update<T>({
    required String path,
    Options? headers,
    String? contentType,
    T? payload,
    ResponseType? responseType,
    Map<String, dynamic>? queryParameters,
  }) async {
    log("1");
    String? token = await storage.read(secureStorageUserInfo);

    // String? reCaptchaToken = await execute();
    
    if( token != null ){
      dio.options.headers = {
        'Authorization': 'Bearer ',
        "Accept-Language": "ar",
        'X-Requested-With': 'XMLHttpRequest',
        'dmis-app': "dmis-app"
      };
    } else {
      dio.options.headers = {
        'Authorization': 'Bearer ',
        'X-Requested-With': 'XMLHttpRequest',
        'dmis-app': "dmis-app"
      };
    }

    dio.options.method = "PUT";
    dio.options.contentType = contentType?? "application/json";
    if(responseType != null){
      dio.options.responseType = responseType;
    }else{
      dio.options.responseType = ResponseType.json;
    }
    
    Response? response;

    try{
      response = await dio.request(path, data: payload, queryParameters: queryParameters);
    } on DioException catch(e){
      handelErrorMessage(e.response);
      return e.response!;
    }

    // handelErrorMessage(response);

    return response;
  }

  @override
  Future<Response?> delete<T>({required String path, Options? headers, T? payload}) async {
    return null;
  }

  handelErrorMessage( Response? response ){
    if( response!.data != null && response.data is Map ){
        Map<String, dynamic> responseBody = response.data;
        if( responseBody.containsKey("error") ){
          if( responseBody['error'].containsKey("message") ){
            showToast(
              message: responseBody['error']['message'],
              toastType: ToastType.error
            );
          } else if( responseBody['error'].containsKey("validationErrors") ){
            List<String> validationErrors = responseBody['error']['validationErrors'].map<String>((e) => e['message']).toList();
            showToast(
              message: validationErrors.join("\n"),
              toastType: ToastType.error
            );
          } else if ( response.statusCode == 401 ){
            showToast(
              message: "غير مصرح بالوصول. يرجى تسجيل الدخول مجدًا.",
              toastType: ToastType.error
            );
          } else if ( response.statusCode == 400 ){
            showToast(
              message: "حدث خطأ في البيانات",
              toastType: ToastType.error
            );
          } else if ( response.statusCode == 403 ){
            showToast(
              message: "غير مصرح بالوصول. ليس لديك الصلاحية للقيام بذلك.",
              toastType: ToastType.error
            );
          } else if ( response.statusCode == 404 ){
            showToast(
              message: "غير متوفر",
              toastType: ToastType.error
            );
          } else if ( response.statusCode == 500 ){
            showToast(
              message: "خطأ في الاتصال",
              toastType: ToastType.error
            );
          }  
          else {
            showToast(
              message: "حدث خطأ غير معروف",
              toastType: ToastType.error
            );
          }
        } else {
          showToast(
            message: "حدث خطأ غير معروف",
            toastType: ToastType.error
          );
        }
      }
  }

}