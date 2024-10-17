import 'dart:developer';
import 'package:delivery/common/models/drop_down_menu_field_obj.dart';
import 'package:delivery/common/views/material_textfield.dart';
import 'package:flutter/material.dart';
import 'package:spinner_dropdown/spinner.dart';

typedef GetInputName = String Function(Object item)?;

class DropDownMenuWithSearch2 extends StatefulWidget {
  final DropDownMenuFieldObject fieldObject;
  const DropDownMenuWithSearch2({
    super.key,
    required this.fieldObject,
  });
  
  @override
  State<DropDownMenuWithSearch2> createState() => _DropDownMenuWithSearch2State();
}

class _DropDownMenuWithSearch2State<T> extends State<DropDownMenuWithSearch2> {

  List<T> items = [];
  getItems() async {
    if( widget.fieldObject.items.isNotEmpty ){
      items = widget.fieldObject.items as List<T>;
    } else {
      if( widget.fieldObject.getData != null ){
        List<dynamic>? data = await widget.fieldObject.getData!(context);
        if( data != null ){
          items = data as List<T>;
        }
      }
    }
    setState((){});
    log(items.toString());
  }

  @override
  void initState() {
    super.initState();
    getItems();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.fieldObject.valueNotifier,
      builder: (context, value, child) {
        if( widget.fieldObject.items.isNotEmpty ){
          items = widget.fieldObject.items as List<T>;
        }
        return InkWell(
          onTap: () => SpinnerState(Spinner(
            data: [], // items.map((item) => SpinnerListItem(data: (item as Item).name)).toList(),
            // selectedItems: (selectedItem) async {
            //   widget.fieldObject.selectedItem = items.where((item) => (item as Item).name == (selectedItem.first as SpinnerListItem).data.toString()).first;
            //   await widget.fieldObject.onSelect(widget.fieldObject.selectedItem, context);
            //   widget.fieldObject.controller.text = (selectedItem.first as SpinnerListItem).data.toString();
            // },
          )).showModal(context),
          child: IgnorePointer(child: MaterialTextField(textFieldDataObject: widget.fieldObject, isDropDownMenu: true))
        );
      },
    );
  }
}