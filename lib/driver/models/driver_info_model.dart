import 'dart:convert';

DriverInfoModel driverInfoModelFromJson(String str) => DriverInfoModel.fromJson(json.decode(str));
String driverInfoModelToJson(DriverInfoModel data) => json.encode(data.toJson());

class DriverInfoModel {
  final bool? error;
  final dynamic message;
  final Data? data;
  final int? count;

  DriverInfoModel({
    this.error,
    this.message,
    this.data,
    this.count,
  });

  factory DriverInfoModel.fromJson(Map<String, dynamic> json) => DriverInfoModel(
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
  final String? id;
  final String? fullName;
  final dynamic phoneNumber;
  final String? driverName;
  final String? driverId;
  final String? email;
  final double? totalTax;
  final bool? isActive;
  final bool? isWorking;
  final String? onlineFrom;
  final String? onlineTo;

  Data({
    this.id,
    this.fullName,
    this.phoneNumber,
    this.driverName,
    this.driverId,
    this.email,
    this.totalTax,
    this.isActive,
    this.isWorking,
    this.onlineFrom,
    this.onlineTo,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    fullName: json["fullName"],
    phoneNumber: json["phoneNumber"],
    driverName: json["driverName"],
    driverId: json["driverId"],
    email: json["email"],
    totalTax: json["totalTax"],
    isActive: json["isActive"],
    isWorking: json["isWorking"],
    onlineFrom: json["onlineFrom"],
    onlineTo: json["onlineTo"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "phoneNumber": phoneNumber,
    "driverName": driverName,
    "driverId": driverId,
    "email": email,
    "totalTax": totalTax,
    "isActive": isActive,
    "isWorking": isWorking,
    "onlineFrom": onlineFrom,
    "onlineTo": onlineTo,
  };
}

class Online {
  final int? h;
  final String? a;

  Online({
    this.h,
    this.a,
  });

  factory Online.fromJson(Map<String, dynamic> json) => Online(
    h: json["h"],
    a: json["a"],
  );

  Map<String, dynamic> toJson() => {
    "h": h,
    "a": a,
  };
}
