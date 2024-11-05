import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:delivery/common/utils/global.dart';
import 'package:delivery/driver/models/driver_info_model.dart';
import 'package:delivery/driver/utils/interfaces/driver_interface.dart';
import 'package:delivery/helper/toast.dart';
import 'package:delivery/home/models/list_of_orders_model.dart';
import 'package:delivery/home/utils/interfaces/orders_interface.dart';
import 'package:dio/dio.dart';

part 'driver_info_state.dart';

class DriverInfoCubit extends Cubit<DriverInfoState> {
  DriverInfoCubit() : super(DriverInfoInitial());

  final DriverInterface driverRepository = locator.get<DriverInterface>();
  final OrdersInterface ordersRepository = locator.get<OrdersInterface>();

  DriverInfoModel? driverInfo;
  ListOfOrdersModel? listOfOrdersModel;

  Future<void> getDriverProfileInfo() async {
    emit(DriverInfoLoading());

    Response? response;

    try {
      // get the driver profile info
      response = await driverRepository.getDriverProfileInfo();
      emit(DriverInfoLoaded());
    } on DioException catch (e) {
      emit(DriverInfoError(e.response != null ? e.response!.data['message'] : 'حدث خطأ ما'));
    }

    if (response != null && response.statusCode == 200) {
      driverInfo = DriverInfoModel.fromJson(response.data);
    } else {
      emit(DriverInfoError(response != null ? response.data['message'] : 'حدث خطأ ما'));
      showToast(
        message: 'حدث خطأ ما',
        toastType: ToastType.error
      );
    }

  }

  Future<void> getAllOrders() async {
    emit(DriverInfoLoading());
    Response? response;
    try {
      response = await ordersRepository.getAllOrders();
    } on DioException catch (e) {
      log(e.toString());
      emit(DriverInfoError(e.response != null ? e.response!.data['message'] : 'حدث خطأ ما'));
      showToast(
        message: "حدث خطأ ما",
        toastType: ToastType.error,
      );
      return;
    }

    if ( response != null && response.statusCode == 200) {
      listOfOrdersModel = ListOfOrdersModel.fromJson(response.data);
    } else {
      emit(DriverInfoError(response != null ? response.data['message'] : 'حدث خطأ ما'));
      showToast(
        message: "حدث خطأ ما",
        toastType: ToastType.error,
      );
      return;
    }

    emit(DriverInfoLoaded());
  }

}