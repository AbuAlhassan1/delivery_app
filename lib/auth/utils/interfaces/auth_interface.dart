import 'package:dio/dio.dart';

abstract class AuthInterface {
  Future<Response?> login(String email, String password);
  Future<Response?> registerToken(String token);
}