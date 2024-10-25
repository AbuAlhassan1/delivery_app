import 'package:bloc/bloc.dart';
import 'package:delivery/home/models/list_of_orders_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  bool isActiveDriver = false;

  ListOfOrdersModel listOfOrdersModel = ListOfOrdersModel.fromJson({
    "error": false,
    "message": null,
    "data": [
      {
        "id": "c009b594-4cf3-40fb-957c-7790171e7eae",
        "orderNumber": 16,
        "restaurantOrderNo": "",
        "price": 250,
        "customerPhoneNumber": "",
        "restaurantName": "88 كرل - زيونة",
        "districtName": "شارع فلسطين",
        "status": 4,
        "restaurantNote": "",
        "deliveryFee": 250
      },
      {
        "id": "1420e651-9873-421e-8b9a-2ee7da097b98",
        "orderNumber": 15,
        "restaurantOrderNo": "4545",
        "price": 4000,
        "customerPhoneNumber": "07700696656",
        "restaurantName": "88 كرل - زيونة",
        "districtName": "البنوك",
        "status": 4,
        "restaurantNote": "",
        "deliveryFee": 4000
      },
      {
        "id": "1420e651-9873-421e-8b9a-2ee7da097b98",
        "orderNumber": 15,
        "restaurantOrderNo": "4545",
        "price": 4000,
        "customerPhoneNumber": "07700696656",
        "restaurantName": "88 كرل - زيونة",
        "districtName": "البنوك",
        "status": 4,
        "restaurantNote": "",
        "deliveryFee": 4000
      },
    ],
    "count": 2
  });

  toggleActiveDriver(){
    isActiveDriver = !isActiveDriver;
    emit(HomeInitial());
  }
}
