import 'package:bloc/bloc.dart';
import 'package:delivery/common/utils/global.dart';
import 'package:delivery/driver/models/driver_info_model.dart';
import 'package:delivery/driver/utils/interfaces/driver_interface.dart';
import 'package:delivery/helper/toast.dart';
import 'package:dio/dio.dart';

part 'driver_info_state.dart';

class DriverInfoCubit extends Cubit<DriverInfoState> {
  DriverInfoCubit() : super(DriverInfoInitial());

  final DriverInterface driverRepository = locator.get<DriverInterface>();

  DriverInfoModel? driverInfo;

  Future<void> getDriverProfileInfo() async {
    emit(DriverInfoLoading());

    Response? response;

    try {
      // get the driver profile info
      response = await driverRepository.getDriverProfileInfo();
      emit(DriverInfoLoaded());
    } catch (e) {
      emit(DriverInfoError());
    }

    if (response != null && response.statusCode == 200) {
      driverInfo = DriverInfoModel.fromJson(response.data);
    } else {
      emit(DriverInfoError());
      showToast(
        message: 'حدث خطأ ما',
        toastType: ToastType.error
      );
    }

  }

}
