import 'dart:convert';

NotificationOrderModel notificationOrderModelFromJson(String str) => NotificationOrderModel.fromJson(json.decode(str));
String notificationOrderModelToJson(NotificationOrderModel data) => json.encode(data.toJson());

class NotificationOrderModel {
    final String? id;
    final String? orderNumber;
    final String? restaurantOrderNo;
    final int? price;
    final String? customerPhoneNumber;
    final String? restaurantName;
    final String? districtName;
    final int? status;
    final String? restaurantNote;

    NotificationOrderModel({
        this.id,
        this.orderNumber,
        this.restaurantOrderNo,
        this.price,
        this.customerPhoneNumber,
        this.restaurantName,
        this.districtName,
        this.status,
        this.restaurantNote,
    });

    factory NotificationOrderModel.fromJson(Map<String, dynamic> json) => NotificationOrderModel(
        id: json["Id"],
        orderNumber: json["OrderNumber"],
        restaurantOrderNo: json["RestaurantOrderNo"],
        price: json["Price"],
        customerPhoneNumber: json["CustomerPhoneNumber"],
        restaurantName: json["RestaurantName"],
        districtName: json["DistrictName"],
        status: json["Status"],
        restaurantNote: json["RestaurantNote"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "OrderNumber": orderNumber,
        "RestaurantOrderNo": restaurantOrderNo,
        "Price": price,
        "CustomerPhoneNumber": customerPhoneNumber,
        "RestaurantName": restaurantName,
        "DistrictName": districtName,
        "Status": status,
        "RestaurantNote": restaurantNote,
    };
}
