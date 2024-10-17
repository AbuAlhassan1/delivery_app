import 'package:delivery/common/utils/interfaces/http_request_interface.dart';
import 'package:delivery/common/utils/interfaces/storage_interface.dart';
import 'package:delivery/common/utils/repositories/http_request_repository.dart';
import 'package:delivery/common/utils/repositories/secure_storage_repository.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setup(){
  locator.registerLazySingleton<StorageInterFace>(() => SecureStorageRepository());
  locator.registerLazySingleton<HttpRequestInterFace>(() => HttpRequestRepository());
}