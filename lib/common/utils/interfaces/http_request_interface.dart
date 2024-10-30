import 'package:dio/dio.dart';

abstract class HttpRequestInterFace {
  static String baseUrl = "https://devdmisapi.muraba.dev";
  static String confirmEmailRedirect = "https://dmis.muraba.dev/";

  Future<Response?> get({required String path, Options? headers, Map<String, dynamic>? queryParameters, ResponseType? responseType});
  Future<Response?> post<T>({required String path, Options? headers, T? payload, String? contentType, ResponseType? responseType, Map<String, dynamic>? queryParameters});
  Future<Response?> update<T>({
    required String path,
    Options? headers,
    String? contentType,
    T? payload,
    ResponseType? responseType,
    Map<String, dynamic>? queryParameters,
  });
  Future<Response?> patch<T>({
    required String path,
    Options? headers,
    String? contentType,
    T? payload,
    ResponseType? responseType,
    Map<String, dynamic>? queryParameters,
  });
  Future<Response?> delete<T>({required String path, Options? headers, T? payload});
}