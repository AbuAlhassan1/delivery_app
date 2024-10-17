import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePageWrapper extends StatelessWidget {
  const HomePageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(ScreenUtil().setHeight(50)),
              child: const FittedBox(child: CircleAvatar()),
            )
          ),
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Total Orders: 0"),
                Text("Orders Today: 0"),
                Text("Total Tax Should Pay: 0"),
              ],
            )
          ),
        ],
      ),
    );
  }
}