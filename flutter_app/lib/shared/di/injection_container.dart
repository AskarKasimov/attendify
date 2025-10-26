import 'package:attendify/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:attendify/features/auth/data/repositories/oauth_repository_impl.dart';
import 'package:attendify/features/auth/data/repositories/secure_storage_impl.dart';
import 'package:attendify/features/auth/domain/repositories/auth_repository.dart';
import 'package:attendify/features/auth/domain/repositories/oauth_repository.dart';
import 'package:attendify/features/auth/domain/repositories/secure_storage.dart';
import 'package:attendify/features/auth/domain/usecases/authentic_login_usecase.dart';
import 'package:attendify/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:attendify/features/auth/domain/usecases/login_usecase.dart';
import 'package:attendify/features/auth/domain/usecases/logout_usecase.dart';
import 'package:attendify/features/auth/domain/usecases/register_usecase.dart';
import 'package:attendify/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:attendify/features/auth/presentation/bloc/logic_bloc/login_bloc.dart';
import 'package:attendify/features/auth/presentation/bloc/register_bloc/register_bloc.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    ..registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage(),
    )
    ..registerLazySingleton<FlutterAppAuth>(() => const FlutterAppAuth())
    ..registerLazySingleton<SecureStorage>(
      () => SecureStorageImpl(flutterSecureStorage: sl()),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(secureStorage: sl()),
    )
    ..registerLazySingleton<OAuthRepository>(() => OAuthRepositoryImpl(sl()))
    ..registerLazySingleton(() => LoginUseCase(sl()))
    ..registerLazySingleton(() => LogoutUseCase(sl()))
    ..registerLazySingleton(() => RegisterUseCase(sl()))
    ..registerLazySingleton(() => GetCurrentUserUseCase(sl()))
    ..registerLazySingleton(() => AuthenticLoginUseCase(sl()))
    ..registerFactory(
      () => AuthBloc(
        logoutUseCase: sl(),
        getCurrentUserUseCase: sl(),
        authenticLoginUseCase: sl(),
      ),
    )
    ..registerFactory(() => LoginBloc(loginUseCase: sl()))
    ..registerFactory(() => RegisterBloc(registerUseCase: sl()));
}
