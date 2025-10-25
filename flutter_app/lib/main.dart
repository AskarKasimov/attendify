import 'package:attendify/core/di/injection_container.dart' as di;
import 'package:attendify/core/router/app_router.dart';
import 'package:attendify/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:attendify/ui_kit/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(final BuildContext context) {
    final authBloc = di.sl<AuthBloc>()..add(const CheckAuthStatus());

    return BlocProvider.value(
      value: authBloc,
      child: MaterialApp.router(
        title: 'Attendify',
        theme: AppTheme.light,
        routerConfig: AppRouter.createRouter(authBloc),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
