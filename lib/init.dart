import 'package:dio/dio.dart';

class Api {
  static const _timeout = 3000;
  static Future<void> init(
    String url, {
    required Function(Map json) onSuccess,
    required Function() onError,
  }) async {
    Dio dio = Dio(
      BaseOptions(
        sendTimeout: _timeout,
        connectTimeout: _timeout,
        receiveTimeout: _timeout,
      ),
    );
    try {
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        onSuccess(response.data);
      } else {
        onError();
      }
    } catch (e) {
      onError();
    } finally {
      dio.close();
    }
  }
}
