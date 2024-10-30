import 'package:delivery/home/controllers/home/home_cubit.dart';
import 'package:delivery/home/views/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HomePageWrapper extends StatefulWidget {
  const HomePageWrapper({super.key});

  @override
  State<HomePageWrapper> createState() => _HomePageWrapperState();
}

class _HomePageWrapperState extends State<HomePageWrapper> {

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getAllOrders();
    context.read<HomeCubit>().getCurrentOrders();
  }

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
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/profile'),
        child: const Icon(Icons.person),
      ),
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if( state is HomeError ){
              return const Center(child: Text('حدث خطأ ما'));
            }
            return Column(
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(20), vertical: ScreenUtil().setHeight(0)),
                  title: Text(context.read<HomeCubit>().isActiveDriver ? 'فعال' : 'غير فعال'),
                  value: context.read<HomeCubit>().isActiveDriver,
                  onChanged: (value) async => context.read<HomeCubit>().toggleActiveDriver(),
                ),
                Expanded(
                  child: Builder(
                    builder: (context) {

                      if( state is HomeLoading ){
                        return const Center(child: CircularProgressIndicator());
                      } else if( state is HomeError ){
                        return const Center(child: Text('حدث خطأ ما'));
                      }

                      return Stack(
                        children: [
                          RefreshIndicator(
                            onRefresh: () async => await context.read<HomeCubit>().getCurrentOrders(),
                            child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(20), vertical: ScreenUtil().setHeight(20)),
                              itemCount: context.read<HomeCubit>().listOfCurrentOrdersModel!.data!.length,
                              itemBuilder: (context, index) {
                                return OrderCard(order: context.read<HomeCubit>().listOfCurrentOrdersModel!.data![index]);
                              },
                            ),
                          ),
                          context.read<HomeCubit>().isActiveDriver ? const SizedBox()
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
                        ],
                      );
                    }
                  )
                ),
              ],
            );
          },
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