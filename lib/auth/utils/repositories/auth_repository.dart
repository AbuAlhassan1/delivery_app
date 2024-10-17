import 'package:delivery/auth/utils/interfaces/auth_interface.dart';
import 'package:delivery/common/utils/global.dart';
import 'package:delivery/common/utils/interfaces/http_request_interface.dart';
import 'package:delivery/common/utils/interfaces/storage_interface.dart';

class AuthRepository implements AuthInterface {

  HttpRequestInterFace httpRequest = locator.get<HttpRequestInterFace>();
  final StorageInterFace storage = locator.get<StorageInterFace>();
}