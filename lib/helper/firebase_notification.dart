// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:delivery/common/controllers/cubit/orders_notification_cubit_cubit.dart';
import 'package:delivery/helper/notification/notification_order_card.dart';
import 'package:delivery/home/models/list_of_orders_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowy_borders/glowy_borders.dart';

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
      context.read<OrdersNotificationCubitCubit>().orders = jsonDecode(message.data['orders'].toString());
      showDialog(
        context: context,
        barrierColor: Colors.transparent,
        builder: (context) => AlertNotification(notification: message),
      );
    }
  });

  // Listen when the app is in background but opened and the notification is tapped
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async{
    log('background Message data: ${message.data}');
    if (message.notification != null) {
      context.read<OrdersNotificationCubitCubit>().orders = jsonDecode(message.data['orders'].toString());
      await Future.delayed(const Duration(seconds: 2));
      showDialog(
        context: context,
        barrierColor: Colors.transparent,
        builder: (context) => AlertNotification(notification: message),
      );
    }
  });

  // Listen when the app is closed and the notification is tapped
  RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    log('closed Message data: ${initialMessage.data}');
    if (initialMessage.notification != null) {
      context.read<OrdersNotificationCubitCubit>().orders = jsonDecode(initialMessage.data['orders'].toString());
      await Future.delayed(const Duration(seconds: 2));
      showDialog(
        context: context,
        barrierColor: Colors.transparent,
        builder: (context) => AlertNotification(notification: initialMessage),
      );
    }
  }
}

class AlertNotification extends StatelessWidget {
  final RemoteMessage notification;
  const AlertNotification({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {

    return AnimatedGradientBorder(
      borderSize: 5,
      glowSize: 2,
      gradientColors: const [
        Colors.blue,
        Colors.orange,
        Colors.green,
      ],
      // animationProgress: currentProgress,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('طلبات جديدة'),
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(20),
                    left: ScreenUtil().setWidth(20),
                    right: ScreenUtil().setWidth(20),
                  ),
                  child: BlocBuilder<OrdersNotificationCubitCubit, OrdersNotificationCubitState>(
                    builder: (context, state) {
                      return Column(
                        children: List.generate(
                            context.read<OrdersNotificationCubitCubit>().orders.length,
                            (index) => Padding(
                              padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
                              child: NotificationOrderCard(order: Datum.fromJson(context.read<OrdersNotificationCubitCubit>().orders[index])),
                            )
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
