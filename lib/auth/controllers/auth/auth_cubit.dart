import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:delivery/auth/utils/interfaces/auth_interface.dart';
import 'package:delivery/common/utils/global.dart';
import 'package:delivery/common/utils/interfaces/storage_interface.dart';
import 'package:delivery/constants/secure_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final AuthInterface authRepository = locator.get<AuthInterface>();
  final StorageInterFace storage = locator.get<StorageInterFace>();
  bool isLoggedIn = false;

  Future<void> onAppInit() async {
    final token = await storage.read(secureStorageUserInfo);
    if (token != null) {
      isLoggedIn = true;
    } else {
      isLoggedIn = false;
    }
  }

  Future<String?> getFirebaseToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    log("Firebase Token: $token");
    return token;
  }

  Future<bool> login(String email, String password) async {
    emit(AuthLoading());
    final response = await authRepository.login(email, password);
    if (response != null) {
      if( response.statusCode == 200 ){
        isLoggedIn = true;
        String? firebaseToken = await getFirebaseToken();
        await authRepository.registerToken(firebaseToken.toString());
        emit(AuthSuccess());
        return true;
      }
    } else {
      emit(AuthFailed());
    }
    return false;
  }

  Future<void> logout() async {
    await storage.delete(secureStorageUserInfo);
    isLoggedIn = false;
    emit(AuthInitial());
  }
}