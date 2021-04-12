import 'package:dio/dio.dart';
import 'package:foxfund_alpha/utils/constants/messages.dart';

class BaseAPI {
  Dio dio = Dio();
  String baseUrl = kBaseUrl;

  Options options = Options(
      contentType: 'application/json', validateStatus: (int s) => s < 500);
}
