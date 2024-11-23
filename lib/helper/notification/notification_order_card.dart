// ignore_for_file: use_build_context_synchronously

import 'package:delivery/common/controllers/cubit/orders_notification_cubit_cubit.dart';
import 'package:delivery/home/controllers/home/home_cubit.dart';
import 'package:delivery/home/models/list_of_orders_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationOrderCard extends StatefulWidget {
  final Datum order;
  const NotificationOrderCard({super.key, required this.order});

  @override
  State<NotificationOrderCard> createState() => _NotificationOrderCardState();
}

class _NotificationOrderCardState extends State<NotificationOrderCard> {

  bool isLoading = false;

  decide(bool x) async {
    if( !isLoading ) {
      setState(() => isLoading = true);
      await context.read<HomeCubit>().acceptOrRejectOrder(widget.order.id!, x);
      await context.read<HomeCubit>().getCurrentOrders();
      setState(() => isLoading = false);
      context.read<OrdersNotificationCubitCubit>().removeOrder(
        context.read<OrdersNotificationCubitCubit>().orders.indexWhere((element) => element['id'] == widget.order.id)
      );
      if( context.read<OrdersNotificationCubitCubit>().orders.isEmpty ) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          clipBehavior: Clip.none,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: EdgeInsets.all(ScreenUtil().setHeight(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'رقم الطلب #${widget.order.orderNumber}',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(16),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'الحالة: ${
                          widget.order.status == 1 ? 'لديه سائق' :
                          widget.order.status == 2 ? 'ملغي من قبل السائق' :
                          widget.order.status == 3 ? 'ذاهب للمطعم' :
                          widget.order.status == 4 ? 'جاري التوصيل' :
                          widget.order.status == 5 ? 'تم التوصيل' :
                          widget.order.status == 6 ? 'ملغي' : ''
                        }',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(14),
                          // color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      
                      // const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.order.customerPhoneNumber != null ?
                          SelectableText(
                            "الهاتف: ${widget.order.customerPhoneNumber!}",
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.bold,
                            ),
                          ) : const SizedBox(),
                          Text(
                            "المطعم: ${widget.order.restaurantName?? ""}",
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "الى منطقة: ${widget.order.districtName?? ""}",
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'مبلغ الطلب: ${widget.order.price?? "--"}',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: ScreenUtil().setSp(14),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'تكلفة التوصيل: ${widget.order.deliveryFee?? "--"}',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: ScreenUtil().setSp(14),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                
                  const SizedBox(height: 10),

                  const Divider(color: Colors.grey, thickness: 1),

                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () async => decide(true),
                          child: isLoading ? SizedBox(
                            width: 20.sp, height: 20.sp,
                            child: CircularProgressIndicator(color: Colors.black, strokeWidth: 1.sp)
                          )
                          : const Text(
                            "قبول الطلب",
                            style: TextStyle(
                              color: Colors.green,
                            ),
                          )
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () async => decide(false),
                          child: isLoading ? SizedBox(
                            width: 20.sp, height: 20.sp,
                            child: CircularProgressIndicator(color: Colors.black, strokeWidth: 1.sp)
                          )
                          : const Text(
                            "رفض الطلب",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          )
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}