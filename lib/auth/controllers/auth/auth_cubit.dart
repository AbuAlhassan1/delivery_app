import 'package:bloc/bloc.dart';
import 'package:delivery/auth/utils/interfaces/auth_interface.dart';
import 'package:delivery/common/utils/global.dart';
import 'package:delivery/common/utils/interfaces/storage_interface.dart';
import 'package:delivery/constants/secure_storage.dart';

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

  Future<bool> login(String email, String password) async {
    emit(AuthLoading());
    final response = await authRepository.login(email, password);
    if (response != null) {
      if( response.statusCode == 200 ){
        isLoggedIn = true;
        emit(AuthSuccess());
        return true;
      }
    } else {
      emit(AuthFailed());
    }
    return false;
  }
}