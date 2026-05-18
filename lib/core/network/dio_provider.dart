import 'package:dio/dio.dart';

import '../constants/api_constants.dart';

class DioProvider {
  DioProvider._();

  static final Dio dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
}
