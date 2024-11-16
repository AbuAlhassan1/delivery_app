import 'dart:developer';
import 'package:delivery/auth/controllers/auth/auth_cubit.dart';
import 'package:delivery/common/controllers/cubit/orders_notification_cubit_cubit.dart';
import 'package:delivery/common/controllers/l10n/l10n_cubit.dart';
import 'package:delivery/common/controllers/theme/theme_cubit.dart';
import 'package:delivery/common/controllers/theme/theme_cubit_states.dart';
import 'package:delivery/constants/themes.dart';
import 'package:delivery/driver/controllers/driver_info/driver_info_cubit.dart';
import 'package:delivery/home/controllers/home/home_cubit.dart';
import 'package:delivery/routing/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => L10nCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => OrdersNotificationCubitCubit()),
        BlocProvider(create: (context) => DriverInfoCubit()),
        BlocProvider(create: (context) => HomeCubit()),
      ],
      child: const InitRoute()
    );
  }
}


class InitRoute extends StatefulWidget {
  const InitRoute({super.key});

  @override
  State<InitRoute> createState() => _InitRouteState();
}

class _InitRouteState extends State<InitRoute> {

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().onAppInit();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Material(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<ThemeCubit, ThemeCubitState>(
                  builder: (context, state) => ScreenUtilInit(
                    designSize: const Size(400, 860),
                    minTextAdapt: true,
                    splitScreenMode: true,
                    builder: (context, child) => OKToast(
                      child: MaterialApp.router(
                        backButtonDispatcher: null,
                        scrollBehavior: MyCustomScrollBehavior(),
                        scaffoldMessengerKey: scaffoldKey,
                        theme: state == DarkTheme() ? Themes.darkTheme : Themes.lightTheme,
                        localizationsDelegates: context.localizationDelegates,
                        supportedLocales: context.supportedLocales,
                        locale: context.locale,
                        routerConfig: router,
                        debugShowCheckedModeBanner: false,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}

class MyCustomScrollBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics(); // Your custom ScrollPhysics
  }

  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child; // Removes the default overscroll glow (optional)
  }
}