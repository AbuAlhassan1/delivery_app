// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:delivery/auth/controllers/auth/auth_cubit.dart';
import 'package:delivery/driver/controllers/driver_info/driver_info_cubit.dart';
import 'package:delivery/helper/firebase_notification.dart';
import 'package:delivery/home/controllers/home/home_cubit.dart';
import 'package:delivery/home/views/widgets/order_card.dart';
import 'package:firebase_database/firebase_database.dart';
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

  late DatabaseReference databaseRef;

  Future<void> onInit() async {
    await context.read<DriverInfoCubit>().getDriverProfileInfo();
    await context.read<HomeCubit>().getCurrentOrders();
    context.read<HomeCubit>().isActiveDriver = context.read<DriverInfoCubit>().driverInfo!.data!.isWorking!;
    // await context.read<HomeCubit>().getAllOrders();

    databaseRef = FirebaseDatabase.instance.ref().child("DriverShowOrdersDialog")
    .child(context.read<DriverInfoCubit>().driverInfo!.data!.driverId.toString());

    // Set up the listener for real-time updates
    databaseRef.onValue.listen((DatabaseEvent event) async{
      log("updated");
      await context.read<HomeCubit>().getCurrentOrders();
      // context.read<HomeCubit>().getAllOrders();
    });
  }

  @override
  void initState() {
    super.initState();
    setupFirebaseMessaging(context);
    onInit();
  }

  @override
  Widget build(BuildContext context) {
    // log(databaseRef.child("DriverShowOrdersDialog").get().toString());
    return LayoutBuilder(
      builder: (context, constraints) {
        if ((constraints.maxWidth + 100.sp) < constraints.maxHeight) {
          return const Column(
            children: [
              Expanded(child: HomeVertical()),
              // ElevatedButton(
              //   onPressed: () async {
              //     // var x = await databaseRef.child("DriverShowOrdersDialog").get();
              //     // log(x.child(context.read<DriverInfoCubit>().driverInfo!.data!.driverId.toString()).value.toString());
              //     // log(x.value.toString());
              //     context.read<AuthCubit>().getFirebaseToken();
              //   },
              //   child: const Text("Click")
              // ),
            ],
          );
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
      appBar: AppBar(
        title: const Text('دلفــري العراق'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/profile'),
        child: const Icon(Icons.person),
      ),
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IgnorePointer(
                  ignoring: context.read<HomeCubit>().isHomeDisabled,
                  child: SwitchListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(20), vertical: ScreenUtil().setHeight(0)),
                    title: Text(context.read<HomeCubit>().isActiveDriver ? 'فعال' : 'غير فعال'),
                    value: context.read<HomeCubit>().isActiveDriver,
                    onChanged: (value) async => context.read<HomeCubit>().toggleActiveDriver(),
                  ),
                ),
                Expanded(
                  child: Builder(
                    builder: (context) {

                      if( state is HomeLoading ){
                        return const Center(child: CircularProgressIndicator());
                      } else if( state is HomeError ){
                        return RefreshIndicator(
                          onRefresh: () async => await context.read<HomeCubit>().getCurrentOrders(),
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            clipBehavior: Clip.none,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height - 100,
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(40)),
                                  child: Text(
                                    state.message,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else if( context.read<HomeCubit>().listOfCurrentOrdersModel == null ){
                        return const Center(child: Text('لا يوجد طلبات'));
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
                          // PostPage(),
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

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  PostPageState createState() => PostPageState();
}

class PostPageState extends State<PostPage> {
  late DatabaseReference _postRef;
  dynamic _postData;

  @override
  void initState() {
    super.initState();
    
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Write data to the database
          _postRef.set("Hello, World!");
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(title: Text("Post Details")),
      body: Center(
        child: _postData != null
          ? Text("Post Data: $_postData")
          : Column(
            children: [
              SelectableText("asdasd"),
              // SelectableText(.toString()),
            ],
          ),
      ),
    );
  }
}
