import 'dart:convert';
import 'dart:io';

FileApiPayloadObjectModel fileApiPayloadObjectModelFromJson(String str) => FileApiPayloadObjectModel.fromJson(json.decode(str));
String fileApiPayloadObjectModelToJson(FileApiPayloadObjectModel data) => json.encode(data.toJson());

class FileApiPayloadObjectModel {
  final String? id;
  final File? file;

  FileApiPayloadObjectModel({
    required this.id,
    required this.file,
  });

  factory FileApiPayloadObjectModel.fromJson(Map<String, dynamic> json) => FileApiPayloadObjectModel(
    id: json["id"],
    file: json["file"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "file": file,
  };
}
