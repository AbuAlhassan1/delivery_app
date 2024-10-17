import 'package:flutter/material.dart';

abstract class FieldDataObject {
  late String? name;
  late AnimationController animationController;
  bool validate({String? err});
  void reset();
}