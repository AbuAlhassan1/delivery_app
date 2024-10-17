import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SimpleButton extends StatelessWidget {
  final Function? onTap;
  const SimpleButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(ScreenUtil().setHeight(5)),
      color: Colors.blue,
      child: InkWell(
        onTap: () => onTap != null ? onTap!() : log('No onTap function'),
        child: SizedBox(
          height: ScreenUtil().setHeight(50),
          width: double.infinity,
          child: const Center(
            child: Text(
              'Login',
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