import 'package:attendify/features/advertising/data/repositories/advertising_repository_impl.dart';
import 'package:attendify/features/advertising/domain/repositories/advertising_repository.dart';
import 'package:attendify/features/advertising/domain/usecases/manage_advertising_usecase.dart';
import 'package:attendify/features/advertising/presentation/bloc/advertising_bloc.dart';
import 'package:attendify/features/auth/data/repositories/mock_auth_repository.dart';
import 'package:attendify/features/auth/data/repositories/oauth_repository_impl.dart';
import 'package:attendify/features/auth/data/repositories/secure_storage_impl.dart';
import 'package:attendify/features/auth/data/repositories/session_repository_impl.dart';
import 'package:attendify/features/auth/domain/repositories/auth_repository.dart';
import 'package:attendify/features/auth/domain/repositories/oauth_repository.dart';
import 'package:attendify/features/auth/domain/repositories/secure_storage.dart';
import 'package:attendify/features/auth/domain/repositories/session_repository.dart';
import 'package:attendify/features/auth/domain/usecases/authentic_login_usecase.dart';
import 'package:attendify/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:attendify/features/auth/domain/usecases/login_usecase.dart';
import 'package:attendify/features/auth/domain/usecases/logout_usecase.dart';
import 'package:attendify/features/auth/domain/usecases/register_usecase.dart';
import 'package:attendify/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:attendify/features/auth/presentation/bloc/logic_bloc/login_bloc.dart';
import 'package:attendify/features/auth/presentation/bloc/register_bloc/register_bloc.dart';
import 'package:attendify/features/event_create/data/repositories/event_create_repository.dart';
import 'package:attendify/features/event_create/data/repositories/mock_event_create_repository.dart';
import 'package:attendify/features/event_create/presentation/bloc/event_create_bloc.dart';
import 'package:attendify/features/event_join/data/repositories/mock_event_join_repository.dart';
import 'package:attendify/features/event_join/domain/repositories/event_join_repository.dart';
import 'package:attendify/features/event_join/domain/usecases/join_event_use_case.dart';
import 'package:attendify/features/event_join/presentation/bloc/event_join_bloc.dart';
import 'package:attendify/features/scanning/data/repositories/ble_repository_impl.dart';
import 'package:attendify/features/scanning/domain/repositories/ble_repository.dart';
import 'package:attendify/features/scanning/domain/usecases/scan_for_event_devices_usecase.dart';
import 'package:attendify/features/scanning/presentation/bloc/scanning_bloc.dart';
import 'package:attendify/shared/network/dio_http_client.dart';
import 'package:attendify/shared/network/http_client.dart';
import 'package:attendify/shared/services/auth_event_service.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    // storages
    ..registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage(),
    )
    ..registerLazySingleton<FlutterAppAuth>(() => const FlutterAppAuth())
    ..registerLazySingleton<AuthEventService>(AuthEventService.new)
    ..registerLazySingleton<HttpClient>(
      () => DioHttpClient(
        sessionRepository: sl(),
        onSessionExpired: () => sl<AuthEventService>().notifySessionExpired(),
      ),
    )
    ..registerLazySingleton<SecureStorage>(
      () => SecureStorageImpl(flutterSecureStorage: sl()),
    )
    // repositories
    ..registerLazySingleton<SessionRepository>(
      () => SessionRepositoryImpl(secureStorage: sl()),
    )
    // ..registerLazySingleton<AuthRepository>(() => const AuthRepositoryImpl())
    ..registerLazySingleton<AuthRepository>(() => const MockAuthRepository())
    ..registerLazySingleton<OAuthRepository>(() => OAuthRepositoryImpl(sl()))
    ..registerLazySingleton<BleRepository>(() {
      final repo = BleRepositoryImpl()..setLoggingEnabled(true);
      return repo;
    })
    ..registerLazySingleton<AdvertisingRepository>(() {
      final repo = AdvertisingRepositoryImpl()..setLoggingEnabled(true);
      return repo;
    })
    // ..registerLazySingleton<EventJoinRepository>(
    //   () => EventJoinRepositoryImpl(sl()),
    // )
    ..registerLazySingleton<EventJoinRepository>(
      () => const MockEventJoinRepository(),
    )
    ..registerLazySingleton<EventCreateRepository>(
      MockEventCreateRepository.new,
    )
    // usecases
    ..registerLazySingleton(() => LoginUseCase(sl(), sl()))
    ..registerLazySingleton(() => LogoutUseCase(sl()))
    ..registerLazySingleton(() => RegisterUseCase(sl(), sl()))
    ..registerLazySingleton(() => GetCurrentUserUseCase(sl()))
    ..registerLazySingleton(() => AuthenticLoginUseCase(sl(), sl()))
    ..registerLazySingleton(() => ScanForEventDevicesUseCase(sl()))
    ..registerLazySingleton(() => ManageAdvertisingUseCase(sl()))
    ..registerLazySingleton(() => JoinEventUseCase(sl()))
    // blocs
    ..registerFactory(
      () => AuthBloc(
        logoutUseCase: sl(),
        getCurrentUserUseCase: sl(),
        authenticLoginUseCase: sl(),
        authEventService: sl(),
      ),
    )
    ..registerFactory(() => LoginBloc(loginUseCase: sl()))
    ..registerFactory(() => RegisterBloc(registerUseCase: sl()))
    ..registerLazySingleton(() => ScanningBloc(sl()))
    ..registerLazySingleton(() => AdvertisingBloc(sl()))
    ..registerLazySingleton(() => EventJoinBloc(joinEventUseCase: sl()))
    ..registerLazySingleton(() => EventCreateBloc(sl<EventCreateRepository>()));
}
