// ignore_for_file: use_build_context_synchronously

import 'package:delivery/auth/controllers/auth/auth_cubit.dart';
import 'package:delivery/auth/utils/login_fields.dart';
import 'package:delivery/common/views/material_textfield.dart';
import 'package:delivery/common/views/simple_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginPageWrapper extends StatelessWidget {
  const LoginPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.blue,
                child: const Center(
                  child: Text('Logo'),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: const LoginForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(15)),
        child: Column(
          children: [
            const SizedBox(height: 20),
            MaterialTextField(textFieldDataObject: email),
            const SizedBox(height: 20),
            MaterialTextField(textFieldDataObject: password, isPassword: true),
            const SizedBox(height: 20),
            SimpleButton(onTap: () async{
              bool isOk = await context.read<AuthCubit>().login(email.controller.text, password.controller.text);
              if( isOk ){
                context.go("/");
              }
            }),
          ],
        ),
      ),
    );
  }
}