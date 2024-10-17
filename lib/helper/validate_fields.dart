import 'dart:io';

String? validateNotEmptyField(String? value) {
  if( value != null && value.isNotEmpty ){
    return null;
  } else {
    return "لايمكنك ترك هذا الحقل فارغ";
  }
}

String? validateNotEmptyFieldWithRegex(RegExp? regex, String? value, {String? regexNotMatchMessage}) {
  if( value == null || value.isEmpty ){
    return "لايمكنك ترك هذا الحقل فارغ";
  } else if ( regex == null || regex.hasMatch(value) ) {
    return null;
  } else {
    return regexNotMatchMessage?? "يجب ادخال قيمة صحيحة";
  }
}

String? validateFileField(File? file, {String? regexNotMatchMessage, String? preview}) {
  if( file != null || preview != null ){
    return null;
  } else {
    return regexNotMatchMessage?? "يجب ادخال قيمة صحيحة";
  }
}

String? validateRequiredArabicField(String? value) {

  RegExp regex = RegExp(r'^[\u0600-\u06FF\s]*$');

  if ( value != null && value.isNotEmpty ){
    if( value.length < 2 || value.length > 50 ){
      return "يجب ان يكون طول الحقل بين 2 - 50";
    } else if ( !regex.hasMatch(value) ){
      return 'هذا الحقل يجب ان يحتوي على حروف عربية فقط';
    } else {
      return null;
    }
  } else {
    return "لايمكنك ترك هذا الحقل فارغ";
  }

}
String? validateNotRequiredArabicField(String? value) {

  RegExp regex = RegExp(r'^[\u0600-\u06FF\s]*$');

  if ( value != null && value.isNotEmpty ){
    if( value.length < 2 || value.length > 50 ){
      return "يجب ان يكون طول الحقل بين 2 - 50";
    } else if ( !regex.hasMatch(value) ){
      return 'هذا الحقل يجب ان يحتوي على حروف عربية فقط';
    } else {
      return null;
    }
  } else {
    return null;
  }

}

String? validateRequiredEnglishField(String? value) {

  RegExp regex = RegExp(r'^[a-zA-Z\s]*$');

  if ( value != null && value.isNotEmpty ){
    if( value.length < 2 || value.length > 50 ){
      return "يجب ان يكون طول الحقل بين 2 - 50";
    } else if ( !regex.hasMatch(value) ){
      return 'هذا الحقل يجب ان يحتوي على حروف انكليزية فقط';
    } else {
      return null;
    }
  } else {
    return "لايمكنك ترك هذا الحقل فارغ";
  }

}
String? validateNotRequiredEnglishField(String? value) {

  RegExp regex = RegExp(r'^[a-zA-Z\s]*$');

  if ( value != null && value.isNotEmpty ){
    if( value.length < 2 || value.length > 50 ){
      return "يجب ان يكون طول الحقل بين 2 - 50";
    } else if ( !regex.hasMatch(value) ){
      return 'هذا الحقل يجب ان يحتوي على حروف انكليزية فقط';
    } else {
      return null;
    }
  } else {
    return null;
  }

}

String? validatePhoneNumber(String? value) {
  RegExp englishNumbersRegex = RegExp(r'^[0-9]+(\.[0-9]+)?$');

  if ( value != null && value.isNotEmpty ){
    if ( !englishNumbersRegex.hasMatch(value) ){
      return "رقم الهاتف يجب ان يكون بالانكليزية فقط";
    } else if ( value.length < 9 || value.length > 20 ){
      return "رقم الهاتف يجب ان يكون بين 9 - 20  رقم";
    } else {
      return null;
    }
  } else {
    return "";
  }
}