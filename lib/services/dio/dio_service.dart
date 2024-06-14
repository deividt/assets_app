import 'package:dio/dio.dart';

class DioService {
  final Duration _timeout = const Duration(milliseconds: 20000);

  Future<Dio> setup({required String baseUrl}) async {
    Dio dio = Dio();

    final headers = {
      'Content-Type': 'application/json',
    };

    dio.options = BaseOptions(
      baseUrl: baseUrl,
      headers: headers,
      connectTimeout: _timeout,
      receiveTimeout: _timeout,
    );

    return dio;
  }
}
