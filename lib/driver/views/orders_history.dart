import 'package:delivery/driver/controllers/driver_info/driver_info_cubit.dart';
import 'package:delivery/home/controllers/home/home_cubit.dart';
import 'package:delivery/home/views/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersHistory extends StatefulWidget {
  const OrdersHistory({super.key});

  @override
  State<OrdersHistory> createState() => _OrdersHistoryState();
}

class _OrdersHistoryState extends State<OrdersHistory> {

  @override
  void initState() {
    super.initState();
    context.read<DriverInfoCubit>().getAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سجل الطلبات', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<DriverInfoCubit, DriverInfoState>(
        builder: (context, state) {
          if( state is DriverInfoLoading ){
            return const Center(child: CircularProgressIndicator());
          } else if( state is DriverInfoError ){
            return const Center(child: Text('حدث خطأ ما'));
          }
          return context.read<DriverInfoCubit>().listOfOrdersModel != null ? RefreshIndicator(
            onRefresh: () async => await context.read<DriverInfoCubit>().getAllOrders(),
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(20), vertical: ScreenUtil().setHeight(20)),
              itemCount: context.read<DriverInfoCubit>().listOfOrdersModel!.data!.length,
              itemBuilder: (context, index) {
                return OrderCard(order: context.read<DriverInfoCubit>().listOfOrdersModel!.data![index]);
              },
            ),
          )
          : state is DriverInfoError ? Center(child: Text(state.message))
          : const Center(child: Text('حدث خطأ ما'));
        }
      ),
    );
  }
}