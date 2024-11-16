import 'package:bloc/bloc.dart';

part 'orders_notification_cubit_state.dart';

class OrdersNotificationCubitCubit extends Cubit<OrdersNotificationCubitState> {
  OrdersNotificationCubitCubit() : super(OrdersNotificationCubitInitial());

  List orders = [];

  void removeOrder(int index) {
    orders.removeAt(index);
    emit(OrdersNotificationCubitInitial());
  }
}