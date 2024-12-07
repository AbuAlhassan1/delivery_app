// ignore_for_file: use_build_context_synchronously

import 'package:delivery/home/controllers/home/home_cubit.dart';
import 'package:delivery/home/models/list_of_orders_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderCard extends StatefulWidget {
  final Datum order;
  final bool isHistory;

  const OrderCard({super.key, required this.order, this.isHistory = false});

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  late Datum order;
  late bool isHistory;

  @override
  void initState() {
    super.initState();
    isHistory = widget.isHistory;
    order = widget.order;
  }

  Future<void> _openGoogleMaps(String locationUrl) async {
    if (await canLaunchUrl(Uri.parse(locationUrl))) {
      await launchUrl(Uri.parse(locationUrl));
    } else {
      throw 'Could not open Google Maps URL: $locationUrl';
    }
  }

  Future<void> _showConfirmationDialog(BuildContext context, String title, int status) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('تأكيد $title'),
        content: Text('هل أنت متأكد من أنك تريد تغيير الحالة إلى "$title"؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );

    await context.read<HomeCubit>().changeOrderStatus(status, order.id!);
    await _reloadWidget();
  }

  Future<void> _reloadWidget() async {
    await Future.delayed(const Duration(seconds: 3));
    await context.read<HomeCubit>().getCurrentOrders();
    setState(() {
      order = widget.order; // Assuming order details are updated in the Cubit.
    });
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
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (!isHistory)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(150.w, 50.h),
                        ),
                        onPressed: order.status == 4 ? null : () => _showConfirmationDialog(context, 'جاري التوصيل', 4),
                        child: const Text('جاري التوصيل'),
                      ),
                    if (!isHistory)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(150.w, 50.h),
                        ),
                        onPressed: order.status == 5 ? null : () => _showConfirmationDialog(context, 'تم التوصيل', 5),
                        child: const Text('تم التوصيل'),
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
    );
  }
}
