import 'package:delivery/common/models/textfield_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SwitchButton extends StatefulWidget {
  final TextFieldDataObject fieldDataObject;
  final Map<String, String> optionOne;
  final Map<String, String> optionTwo;
  final Function(String value)? onTap;
  const SwitchButton({
    super.key,
    required this.fieldDataObject,
    this.onTap,
    required this.optionOne,
    required this.optionTwo
  });

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {

  bool flag = true;

  @override
  void initState() {
    if( widget.fieldDataObject.controller.text.isEmpty ){
      widget.fieldDataObject.controller.text = widget.optionOne['value'].toString();
    } else {
      widget.fieldDataObject.controller.text = widget.fieldDataObject.controller.text;
      widget.fieldDataObject.controller.text == "true" ? flag = false : flag = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.fieldDataObject.lable != null ?
        Padding(
          padding: EdgeInsetsDirectional.only(bottom: 5.sp, start: 5.sp),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: widget.fieldDataObject.lable!,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp
                  )
                ),
              ] + (
                widget.fieldDataObject.isRequired ?
                const [TextSpan(
                  text: "*",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold
                  )
                )] : []
              )
            )
          ),
        ) : const SizedBox(),

        SizedBox(
          height: ScreenUtil().setHeight(45),
          child: Row(
            children: [
              SwitchWidget(
                isSelected: flag,
                text: widget.optionOne['name'].toString(),
                onTap: () {
                  widget.fieldDataObject.controller.text = widget.optionOne['value'].toString();
                  if( widget.onTap != null ){
                    widget.onTap!("true");
                  }
                  setState(() => flag = true);
                }
              ),
              SizedBox(width: ScreenUtil().setHeight(10)),
              SwitchWidget(
                isSelected: !flag,
                text: widget.optionTwo['name'].toString(),
                onTap: () {
                  widget.fieldDataObject.controller.text = widget.optionTwo['value'].toString();
                  if( widget.onTap != null ){
                    widget.onTap!("true");
                  }
                  setState(() => flag = false);
                }
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SwitchWidget extends StatelessWidget {
  final bool isSelected;
  final Function onTap;
  final String text;
  const SwitchWidget({super.key, this.isSelected = false, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => onTap(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOutCubic,
          height: double.infinity,
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.transparent,
            border: Border.all(
              color: isSelected ? Colors.blue : Colors.grey,
              width: 0.5.sp
            ),
            borderRadius: BorderRadius.circular(ScreenUtil().setHeight(5)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 400), curve: Curves.easeInOutCubic,
                width: ScreenUtil().setHeight(20), height: ScreenUtil().setHeight(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: isSelected ? Colors.blue : Colors.grey,
                    width: isSelected ? ScreenUtil().setHeight(5) : ScreenUtil().setHeight(1)
                  ),
                  borderRadius: BorderRadius.circular(ScreenUtil().setHeight(40))
                ),
              ),
        
              SizedBox(width: ScreenUtil().setHeight(10)),
        
              Text(
                text,
                style: TextStyle(
                  color: isSelected ? Colors.blue : Colors.grey,
                  fontSize: ScreenUtil().setHeight(14),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}