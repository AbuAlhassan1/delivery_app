import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';

void showToast({
  required String message,
  required ToastType toastType
}) {

  showToastWidget(
    Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(15)),
        decoration: BoxDecoration(
          color: toastType == ToastType.error ? const Color(0xFFFFD5D2) :
          toastType == ToastType.success ? const Color.fromARGB(255, 167, 254, 170) : const Color.fromARGB(255, 255, 220, 168),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              toastType == ToastType.error ? Icons.error :
              toastType == ToastType.success ? Icons.check :
              Icons.warning_amber_rounded,
              color: toastType == ToastType.error ? Colors.red :
              toastType == ToastType.success ? Colors.green : Colors.orange,
            ),
            SizedBox(width: ScreenUtil().setHeight(10)),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: toastType == ToastType.error ? Colors.red :
                  toastType == ToastType.success ? Colors.green : Colors.orange,
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
  success,
  error,
}