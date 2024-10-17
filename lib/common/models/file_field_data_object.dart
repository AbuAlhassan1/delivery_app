import 'dart:io';
import 'package:delivery/common/models/field_data_object.dart';
import 'package:flutter/material.dart';

class FileFieldDataObject implements FieldDataObject {
  @override
  late String? name;
  late String? lable;
  late String? error;
  late String? preview;
  late File? file;
  late int? fileSizeInMegaBytes;
  @override
  late AnimationController animationController;
  late bool isRequired;
  late String? Function(File? file, String? preview)? validator;

  FileFieldDataObject({
    required this.name,
    this.isRequired = false,
    this.file,
    this.lable,
    this.preview,
    this.error,
    this.validator,
    this.fileSizeInMegaBytes,
  });

  void vibrate() async {
    // bool? hasVib = await Vibration.hasVibrator();

    // if ( hasVib != null && hasVib ) {
    //   animationController.forward()
    //   .then((value) => animationController.reverse());
    //   Vibration.vibrate();
    // }
  }

  @override
  bool validate({String? err}) {
    return true;
  }
  
  @override
  void reset() {
    file = null;
    error = null;
  }
}