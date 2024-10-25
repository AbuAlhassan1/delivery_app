import 'package:delivery/driver/controllers/driver_info/driver_info_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class DriverInfoCard extends StatelessWidget {
  const DriverInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverInfoCubit, DriverInfoState>(
      builder: (context, state) {
        return Positioned(
          top: 0, bottom: 0, left: 0, right: 0,
          child: Container(
            padding: EdgeInsets.only(
              // left: ScreenUtil().setHeight(20),
              // right: ScreenUtil().setHeight(20),
              bottom: ScreenUtil().setHeight(20),
              top: ScreenUtil().setHeight(30)
            ),
            margin: EdgeInsets.only(
              left: ScreenUtil().setHeight(20),
              right: ScreenUtil().setHeight(20),
              bottom: ScreenUtil().setHeight(20),
              top: ScreenUtil().setHeight(MediaQuery.of(context).size.width / 3 )
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
                    "${context.read<DriverInfoCubit>().driverInfo!.data?.onlineFrom!.h} ${context.read<DriverInfoCubit>().driverInfo!.data?.onlineFrom!.a} - ${context.read<DriverInfoCubit>().driverInfo!.data?.onlineTo!.h} ${context.read<DriverInfoCubit>().driverInfo!.data?.onlineTo!.a}",
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.normal)
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}
