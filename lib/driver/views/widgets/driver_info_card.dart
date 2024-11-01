// ignore_for_file: use_build_context_synchronously

import 'package:delivery/auth/controllers/auth/auth_cubit.dart';
import 'package:delivery/driver/controllers/driver_info/driver_info_cubit.dart';
import 'package:delivery/home/controllers/home/home_cubit.dart';
import 'package:delivery/home/views/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:go_router/go_router.dart';

class DriverInfoCard extends StatelessWidget {
  const DriverInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverInfoCubit, DriverInfoState>(
      builder: (context, state) {
        return Positioned(
          top: 0, bottom: 0, left: 0, right: 0,
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.only(
                bottom: ScreenUtil().setHeight(20),
                top: ScreenUtil().setHeight(30)
              ),
              margin: EdgeInsets.only(
                left: ScreenUtil().setHeight(20),
                right: ScreenUtil().setHeight(20),
                bottom: ScreenUtil().setHeight(20),
                top: ScreenUtil().setHeight( (MediaQuery.of(context).size.width / 2.5) )
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black.withOpacity(0.2),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 5,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    context.read<DriverInfoCubit>().driverInfo!.data?.driverName ?? '',
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)
                  ),
                  Text(
                    context.read<DriverInfoCubit>().driverInfo!.data?.email ?? '',
                    style: TextStyle(color: Colors.grey, fontSize: 14.sp, fontWeight: FontWeight.normal)
                  ),

                  SizedBox(height: ScreenUtil().setHeight(20)),

                  const Divider(color: Colors.grey, height: 0, thickness: 0.3),

                  // SizedBox(height: ScreenUtil().setHeight(20)),
            
                  ListTile(
                    onTap: () {},
                    leading: const Icon(TablerIcons.user),
                    title: const Text('Full Name'),
                    trailing: Text(
                      context.read<DriverInfoCubit>().driverInfo!.data?.fullName ?? '',
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.normal)
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(TablerIcons.tax),
                    title: const Text('Total Tax'),
                    trailing: Text(
                      context.read<DriverInfoCubit>().driverInfo!.data?.totalTax.toString() ?? '',
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.normal)
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(TablerIcons.clock),
                    title: const Text('Online Period'),
                    trailing: Text(
                      "${context.read<DriverInfoCubit>().driverInfo!.data?.onlineFrom!} -- ${context.read<DriverInfoCubit>().driverInfo!.data?.onlineTo!}",
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.normal)
                    ),
                  ),
                  ListTile(
                    // show all orders ...
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) {
                        return Scaffold(
                          appBar: AppBar(
                            title: const Text('كل الطلبات', style: TextStyle(color: Colors.black)),
                            backgroundColor: Colors.white,
                            leading: IconButton(
                              icon: const Icon(Icons.arrow_back, color: Colors.black),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                          body: BlocBuilder<HomeCubit, HomeState>(
                            builder: (context, state) {
                              if( state is HomeLoading ){
                                return const Center(child: CircularProgressIndicator());
                              } else if( state is HomeError ){
                                return const Center(child: Text('حدث خطأ ما'));
                              }
                              return context.read<HomeCubit>().listOfOrdersModel != null ? RefreshIndicator(
                                onRefresh: () async => await context.read<HomeCubit>().getAllOrders(),
                                child: ListView.builder(
                                  padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(20), vertical: ScreenUtil().setHeight(20)),
                                  itemCount: context.read<HomeCubit>().listOfOrdersModel!.data!.length,
                                  itemBuilder: (context, index) {
                                    return OrderCard(order: context.read<HomeCubit>().listOfOrdersModel!.data![index]);
                                  },
                                ),
                              ) : const Center(child: Text('حدث خطأ ما'));
                            }
                          ),
                        );
                      }
                    ),
                    leading: const Icon(Icons.list_alt_rounded, color: Colors.black),
                    title: const Text('كل الطلبات', style: TextStyle(color: Colors.black)),
                  ),
                  ListTile(
                    onTap: () async {
                      await context.read<AuthCubit>().logout();
                      context.go('/login');
                    },
                    leading: const Icon(TablerIcons.logout, color: Colors.red),
                    title: const Text('تسجيل الخروج', style: TextStyle(color: Colors.red)),
                  ),
            
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
