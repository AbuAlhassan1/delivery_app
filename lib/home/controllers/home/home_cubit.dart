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

  ListOfOrdersModel? listOfOrdersModel;
  ListOfOrdersModel? listOfCurrentOrdersModel;

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

  Future<void> getAllOrders() async {
    emit(HomeLoading());
    Response? response;
    try {
      response = await ordersRepository.getAllOrders();
    } catch (e) {
      log(e.toString());
      emit(HomeError());
      showToast(
        message: "حدث خطأ ما",
        toastType: ToastType.error,
      );
      return;
    }

    if ( response != null && response.statusCode == 200) {
      listOfOrdersModel = ListOfOrdersModel.fromJson(response.data);
    } else {
      emit(HomeError());
      showToast(
        message: "حدث خطأ ما",
        toastType: ToastType.error,
      );
      return;
    }

    emit(HomeLoaded());
  }

  Future<void> getCurrentOrders() async {
    emit(HomeLoading());
    Response? response;
    try {
      response = await ordersRepository.getCurrentOrders();
    } catch (e) {
      log(e.toString());
      emit(HomeError());
      showToast(
        message: "حدث خطأ ما",
        toastType: ToastType.error,
      );
      return;
    }

    if ( response != null && response.statusCode == 200) {
      listOfCurrentOrdersModel = ListOfOrdersModel.fromJson(response.data);
    } else {
      emit(HomeError());
      showToast(
        message: "حدث خطأ ما",
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
      emit(HomeError());
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
      emit(HomeError());
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
      showToast(
        message: "حدث خطأ ما",
        toastType: ToastType.error,
      );
      return;
    }
  }
}
