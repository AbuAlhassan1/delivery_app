import 'package:dio/dio.dart';

abstract class DriverInterface {
  Future<Response?> getDriverProfileInfo();
}