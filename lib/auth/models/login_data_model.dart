import 'dart:convert';

LoginDataModel loginDataModelFromJson(String str) => LoginDataModel.fromJson(json.decode(str));
String loginDataModelToJson(LoginDataModel data) => json.encode(data.toJson());

class LoginDataModel {
  final bool? error;
  final dynamic message;
  final Data? data;
  final int? count;

  LoginDataModel({
    this.error,
    this.message,
    this.data,
    this.count,
  });

  factory LoginDataModel.fromJson(Map<String, dynamic> json) => LoginDataModel(
    error: json["error"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": data?.toJson(),
    "count": count,
  };
}

class Data {
  final String? token;
  final User? user;

  Data({
    this.token,
    this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "user": user?.toJson(),
  };
}

class User {
  final String? id;
  final String? fullName;
  final String? email;
  final dynamic phoneNumber;
  final int? role;
  final dynamic restaurantId;
  final dynamic restaurantName;
  final String? driverId;
  final String? driverName;

  User({
    this.id,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.role,
    this.restaurantId,
    this.restaurantName,
    this.driverId,
    this.driverName,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    fullName: json["fullName"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    role: json["role"],
    restaurantId: json["restaurantId"],
    restaurantName: json["restaurantName"],
    driverId: json["driverId"],
    driverName: json["driverName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "email": email,
    "phoneNumber": phoneNumber,
    "role": role,
    "restaurantId": restaurantId,
    "restaurantName": restaurantName,
    "driverId": driverId,
    "driverName": driverName,
  };
}