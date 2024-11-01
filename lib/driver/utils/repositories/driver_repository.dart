import 'dart:developer';
import 'package:delivery/common/utils/global.dart';
import 'package:delivery/common/utils/interfaces/http_request_interface.dart';
import 'package:delivery/driver/utils/interfaces/driver_interface.dart';
import 'package:dio/dio.dart';

class DriverRepository implements DriverInterface {
  
  final HttpRequestInterFace httpRequest = locator.get<HttpRequestInterFace>();

  @override
  Future<Response?> getDriverProfileInfo() async {
    Response? response;
    try {
      response = await httpRequest.get(path:'/User/GetDriverProfile');
    } catch (e) {
      log(e.toString());
    }
    return response;
  }
}