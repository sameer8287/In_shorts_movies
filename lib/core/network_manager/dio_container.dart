import 'package:dio/dio.dart';
import 'package:in_shorts_movies/core/network_manager/rest_client.dart';
import 'package:in_shorts_movies/core/utils/logger_utils.dart';

final restClient = RestClient(dio, baseUrl: "https://api.themoviedb.org/3");

final Dio dio = getDio();

String token =
    "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhOTNhYTYzNTlkNDQwYjM0YjZmMDQzNTBkNmYxYjlkZSIsIm5iZiI6MTc1OTIyMjU2My4yNzQsInN1YiI6IjY4ZGI5YjIzNTJhZjVlMzA3M2UxZDI4NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.uhonUTq8W6wUxsr5ZYI38tgRC7u6CgmVr6gB0SPgw4w";

Dio getDio() {
  BaseOptions options = BaseOptions(
    receiveDataWhenStatusError: true,
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 20),
    sendTimeout: const Duration(seconds: 20),
    headers: {'Content-Type': 'application/json', 'Accept': 'application/json', 'Authorization': "Bearer $token"},
  );

  Dio dio = Dio(options);

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        // Do something before request is sent
        _printCurl(options);
        return handler.next(options); //continue
      },
      onResponse: (response, handler) {
        // Do something with response data
        AppLogger.i("Response ${response.toString()}");
        return handler.next(response); // continue
      },
      onError: (DioException e, handler) {
        // Do something with response error
        AppLogger.e(e.message.toString());
        return handler.next(e); //continue
      },
    ),
  );
  return dio;
}

void _printCurl(RequestOptions options) {
  final method = options.method;
  final url = options.uri.toString();
  final headers = options.headers.entries.map((e) => "-H '${e.key}: ${e.value}'").join(' ');
  final data = options.data != null ? "-d '${options.data}'" : '';
  final curl = "curl -X $method $headers $data '$url'";
  AppLogger.i(curl); // logs the curl
}
