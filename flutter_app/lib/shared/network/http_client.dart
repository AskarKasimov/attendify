abstract class HttpClient {
  Future<HttpResponse> get(
    final String path, {
    final Map<String, dynamic>? queryParameters,
    final Map<String, String>? headers,
  });

  Future<HttpResponse> post(
    final String path, {
    final Object? data,
    final Map<String, dynamic>? queryParameters,
    final Map<String, String>? headers,
  });

  Future<HttpResponse> put(
    final String path, {
    final Object? data,
    final Map<String, dynamic>? queryParameters,
    final Map<String, String>? headers,
  });

  Future<HttpResponse> delete(
    final String path, {
    final Map<String, dynamic>? queryParameters,
    final Map<String, String>? headers,
  });

  Future<HttpResponse> patch(
    final String path, {
    final Object? data,
    final Map<String, dynamic>? queryParameters,
    final Map<String, String>? headers,
  });
}

class HttpResponse {
  const HttpResponse({
    required this.data,
    required this.statusCode,
    this.headers,
  });

  final dynamic data;
  final int statusCode;
  final Map<String, dynamic>? headers;

  bool get isSuccess => statusCode >= 200 && statusCode < 300;
}

sealed class HttpException implements Exception {
  const HttpException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() =>
      'HttpException: $message${statusCode != null ? ' ($statusCode)' : ''}';
}

class NetworkException extends HttpException {
  const NetworkException(super.message);
}

class UnauthorizedException extends HttpException {
  const UnauthorizedException() : super('Unauthorized', statusCode: 401);
}

class ForbiddenException extends HttpException {
  const ForbiddenException() : super('Forbidden', statusCode: 403);
}

class NotFoundException extends HttpException {
  const NotFoundException([final String? resource])
    : super(
        resource != null ? 'Resource not found: $resource' : 'Not found',
        statusCode: 404,
      );
}

class ServerException extends HttpException {
  const ServerException(super.message, {super.statusCode});
}
