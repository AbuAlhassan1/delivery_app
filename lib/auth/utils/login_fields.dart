import 'package:delivery/common/models/textfield_model.dart';

final TextFieldDataObject email = TextFieldDataObject(
    lable: "البريد",
    hint: "example@example.ex",
    name: "Email",
    validator: (regex, value) => null,
  );
  final TextFieldDataObject password = TextFieldDataObject(
    lable: "كلمة المرور",
    hint: "********",
    name: "Password",
    isPassword: true,
    validator: (regex, value) => null,
  );