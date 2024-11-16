import 'package:dio/dio.dart';

abstract class OrdersInterface {
  Future<Response?> getAllOrders();
  Future<Response?> getCurrentOrders();
  Future<Response?> toggleIsActive(bool isActive);
  Future<Response?> changeOrderStatus(int status, String orderId);
  Future<Response?> acceptOrRejectOrder(String orderId, bool isAccept);
}