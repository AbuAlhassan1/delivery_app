// import 'dart:developer';
// import 'dart:io';

// import 'package:dmis/constants/recaptcha_site_key.dart';
// import 'package:flutter/services.dart';
// import 'package:recaptcha_enterprise_flutter/recaptcha_action.dart';
// import 'package:recaptcha_enterprise_flutter/recaptcha_enterprise.dart';

// // void _showRecaptcha() async {
// //   try {
// //     final result = await RecaptchaEnterprise.verify(
// //       siteKey: 'YOUR_RECAPTCHA_SITE_KEY',
// //       // Other configurations if necessary
// //     );

// //     if (result.success) {
// //       log('reCAPTCHA Verified Successfully!');
// //       // Handle successful verification
// //     } else {
// //       log('reCAPTCHA Verification Failed.');
// //       // Handle failure
// //     }
// //   } catch (e) {
// //     log('Error during reCAPTCHA verification: $e');
// //   }
// // }

// Future<void> initClient() async {
//   String siteKey = Platform.isAndroid
//         ? androidSiteKey
//         : iosSiteKey;

//   var result = false;
//   var errorMessage = "none";

//   try {
//     result = await RecaptchaEnterprise.initClient(siteKey, timeout: 10000);
//   } on PlatformException catch (err) {
//     log('Caught platform exception on init: $err');
//     errorMessage = 'Code: ${err.code} Message ${err.message}';
//   } catch (err) {
//     log('Caught exception on init: $err');
//     errorMessage = err.toString();
//   }

//   log(errorMessage.toString());
//   log(result.toString());
// }

// Future<String?> execute() async {
//   String result;

//   try {
//     result = await RecaptchaEnterprise.execute(RecaptchaAction.LOGIN());
//   } on PlatformException catch (err) {
//     result = 'Code: ${err.code} Message ${err.message}';
//     return null;
//   } catch (err) {
//     log('Caught exception on execute: $err');
//     result = err.toString();
//     return null;
//   }
//   log("result: $result");
//   return result;
// }