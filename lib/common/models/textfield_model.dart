import 'package:delivery/common/models/field_data_object.dart';
import 'package:flutter/material.dart';

class TextFieldDataObject implements FieldDataObject {
  @override
  late String? name;
  late TextInputType? textInputType;
  late String? lable;
  late String? hint;
  final bool isPassword;
  late Widget? icon;
  late String? error;
  late RegExp? regex;
  late TextEditingController controller;
  @override
  late AnimationController animationController;
  late GlobalKey key;
  late GlobalKey<FormState>? formKey;
  late FocusNode focusNode;
  late bool isRequired;
  late String? Function(RegExp? regex, String? value) validator;

  TextFieldDataObject({
    required this.name,
    required this.validator,
    this.textInputType = TextInputType.text,
    this.isPassword = false,
    this.isRequired = false,
    this.icon,
    this.formKey,
    this.lable,
    this.error,
    this.hint,
    this.regex,
  }){
    controller = TextEditingController();
    focusNode = FocusNode();
    key = GlobalKey();
  }

  void vibrate() async {
    // bool? hasVib = await Vibration.hasVibrator();

    // if ( hasVib != null && hasVib ) {
    //   animationController.forward()
    //   .then((value) => animationController.reverse());
    //   if( await Vibration.hasVibrator() != null && (await Vibration.hasVibrator())! ){
    //     Vibration.vibrate();
    //   }
    // }
  }

  @override
  bool validate({String? err}) {
    if(regex == null && controller.text.isEmpty){
      error = "لايمكنك ترك الحقل فارغ!";
      vibrate();
      return false;
    } else if ( regex != null ){
      bool isValid = regex!.hasMatch(controller.text);

      if(isValid){
        error = null;
        return true;
      }
      error = err;
      vibrate();
      return false;
    }else {
      error = null;
      return true;
    }
  }
  
  @override
  void reset() {
    controller.clear();
    error = null;
  }
}