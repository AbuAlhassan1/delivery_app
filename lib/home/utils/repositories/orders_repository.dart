import 'dart:developer';
import 'package:delivery/common/utils/global.dart';
import 'package:delivery/common/utils/interfaces/http_request_interface.dart';
import 'package:delivery/home/utils/interfaces/orders_interface.dart';
import 'package:dio/dio.dart';

class OrdersRepository implements OrdersInterface {

  HttpRequestInterFace httpRequest = locator.get<HttpRequestInterFace>();
  
  @override
  Future<Response?> getAllOrders() async {
    // /Order/GetCurrentMonthDriverOrders

    Response? response;

    try {
      response = await httpRequest.get( path: '/Order/GetCurrentMonthDriverOrders');
    } catch (e) {
      log(e.toString());
    }
    return response;

  }

  @override
  Future<Response?> getCurrentOrders() async {
    // /Order/GetCurrentMonthDriverOrders

    Response? response;

    try {
      response = await httpRequest.get( path: '/Order/GetMyCurrentOrders');
    } catch (e) {
      log(e.toString());
      rethrow;
    }
    return response;

  }

  @override
  Future<Response?> toggleIsActive(bool isActive) async {
    // /Driver/IsWorking/true

    Response? response;

    try {
      response = await httpRequest.patch(path: '/Driver/IsWorking/$isActive');
    } catch (e) {
      log(e.toString());
    }
    return response;

  }
  
  @override
  Future<Response?> changeOrderStatus(int status, String orderId) async {
    // /Order/DeliveringOrder/1420e651-9873-421e-8b9a-2ee7da097b98

    Response? response;

    try {
      if (status == 4) {
        response = await httpRequest.patch(path: '/Order/DeliveringOrder/$orderId');
      } else if (status == 5){
        response = await httpRequest.patch(path: '/Order/DeliveredOrder/$orderId');
      }
    } catch (e) {
      log(e.toString());
    }
    return response;
  }
  
  @override
  Future<Response?> acceptOrRejectOrder(String orderId, bool isAccept) async {
    // Order/AcceptOrRejectOrder/{orderId}/{isAccept}

    Response? response;

    try {
      response = await httpRequest.patch(path: '/Order/AcceptOrRejectOrder/$orderId/$isAccept');
    } catch (e) {
      log(e.toString());
    }
    return response;
  }

  

}