import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myalquran/core/network/api_client.dart';
import 'package:myalquran/core/network/api_exception.dart';

class DioClient implements ApiClient {
  static final DioClient _instance = DioClient._internal();

  factory DioClient() => _instance;

  final Dio dio;

  DioClient._internal() : dio = Dio() {
    dio.options.baseUrl = "https://connextly-quran-api.up.railway.app";
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);
    dio.interceptors.add(LogInterceptor(
      request: true,
      responseBody: true,
    ));
  }

  @override
  Future<Map<String, dynamic>> get(String path) async {
    try {
      final response = await dio.get(path);
      return response.data;
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          debugPrint("Dio Error: Connection Timeout");
          throw ApiException(
            e.response?.statusCode,
            "Connection Timeout",
          );

        case DioExceptionType.receiveTimeout:
          debugPrint("Dio Error: Receive Timeout");
          throw ApiException(
            e.response?.statusCode,
            "Receive Timeout",
          );

        case DioExceptionType.connectionError:
          debugPrint("Dio Error: No Internet Connection");
          throw ApiException(
            e.response?.statusCode,
            "No Internet Connection",
          );

        case DioExceptionType.badResponse:
          debugPrint(
            "Dio Error: ${e.response?.statusCode} ${e.response?.statusMessage}",
          );

          throw ApiException(
            e.response?.statusCode,
            e.response?.statusMessage ?? "Server Error",
          );

        default:
          debugPrint("Dio Error: Unknown Error ${e.message}");
          throw ApiException(
            e.response?.statusCode,
            "Unknown Error",
          );
      }
    }
  }
}
