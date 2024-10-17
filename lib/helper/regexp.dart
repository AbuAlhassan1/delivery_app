final RegExp arabicRegExp  = RegExp(r'^[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF]+$');
final RegExp englishRegExp = RegExp(r'^[a-zA-Z]+$');
final RegExp numberRegExp  = RegExp(r'^[0-9]+$');

final RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
final RegExp passwordRegExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$');