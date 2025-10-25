import 'package:flutter_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_app/features/auth/data/repositories/secure_storage_impl.dart';
import 'package:flutter_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_app/features/auth/domain/repositories/secure_storage.dart';
import 'package:flutter_app/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:flutter_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:flutter_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:flutter_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    ..registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage(),
    )
    ..registerLazySingleton<SecureStorage>(
      () => SecureStorageImpl(flutterSecureStorage: sl()),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(secureStorage: sl()),
    )
    ..registerLazySingleton(() => LoginUseCase(sl()))
    ..registerLazySingleton(() => LogoutUseCase(sl()))
    ..registerLazySingleton(() => RegisterUseCase(sl()))
    ..registerLazySingleton(() => GetCurrentUserUseCase(sl()))
    ..registerFactory(
      () => AuthBloc(
        loginUseCase: sl(),
        logoutUseCase: sl(),
        registerUseCase: sl(),
        getCurrentUserUseCase: sl(),
      ),
    );
}
