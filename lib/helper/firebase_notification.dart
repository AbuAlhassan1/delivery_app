import 'dart:convert';
import 'dart:developer';
import 'package:delivery/helper/notification/notification_order_card.dart';
import 'package:delivery/home/models/list_of_orders_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void setupFirebaseMessaging(BuildContext context) async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Request permission for notifications (iOS)
  await messaging.requestPermission();
  
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    log('Message received: ${message.notification} xxxxxxxxxxx');
  });

  await FirebaseMessaging.instance.setAutoInitEnabled(true);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    log('foreground Message data: ${message.data}');
    if (message.notification != null) {
      log('Message also contained a notification: ${message.notification!.body}');
      showDialog(
        context: context,
        builder: (context) => AlertNotification(notification: message.notification!),
      );
    }
  });
}

class AlertNotification extends StatelessWidget {
  final RemoteNotification notification;
  const AlertNotification({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {

    List orders = jsonDecode(notification.body.toString());
    log("orders: $orders");

    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20), vertical: ScreenUtil().setHeight(100)),
      child: Expanded(
        child: Container(
          padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10)),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(
                orders.length,
                (index) => NotificationOrderCard(order: Datum.fromJson(orders[index]))
              ),
            ),
          ),
        ),
      ),
    );
  }
}

