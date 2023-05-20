import 'package:dio/dio.dart';

abstract class HttpRequests {
  static const String get = 'GET';
  static const String post = 'POST';
  static const String put = 'PUT';
  static const String patch = 'PATCH';
  static const String delete = 'DELETE';
}

class HttpManager {
  Future<Map> request({
    required String url,
    required String method,
    Map? body,
    Map? headers,
  }) async {
    final defautHeaders = headers?.cast<String, String>() ?? {}
      ..addAll({
        'content-type': 'application/json',
        'accept': 'application/json',
        'X-Parse-Application-Id': 'wK7GcEjr2V4br5q5mlR1kybQ5dvxMFDX0qtE1d6Y',
        'X-Parse-REST-API-Key': '2kahi62fkWePLWAwC7k8aMrtQkobogcgkruMxbeB',
      });

    Dio dio = Dio();
    try {
      Response response = await dio.request(
        url,
        data: body,
        options: Options(
          method: method,
          headers: defautHeaders,
        ),
      );
      // backend repsonse
      return response.data;
      // dio backend error
    } on DioError catch (e) {
      return e.response!.data ?? {};
      // other error
    } catch (e) {
      return {};
    }
  }
}
