import 'package:attendify/features/auth/domain/repositories/session_repository.dart';
import 'package:attendify/shared/config/env.dart';
import 'package:attendify/shared/network/http_client.dart';
import 'package:attendify/shared/network/interceptors/auth_interceptor.dart';
import 'package:attendify/shared/network/interceptors/retry_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioHttpClient implements HttpClient {
  DioHttpClient({
    required final SessionRepository sessionRepository,
    final String baseUrl = Env.baseUrl,
    final Map<String, String>? headers,
    final Duration connectTimeout = const Duration(seconds: 30),
    final Duration receiveTimeout = const Duration(seconds: 30),
    final int maxRetries = defaultMaxRetries,
    final Duration retryBaseDelay = defaultRetryBaseDelay,
    final Duration retryMaxDelay = defaultRetryMaxDelay,
    final VoidCallback? onSessionExpired,
  }) : _dio = Dio() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = connectTimeout;
    _dio.options.receiveTimeout = receiveTimeout;

    if (headers != null) {
      _dio.options.headers.addAll(headers);
    }

    _dio.interceptors.addAll([
      AuthInterceptor(
        sessionRepository: sessionRepository,
        onSessionExpired: onSessionExpired,
      ),
      RetryInterceptor(
        dio: _dio,
        maxRetries: maxRetries,
        baseDelay: retryBaseDelay,
        maxDelay: retryMaxDelay,
      ),
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (final obj) => print('[HTTP] $obj'),
      ),
    ]);
  }
  static const int defaultMaxRetries = 3;
  static const Duration defaultRetryBaseDelay = Duration(milliseconds: 500);
  static const Duration defaultRetryMaxDelay = Duration(seconds: 10);

  final Dio _dio;

  Future<HttpResponse> _request(
    final String method,
    final String path, {
    final Object? data,
    final Map<String, dynamic>? queryParameters,
    final Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(method: method, headers: headers),
      );
      return HttpResponse(
        data: response.data,
        statusCode: response.statusCode ?? 0,
        headers: response.headers.map.cast<String, dynamic>(),
      );
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<HttpResponse> get(
    final String path, {
    final Map<String, dynamic>? queryParameters,
    final Map<String, String>? headers,
  }) =>
      _request('GET', path, queryParameters: queryParameters, headers: headers);

  @override
  Future<HttpResponse> post(
    final String path, {
    final Object? data,
    final Map<String, dynamic>? queryParameters,
    final Map<String, String>? headers,
  }) => _request(
    'POST',
    path,
    data: data,
    queryParameters: queryParameters,
    headers: headers,
  );

  @override
  Future<HttpResponse> put(
    final String path, {
    final Object? data,
    final Map<String, dynamic>? queryParameters,
    final Map<String, String>? headers,
  }) => _request(
    'PUT',
    path,
    data: data,
    queryParameters: queryParameters,
    headers: headers,
  );

  @override
  Future<HttpResponse> delete(
    final String path, {
    final Map<String, dynamic>? queryParameters,
    final Map<String, String>? headers,
  }) => _request(
    'DELETE',
    path,
    queryParameters: queryParameters,
    headers: headers,
  );

  @override
  Future<HttpResponse> patch(
    final String path, {
    final Object? data,
    final Map<String, dynamic>? queryParameters,
    final Map<String, String>? headers,
  }) => _request(
    'PATCH',
    path,
    data: data,
    queryParameters: queryParameters,
    headers: headers,
  );

  HttpException _handleError(final Object error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return const NetworkException('Connection timeout');

        case DioExceptionType.connectionError:
          return const NetworkException('Connection error');

        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          switch (statusCode) {
            case 401:
              return const UnauthorizedException();
            case 403:
              return const ForbiddenException();
            case 404:
              return const NotFoundException();
            case final int code when code >= 500:
              return ServerException(
                'Server error: ${error.response?.statusMessage ?? 'Unknown'}',
                statusCode: statusCode,
              );
            default:
              return ServerException(
                'HTTP error: ${error.response?.statusMessage ?? 'Unknown'}',
                statusCode: statusCode,
              );
          }

        case DioExceptionType.cancel:
          return const NetworkException('Request cancelled');

        case DioExceptionType.unknown:
        default:
          return NetworkException('Unknown network error: ${error.message}');
      }
    }

    return NetworkException('Unexpected error: $error');
  }
}
