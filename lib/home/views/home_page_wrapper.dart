import 'package:delivery/home/controllers/home/home_cubit.dart';
import 'package:delivery/home/views/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePageWrapper extends StatelessWidget {
  const HomePageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if ((constraints.maxWidth + 100.sp) < constraints.maxHeight) {
          return const HomeVertical();
        } else {
          return const HomeHorizontal();
        }
      },
    );
  }
}

class HomeVertical extends StatelessWidget {
  const HomeVertical({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Toggle Switch Button for is Active Driver
            BlocBuilder(
              bloc: context.read<HomeCubit>(),
              builder: (context, state) {
                return SwitchListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(20), vertical: ScreenUtil().setHeight(0)),
                  title: Text(context.read<HomeCubit>().isActiveDriver ? 'فعال' : 'غير فعال'),
                  value: context.read<HomeCubit>().isActiveDriver,
                  onChanged: (value) => context.read<HomeCubit>().toggleActiveDriver(),
                );
              },
            ),
            Expanded(
              child: Stack(
                children: [
                  ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(20), vertical: ScreenUtil().setHeight(20)),
                    itemCount: context.read<HomeCubit>().listOfOrdersModel.data!.length,
                    itemBuilder: (context, index) {
                      return OrderCard(order: context.read<HomeCubit>().listOfOrdersModel.data![index]);
                    },
                  ),
                  BlocBuilder(
                    bloc: context.read<HomeCubit>(),
                    builder: (context, state) => context.read<HomeCubit>().isActiveDriver ? const SizedBox()
                    : Container(
                      color: Colors.black.withOpacity(0.9),
                      width: double.infinity,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.warning_rounded, color: Colors.red, size: 50),
                          SizedBox(height: 10),
                          Text(
                            'يجب تفعيل الحالة لتظهر الطلبات',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}

class HomeHorizontal extends StatelessWidget {
  const HomeHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: Colors.red);
  }
}