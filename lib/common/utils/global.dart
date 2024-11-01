import 'package:delivery/auth/utils/interfaces/auth_interface.dart';
import 'package:delivery/auth/utils/repositories/auth_repository.dart';
import 'package:delivery/common/utils/interfaces/http_request_interface.dart';
import 'package:delivery/common/utils/interfaces/storage_interface.dart';
import 'package:delivery/common/utils/repositories/http_request_repository.dart';
import 'package:delivery/common/utils/repositories/secure_storage_repository.dart';
import 'package:delivery/driver/utils/interfaces/driver_interface.dart';
import 'package:delivery/driver/utils/repositories/driver_repository.dart';
import 'package:delivery/home/utils/interfaces/orders_interface.dart';
import 'package:delivery/home/utils/repositories/orders_repository.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setup(){
  locator.registerLazySingleton<StorageInterFace>(() => SecureStorageRepository());
  locator.registerLazySingleton<HttpRequestInterFace>(() => HttpRequestRepository());
  locator.registerLazySingleton<AuthInterface>(() => AuthRepository());
  locator.registerLazySingleton<OrdersInterface>(() => OrdersRepository());
  locator.registerLazySingleton<DriverInterface>(() => DriverRepository());
}