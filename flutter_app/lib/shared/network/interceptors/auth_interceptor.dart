import 'package:attendify/features/auth/domain/repositories/session_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Interceptor для автоматического добавления Authorization токена
class AuthInterceptor extends Interceptor {
  AuthInterceptor({required this.sessionRepository, this.onSessionExpired});

  final SessionRepository sessionRepository;
  final VoidCallback? onSessionExpired;

  @override
  Future<void> onRequest(
    final RequestOptions options,
    final RequestInterceptorHandler handler,
  ) async {
    try {
      final accessToken = await sessionRepository.getAccessToken();
      if (accessToken?.isNotEmpty ?? false) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
    } catch (e) {
      print('[AuthInterceptor] Failed to get access token: $e');
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    final DioException err,
    final ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      try {
        await sessionRepository.clearUserSession();
        onSessionExpired?.call();
      } catch (e) {
        print('[AuthInterceptor] Failed to clear session: $e');
      }
    }
    handler.next(err);
  }
}
