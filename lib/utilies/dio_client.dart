import 'dart:developer';

import '../constant/api.dart';

import 'package:dio/dio.dart';
import '../core/error/failure.dart';
import '/utilies/storage/locale_storage.dart';



class DioClient {
  Dio _dio = Dio();

  // Create a new CancelToken
  final cancelToken = CancelToken();

  DioClient() {
    _dio = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        // connectTimeout: const Duration(seconds: 5),
        // receiveTimeout: const Duration(seconds: 5),
      ),
    );
  }

  Future<Response> get(String uri,
      {Options? options, Map<String, dynamic>? query}) async {
    try {
      final token = await LocalStorageManger.getString('token');
      final res = await _dio.get(API_URL + uri, queryParameters: query, options: Options(
          headers: {
            'Content-Type': "application/json",
            'Authorization': "Bearer $token",
            // ...options,
          },
        ),
        cancelToken: cancelToken,
      );

      return res;
    } on DioException  catch (e) {
      String message = e.response?.data['msg'];

      if (message.contains('Route [login] not defined')) {
        throw const UnauthorizeFailure(message: '401');
      }

      //
      if (e.type == DioExceptionType.connectionTimeout) {
        throw const ConnectionRefuse(
            message:
                "Sorry due our server is error. please contact our support.");
      }

      throw const ServerFailure(message: 'Data not found');
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(String uri, { Options? options, FormData? data, Map<String, dynamic>? queryParameters }) async {
    try {

      final token = await LocalStorageManger.getString('token');
      _dio.options.headers['Content-Type'] = "application/json";
      _dio.options.headers['Authorization'] = "Bearer $token";

      return await _dio.post(API_URL + uri, data: data, options: options?.copyWith(
        headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
              ...?options.headers,
            }),
            cancelToken: cancelToken,
            queryParameters: queryParameters,
          )
          .then((value) => value);
    } on DioException  catch (e) {
      log('dio ${e.response?.statusCode}');
      String message = e.response?.data['msg'];
      if (message.contains('Route [login] not defined')) {
        throw const UnauthorizeFailure(message: '401');
      }

      if (e.type == DioExceptionType.connectionTimeout) {
        throw const ConnectionRefuse(
            message:
                "Sorry due our server is error. please contact our support.");
      }

      if (e.response?.data != null) {
        throw HttpError(message: e.response!.data['msg']);
      }

      throw const ServerFailure(message: 'Invalid request.');
    } catch (e) {
      rethrow;
    }
  }
}
