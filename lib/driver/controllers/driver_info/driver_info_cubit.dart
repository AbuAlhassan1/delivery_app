import 'package:bloc/bloc.dart';
import 'package:delivery/driver/models/driver_info_model.dart';

part 'driver_info_state.dart';

class DriverInfoCubit extends Cubit<DriverInfoState> {
  DriverInfoCubit() : super(DriverInfoInitial());

  DriverInfoModel? driverInfo = DriverInfoModel.fromJson({
  "error": false,
  "message": null,
  "data": {
    "id": "99e1aa32-c008-48b9-ae78-d34d509cd91c",
    "fullName": "driver test",
    "phoneNumber": null,
    "driverName": "عبود",
    "email": "driver@test.com",
    "totalTax": -750,
    "isActive": true,
    "onlineFrom": {
      "h": 12,
      "a": "pm"
    },
    "onlineTo": {
      "h": 12,
      "a": "am"
    }
  },
  "count": 1
});

}
