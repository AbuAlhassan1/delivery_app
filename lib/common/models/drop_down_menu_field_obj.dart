import 'package:delivery/common/models/textfield_model.dart';
import 'package:flutter/material.dart';

typedef GetData<T> = Future<List<T>?> Function(BuildContext context)?;
typedef OnSelect = Future<void> Function (dynamic selectedItem, BuildContext context);

class DropDownMenuFieldObject<T> extends TextFieldDataObject {
  T? selectedItem;
  List<T> items = [];
  final GetData getData;
  final OnSelect onSelect;
  final ValueNotifier valueNotifier;
  // final bool isRequired;
  DropDownMenuFieldObject({
    this.getData,
    required this.onSelect,
    required this.valueNotifier,
    required super.name,
    required super.validator,
    super.lable,
    super.isRequired = false
  });
}