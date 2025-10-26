sealed class AuthException implements Exception {
  const AuthException(this.message);
  final String message;

  @override
  String toString() => message;
}

class InvalidCredentialsException extends AuthException {
  const InvalidCredentialsException() : super('Неверные учетные данные');
}

class UserNotFoundException extends AuthException {
  const UserNotFoundException() : super('Пользователь не найден');
}

class EmailAlreadyExistsException extends AuthException {
  const EmailAlreadyExistsException() : super('Email уже используется');
}

class WeakPasswordException extends AuthException {
  const WeakPasswordException() : super('Пароль слишком простой');
}

class NetworkException extends AuthException {
  const NetworkException() : super('Ошибка сети');
}

class ServerException extends AuthException {
  const ServerException([final String? message])
    : super(message ?? 'Ошибка сервера');
}

class UnknownAuthException extends AuthException {
  const UnknownAuthException([final String? message])
    : super(message ?? 'Неизвестная ошибка');
}
