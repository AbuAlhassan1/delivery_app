import 'package:delivery/common/models/textfield_model.dart';
import 'package:delivery/common/views/material_textfield.dart';
import 'package:delivery/common/views/simple_button.dart';
import 'package:flutter/material.dart';
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
                child: LoginForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final TextFieldDataObject email = TextFieldDataObject(
    lable: "Email",
    hint: "Email",
    name: "Email",
    validator: (regex, value) => null,
  );
  final TextFieldDataObject password = TextFieldDataObject(
    lable: "Password",
    hint: "Password",
    name: "Password",
    validator: (regex, value) => null,
  );

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
            MaterialTextField(textFieldDataObject: password),
            const SizedBox(height: 20),
            SimpleButton(onTap: () => context.push("/")),
          ],
        ),
      ),
    );
  }
}