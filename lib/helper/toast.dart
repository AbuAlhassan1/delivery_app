import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';

void showToast({
  required String message,
  required ToastType toastType
}) {
  // Fluttertoast.showToast(
  //   msg: message,
  //   toastLength: Toast.LENGTH_LONG,
  //   gravity: ToastGravity.TOP,
  //   timeInSecForIosWeb: 1,
  //   backgroundColor:  toastType == ToastType.error ? Colors.red :
  //   toastType == ToastType.sucsess ? Colors.green : Colors.orange,
  //   textColor: Colors.white,
  //   fontSize: ScreenUtil().setHeight(16),
  // );

  showToastWidget(
    Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(15)),
        decoration: BoxDecoration(
          color: toastType == ToastType.error ? const Color.fromARGB(255, 255, 170, 164) :
          toastType == ToastType.sucsess ? const Color.fromARGB(255, 167, 254, 170) : const Color.fromARGB(255, 255, 220, 168),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              toastType == ToastType.error ? Icons.error :
              toastType == ToastType.sucsess ? Icons.check :
              Icons.warning_amber_rounded,
              color: toastType == ToastType.error ? Colors.red :
              toastType == ToastType.sucsess ? Colors.green : Colors.orange,
            ),
            SizedBox(width: ScreenUtil().setHeight(10)),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: toastType == ToastType.error ? Colors.red :
                  toastType == ToastType.sucsess ? Colors.green : Colors.orange,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ],
        )
      ),
    ),
    duration: const Duration(seconds: 4),
    dismissOtherToast: true,
    position: ToastPosition.top
  );
}

enum ToastType {
  warning,
  sucsess,
  error,
}