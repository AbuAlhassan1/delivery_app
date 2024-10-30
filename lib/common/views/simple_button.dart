import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SimpleButton extends StatefulWidget {
  final Function? onTap;
  const SimpleButton({super.key, this.onTap});

  @override
  State<SimpleButton> createState() => _SimpleButtonState();
}

class _SimpleButtonState extends State<SimpleButton> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(ScreenUtil().setHeight(5)),
      color: Colors.blue,
      child: InkWell(
        onTap: () async {
          if( widget.onTap != null ){
            setState(() => isLoading = true);
            await widget.onTap!();
            // await Future.delayed(const Duration(seconds: 2));
            setState(() => isLoading = false);
          }
          
        },
        child: SizedBox(
          height: ScreenUtil().setHeight(50),
          width: double.infinity,
          child: Center(
            child: isLoading ? CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 1.sp,
            ) : const  Text(
              'الدخول',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}