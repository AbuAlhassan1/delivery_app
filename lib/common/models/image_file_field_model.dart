import 'dart:io';
import 'package:delivery/common/models/field_data_object.dart';
import 'package:flutter/material.dart';

class ImageFileFieldDataObject implements FieldDataObject {
  @override
  late String? name;
  late String? lable;
  late String? hint;
  late Widget? icon;
  late String? error;
  late File? file;
  @override
  late AnimationController animationController;
  late bool isRequired;

  ImageFileFieldDataObject({
    required this.name,
    this.file,
    this.isRequired = false,
    this.icon,
    this.lable,
    this.error,
    this.hint,
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
    // controller.clear();
    error = null;
  }
}