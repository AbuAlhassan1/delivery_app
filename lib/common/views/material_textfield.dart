// ignore_for_file: must_be_immutable
// import 'package:auto_direction/auto_direction.dart';
import 'package:delivery/common/models/textfield_model.dart';
import 'package:delivery/common/views/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class MaterialTextField extends StatefulWidget {
  final TextFieldDataObject textFieldDataObject;
  final Widget? icon;
  final EdgeInsetsGeometry? margin;
  final GlobalKey<FormState>? formKey;
  final bool enabled;
  final bool isTextArea;
  final bool isPassword;
  final bool isDropDownMenu;
  final Function(String value)? onChange;
  
  const MaterialTextField({
    super.key,
    required this.textFieldDataObject,
    this.icon,
    this.margin,
    this.formKey,
    this.onChange,
    this.enabled = true,
    this.isTextArea = false,
    this.isPassword = false,
    this.isDropDownMenu = false
  });

  @override
  State<MaterialTextField> createState() => _MaterialTextFieldState();
}

class _MaterialTextFieldState extends State<MaterialTextField> with SingleTickerProviderStateMixin {

  bool isOnchangeLoding = false;
  bool hidePassword = true;

  GlobalKey x = GlobalKey();
  
  // late AnimationController controller;
  late Animation<Offset> animation;

  void onChange(String x) async {      
    // if ( widget.textFieldDataObject.regex != null && !widget.textFieldDataObject.regex!.hasMatch(x) ){
    //   vibrate();
    // }
    
    setState(() {});
    if(widget.onChange != null){
      if( !isOnchangeLoding ){
        isOnchangeLoding = true;
        await widget.onChange!(x);
        isOnchangeLoding = false;
      }
    }
  }

  void vibrate() async {
    // bool? hasVib = await Vibration.hasVibrator();
    // if ( hasVib != null && hasVib ) {
    //   widget.textFieldDataObject.animationController.forward()
    //   .then((value) => widget.textFieldDataObject.animationController.reverse());
    //   Vibration.vibrate();
    // }
  }

  @override
  void initState() {
    widget.textFieldDataObject.animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
    animation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.05, 0),
    ).animate(CurvedAnimation(parent: widget.textFieldDataObject.animationController, curve: Curves.easeInOutBack));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.textFieldDataObject.lable != null ?
        GestureDetector(
          // onTap: () => widget.textFieldDataObject.focusNode.requestFocus(),
          onTap: () => FocusScope.of(context).requestFocus(widget.textFieldDataObject.focusNode),
          child: Padding(
            padding: EdgeInsetsDirectional.only(bottom: ScreenUtil().setHeight(5), start: ScreenUtil().setHeight(5)),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: widget.textFieldDataObject.lable!,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setHeight(12)
                    )
                  ),
                ] + (
                  widget.textFieldDataObject.isRequired ?
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
          ),
        ) : const SizedBox(),
        SlideTransition(
          position: animation,
          child: TextFormField(
            controller: widget.textFieldDataObject.controller,
            focusNode: widget.textFieldDataObject.focusNode,
            enabled: widget.enabled,
            textInputAction: TextInputAction.next,
            maxLines: widget.isTextArea ? 3 : 1,
            minLines: widget.isTextArea ? 3 : 1,
            style: TextStyle(fontSize: ScreenUtil().setHeight(16), color: widget.textFieldDataObject.error != null ? DimsColors.error : Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w400),
            textAlignVertical: TextAlignVertical.top,
            onChanged: onChange,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              String? validator = widget.textFieldDataObject.validator(widget.textFieldDataObject.regex, value);
              // if( validator != null ){
              //   vibrate();
              // }
              return validator;
            },
            obscureText: widget.isPassword ? hidePassword : false,
            decoration: InputDecoration(
              filled: true,
              fillColor: widget.textFieldDataObject.error != null ? DimsColors.lighterError : Colors.white,
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ScreenUtil().setHeight(5)),
                borderSide: BorderSide(
                  color: widget.textFieldDataObject.error != null ? DimsColors.error : Colors.grey.withOpacity(0.3)
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ScreenUtil().setHeight(5)),
                borderSide: BorderSide(
                  color: widget.textFieldDataObject.error != null ? DimsColors.error : Colors.grey
                )
              ),
              disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(ScreenUtil().setHeight(5)), borderSide: BorderSide(color: Colors.grey.withOpacity(0.2))),
              errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(ScreenUtil().setHeight(5)), borderSide: BorderSide(color: DimsColors.error)),
              focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(ScreenUtil().setHeight(5)), borderSide: BorderSide(color: DimsColors.error)),
              // contentPadding: EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(10)),
              hintText: widget.textFieldDataObject.hint,
              hintStyle: const TextStyle(fontFamily: "PublicSans"),
              prefixIcon: widget.icon != null ? Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(10)),
                child: (widget.isTextArea ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: ScreenUtil().setHeight(100),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: ScreenUtil().setHeight(15)),
                            child: widget.icon!,
                          ),
                        ],
                      ),
                    ),
                  ],
                ) : widget.icon),
              ) : null,
              suffixIcon: widget.isDropDownMenu ?
              Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey, size: ScreenUtil().setHeight(20)) :
              (widget.isPassword ? IconButton(
                icon: Icon(hidePassword ? TablerIcons.eye_closed : TablerIcons.eye, size: ScreenUtil().setHeight(20)),
                onPressed: () => setState(() => hidePassword = !hidePassword),
              ) : null),
              prefixIconColor: widget.textFieldDataObject.error != null ? DimsColors.error : Theme.of(context).colorScheme.primary,
              errorMaxLines: 1,
            ),
          ),
        ),
      ],
    );
  }
}