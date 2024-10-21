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
  final String? email;
  final int? totalTax;
  final bool? isActive;
  final Online? onlineFrom;
  final Online? onlineTo;

  Data({
    this.id,
    this.fullName,
    this.phoneNumber,
    this.driverName,
    this.email,
    this.totalTax,
    this.isActive,
    this.onlineFrom,
    this.onlineTo,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    fullName: json["fullName"],
    phoneNumber: json["phoneNumber"],
    driverName: json["driverName"],
    email: json["email"],
    totalTax: json["totalTax"],
    isActive: json["isActive"],
    onlineFrom: json["onlineFrom"] == null ? null : Online.fromJson(json["onlineFrom"]),
    onlineTo: json["onlineTo"] == null ? null : Online.fromJson(json["onlineTo"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "phoneNumber": phoneNumber,
    "driverName": driverName,
    "email": email,
    "totalTax": totalTax,
    "isActive": isActive,
    "onlineFrom": onlineFrom?.toJson(),
    "onlineTo": onlineTo?.toJson(),
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
