import 'package:dio/dio.dart';

class DioInstance {
  static const String baseUrl = 'https://dummyjson.com';
  static final DioInstance _instance = DioInstance.internal();
  factory DioInstance() => _instance;
  static Dio? _dio;

  static Future<Dio> get dio async {
    if (_dio != null) {
      return _dio!;
    }

    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
      ),
    )..interceptors.add(LogInterceptor(responseBody: true));
    return _dio!;
  }

  DioInstance.internal();
  static Future get(String path,{ Map<String, String>? queryParameters}) async {
    final dd = await dio;
    try {
      final req = await dd.get(path,queryParameters: queryParameters);
      return req;
    } on DioException {
      return -1;
    }
  }
  static Future post(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
    dynamic data,
  }) async {
    final dd = await dio;
     options = Options(responseType: ResponseType.json, method: 'POST',validateStatus: (status) => true,);
    try {
      final req = await dd.request(path,
          queryParameters: params, data: data, options: options);
      print((req.requestOptions.data as FormData?)?.fields);
      return req;
    } on DioException {
      return -1;
    }
  }
}
