import 'dart:convert';

List<PermissionsModel> permissionsModelFromJson(String str) => List<PermissionsModel>.from(json.decode(str).map((x) => PermissionsModel.fromJson(x)));
String permissionsModelToJson(List<PermissionsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PermissionsModel {
  final String? name;
  final String? label;
  final bool? isGranted;

  PermissionsModel({
    this.name,
    this.label,
    this.isGranted,
  });

  String subject() => name!.split('.')[1];
  String? action() {
    if( name!.split('.').length < 3 ){
      return null;
    }
    return name!.split('.')[2];
  }

  factory PermissionsModel.fromJson(Map<String, dynamic> json) => PermissionsModel(
    name: json["name"],
    label: json["label"],
    isGranted: json["isGranted"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "label": label,
    "isGranted": isGranted,
  };
}
