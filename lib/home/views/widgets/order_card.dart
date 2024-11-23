// ignore_for_file: use_build_context_synchronously

import 'package:delivery/home/controllers/home/home_cubit.dart';
import 'package:delivery/home/models/list_of_orders_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderCard extends StatelessWidget {
  final Datum order;

  const OrderCard({super.key, required this.order});

  Future<void> _openGoogleMaps(String locationUrl) async {
    if (await canLaunchUrl(Uri.parse(locationUrl))) {
      await launchUrl(Uri.parse(locationUrl));
    } else {
      throw 'Could not open Google Maps URL: $locationUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
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
            onTap: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('تغيير حالة الطلب'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await context.read<HomeCubit>().changeOrderStatus(4, order.id!);
                        await context.read<HomeCubit>().getCurrentOrders();
                        Navigator.pop(context);
                      },
                      child: const Text('جاري التوصيل'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await context.read<HomeCubit>().changeOrderStatus(5, order.id!);
                        await context.read<HomeCubit>().getCurrentOrders();
                        Navigator.pop(context);
                      },
                      child: const Text('تم التوصيل'),
                    ),
                  ],
                ),
              ),
            ),
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
                        'رقم الطلب #${order.orderNumber}',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(16),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'الحالة: ${order.status == 1 ? 'لديه سائق' : order.status == 2 ? 'ملغي من قبل السائق' : order.status == 3 ? 'ذاهب للمطعم' : order.status == 4 ? 'جاري التوصيل' : order.status == 5 ? 'تم التوصيل' : order.status == 6 ? 'ملغي' : ''}',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (order.customerPhoneNumber != null)
                            SelectableText(
                              "الهاتف: ${order.customerPhoneNumber!}",
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(14),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          Text(
                            "المطعم: ${order.restaurantName ?? ""}",
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "الى منطقة: ${order.districtName ?? ""}",
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.map),
                        onPressed: () {
                          final locationUrl = order.restaurantLocation ?? '';
                          if (locationUrl.isNotEmpty) {
                            _openGoogleMaps(locationUrl);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('رابط الموقع غير متوفر')),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'مبلغ الطلب: ${order.price}',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: ScreenUtil().setSp(14),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'تكلفة التوصيل: ${order.deliveryFee}',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: ScreenUtil().setSp(14),
                          fontWeight: FontWeight.bold,
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
