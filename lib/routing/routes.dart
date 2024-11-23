import 'dart:developer';
import 'package:delivery/auth/controllers/auth/auth_cubit.dart';
import 'package:delivery/auth/views/login/login_page_wrapper.dart';
import 'package:delivery/driver/views/driver_profile_page_wrapper.dart';
import 'package:delivery/home/views/home_page_wrapper.dart';
import 'package:delivery/routing/route_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  // navigatorKey: navigatorKey,

  redirect: (context, state) {
    final authCubit = context.read<AuthCubit>();
    final authState = authCubit.state;

    if (authState is AuthLoading) {
      return null;
    }

    if (!authCubit.isLoggedIn && state.fullPath != '/login') {
      return '/login';
    } else if (authCubit.isLoggedIn && state.fullPath == '/login') {
      return '/';
    }

    return null;
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
    body: Center(child: Text(state.error.toString())),
  )),
);
