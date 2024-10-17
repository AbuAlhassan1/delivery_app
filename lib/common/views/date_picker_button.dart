// import 'dart:developer';
import 'dart:developer';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:delivery/common/models/textfield_model.dart';
import 'package:fluent_ui/fluent_ui.dart' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:scroll_date_picker/scroll_date_picker.dart';

class DatePickerButton extends ui.StatefulWidget {
  final TextFieldDataObject fieldDataObject;
  const DatePickerButton({super.key, required this.fieldDataObject});

  @override
  ui.State<DatePickerButton> createState() => _DatePickerButtonState();
}

class _DatePickerButtonState extends ui.State<DatePickerButton> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return FormField(
      validator: (x){
        return widget.fieldDataObject.validator(widget.fieldDataObject.regex, widget.fieldDataObject.controller.text);
      },
      builder: (field) => ui.Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(ScreenUtil().setHeight(5)),
            onTap: () => showDialog(
              context: context,
              builder: (context) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
                    margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(20)),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(ScreenUtil().setHeight(10))
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 300.sp,
                          child: CalendarDatePicker2(
                            config: CalendarDatePicker2Config(
                              animateToDisplayedMonthDate: true,
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now()
                            ),
                            value: const [],
                            onValueChanged: (dates) {
                              selectedDate = dates.first;
                              log(selectedDate.toString());
                            },
                          ),
                        ),
                    
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(20)),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    widget.fieldDataObject.controller.text = selectedDate != null ? selectedDate.toString().split(" ")[0] : "";
                                    setState((){});
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("تم"),
                                )
                              ),
                              SizedBox(width: ScreenUtil().setHeight(10)),
                              Expanded(
                                child: TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text("الغاء"),
                                )
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // inputElement.dispatchEvent(new Event('change', { bubbles: true }));
            child: ui.Row(
              children: [
                Expanded(
                  child: ui.Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.fieldDataObject.lable != null ?
                      Padding(
                        padding: EdgeInsetsDirectional.only(bottom: ScreenUtil().setHeight(5), start: ScreenUtil().setHeight(5)),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: widget.fieldDataObject.lable!,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: ScreenUtil().setHeight(12)
                                )
                              ),
                            ] + (
                              widget.fieldDataObject.isRequired ?
                              [TextSpan(
                                text: "*",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: ScreenUtil().setHeight(14),
                                )
                              )] : []
                            )
                          )
                        ),
                      ) : const SizedBox(),
                      Container(
                        height: ScreenUtil().setHeight(60),
                        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(15)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(ScreenUtil().setHeight(5)),
                          border: Border.all(color: Colors.grey.withOpacity(0.3))
                        ),
                        child: ui.Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.fieldDataObject.controller.text.isEmpty ? "يوم - شهر - سنة" : widget.fieldDataObject.controller.text,
                              style: TextStyle(
                                fontSize: ScreenUtil().setHeight(14),
                                color: widget.fieldDataObject.controller.text.isEmpty ? Colors.grey : Colors.black
                              ),
                            ),
          
                            const Icon(Icons.calendar_month_outlined, color: Colors.grey)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        
          field.hasError ? Text(
            field.errorText.toString(),
            style: TextStyle(
              color: Colors.red,
              fontSize: ScreenUtil().setHeight(14)
            ),
          ) : const SizedBox()
        ],
      ),
    );
  }
}