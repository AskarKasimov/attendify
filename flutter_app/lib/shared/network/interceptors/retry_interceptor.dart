import 'package:dio/dio.dart';

/// Interceptor для повторных запросов с exponential backoff
class RetryInterceptor extends Interceptor {
  RetryInterceptor({
    required this.dio,
    this.maxRetries = 3,
    this.baseDelay = const Duration(milliseconds: 500),
    this.maxDelay = const Duration(seconds: 10),
  });

  final Dio dio;
  final int maxRetries;
  final Duration baseDelay;
  final Duration maxDelay;

  @override
  Future<void> onError(
    final DioException err,
    final ErrorInterceptorHandler handler,
  ) async {
    final extra = err.requestOptions.extra;
    final retryCount = (extra['retry_count'] as int?) ?? 0;

    if (_shouldRetry(err, retryCount)) {
      try {
        print(
          '[Retry] Attempt ${retryCount + 1}/$maxRetries for ${err.requestOptions.path}',
        );

        final delay = _calculateDelay(retryCount);
        await Future.delayed(delay);

        final requestOptions = err.requestOptions.copyWith(
          extra: {...extra, 'retry_count': retryCount + 1},
        );

        final response = await dio.fetch(requestOptions);
        handler.resolve(response);
        return;
      } catch (e) {
        if (retryCount + 1 >= maxRetries) {
          handler.next(err);
          return;
        }

        final newErr = DioException(
          requestOptions: err.requestOptions.copyWith(
            extra: {...extra, 'retry_count': retryCount + 1},
          ),
          error: e,
          type: DioExceptionType.unknown,
        );
        return onError(newErr, handler);
      }
    }

    handler.next(err);
  }

  bool _shouldRetry(final DioException err, final int retryCount) {
    if (retryCount >= maxRetries) {
      return false;
    }

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return true;
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        return statusCode != null &&
            (statusCode >= 500 || statusCode == 408 || statusCode == 429);
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
        return false;
      case DioExceptionType.unknown:
        return true;
    }
  }

  Duration _calculateDelay(final int retryCount) {
    var delayMs = baseDelay.inMilliseconds * (1 << retryCount);

    // Добавляем jitter (25%) thundering herd
    final jitter =
        (delayMs *
                0.25 *
                (2 * (DateTime.now().millisecondsSinceEpoch % 1000) / 1000 - 1))
            .round();
    delayMs += jitter;

    return Duration(milliseconds: delayMs.clamp(0, maxDelay.inMilliseconds));
  }
}
