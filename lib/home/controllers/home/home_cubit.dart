import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:delivery/common/utils/global.dart';
import 'package:delivery/helper/toast.dart';
import 'package:delivery/home/models/list_of_orders_model.dart';
import 'package:delivery/home/utils/interfaces/orders_interface.dart';
import 'package:dio/dio.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final OrdersInterface ordersRepository = locator.get<OrdersInterface>();

  bool isActiveDriver = false;
  ListOfOrdersModel? listOfCurrentOrdersModel;
  bool isHomeDisabled = false;

  toggleActiveDriver() async{
    isActiveDriver = !isActiveDriver;
    bool result = await toggleIsActive();
    if(result){
      emit(HomeLoaded());
    } else {
      isActiveDriver = !isActiveDriver;
    }
    emit(HomeInitial());
  }

  Future<void> getCurrentOrders() async {
    emit(HomeLoading());
    Response? response;
    try {
      response = await ordersRepository.getCurrentOrders();
    } on DioException catch (e) {
      if( e.response != null && e.response!.statusCode == 400 ){
        isHomeDisabled = true;
      }
      log("Responsssssssssssssssse: ${e.response!.data.runtimeType}");
      if( e.response!.data.runtimeType == Map ){
        emit(HomeError(e.response!.data['message'].toString()));
        showToast(
          message: e.response!.data['message'].toString(),
          toastType: ToastType.error,
        );
        return;
      } else {
        emit(HomeError("حدث خطأ ما"));
        showToast(
          message: e.message.toString(),
          toastType: ToastType.error,
        );
        return;
      }
    }

    if ( response != null && response.statusCode == 200) {
      listOfCurrentOrdersModel = ListOfOrdersModel.fromJson(response.data);
      isHomeDisabled = false;
    } else {
      if( response != null && response.statusCode == 400 ){
        isHomeDisabled = true;
      }
      emit(HomeError(response != null ? response.data['message'] : 'حدث خطأ ما'));
      showToast(
        message: response != null ? response.data['message'] : 'حدث خطأ ما',
        toastType: ToastType.error,
      );
      return;
    }

    emit(HomeLoaded());
  }

  Future<bool> toggleIsActive() async {
    emit(HomeLoading());
    Response? response;
    try {
      response = await ordersRepository.toggleIsActive(isActiveDriver);
    } catch (e) {
      log(e.toString());
      emit(HomeError(response != null ? response.data['message'] : 'حدث خطأ ما'));
      showToast(
        message: "حدث خطأ ما",
        toastType: ToastType.error,
      );
      return false;
    }

    if ( response != null && response.statusCode == 200) {
      emit(HomeLoaded());
      showToast(
        message: "تم تغيير الحالة",
        toastType: ToastType.success,
      );
      return true;
    } else {
      emit(HomeError(response != null ? response.data['message'] : 'حدث خطأ ما'));
      showToast(
        message: "حدث خطأ ما",
        toastType: ToastType.error,
      );
      return false;
    }
  }

  Future<void> changeOrderStatus(int status, String orderId) async {
    emit(HomeLoading());
    Response? response;
    try {
      response = await ordersRepository.changeOrderStatus(status, orderId);
    } catch (e) {
      log(e.toString());
      showToast(
        message: "حدث خطأ ما",
        toastType: ToastType.error,
      );
      return;
    }

    if ( response != null && response.statusCode == 200) {
      emit(HomeLoaded());
      showToast(
        message: "تم تغيير حالة الطلب",
        toastType: ToastType.success,
      );
    } else {
      emit(HomeError(response != null ? response.data['message'] : 'حدث خطأ ما'));
      showToast(
        message: "حدث خطأ ما",
        toastType: ToastType.error,
      );
      return;
    }
  }

  Future<void> acceptOrRejectOrder(String orderId, bool isAccept) async {
    emit(HomeLoading());
    Response? response;
    try {
      response = await ordersRepository.acceptOrRejectOrder(orderId, isAccept);
    } catch (e) {
      log(e.toString());
      showToast(
        message: "حدث خطأ ما",
        toastType: ToastType.error,
      );
      return;
    }

    if ( response != null && response.statusCode == 200) {
      emit(HomeLoaded());
      showToast(
        message: "تم تغيير حالة الطلب",
        toastType: ToastType.success,
      );
    } else {
      emit(HomeError(response != null ? response.data['message'] : 'حدث خطأ ما'));
      showToast(
        message: "حدث خطأ ما",
        toastType: ToastType.error,
      );
      return;
    }
  }
}
