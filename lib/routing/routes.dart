import 'package:delivery/auth/views/login/login_page_wrapper.dart';
import 'package:delivery/driver/views/driver_profile_page_wrapper.dart';
import 'package:delivery/home/views/home_page_wrapper.dart';
import 'package:delivery/routing/route_builder.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  // navigatorKey: navigatorKey,
  
  redirect: (context, state) {
    return state.fullPath;
  },
  routes: [

    routeBuilder(
      path: '/',
      child: (context, state) => const HomePageWrapper(),
    ),

    routeBuilder(
      path: '/profile',
      child: (context, state) => const DriverProfilePageWrapper(),
    ),

    routeBuilder(
      path: '/login',
      child: (context, state) => const LoginPageWrapper(),
    ),

  ],
  errorPageBuilder: (context, state) => MaterialPage(
    child: Scaffold(
      body: Center(
        child: Text(state.error.toString())
      ),
    )
  ),
);