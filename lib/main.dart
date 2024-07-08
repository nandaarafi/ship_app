import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ship_apps/features/authentication/presentation/cubit/auth_change_cubit.dart';
import 'package:ship_apps/features/home/presentation/cubit/history_cubit.dart';
import 'package:ship_apps/features/home/presentation/cubit/packet_cubit.dart';
import 'package:ship_apps/features/home/presentation/cubit/resi_cubit.dart';

import 'core/routes/routes.dart';
import 'core/routes/side_bar_provider.dart';
import 'core/theme/theme.dart';
import 'features/authentication/presentation/cubit/auth_cubit.dart';
import 'features/authentication/presentation/provider/password_visibility.dart';
import 'features/home/data/home_firebase_notification.dart';
import 'features/home/presentation/provider/image_provider.dart';
import 'features/home/presentation/provider/qr_code_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PasswordVisibilityProvider()),
        ChangeNotifierProvider(create: (_) => ImageSelectionModel()),
        ChangeNotifierProvider(create: (_) => SideBarProvider()),
        ChangeNotifierProvider(create: (_) => QrCodeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => ResiCubit()),
        BlocProvider(create: (context) => HistoryCubit()),
        BlocProvider(create: (context) => PacketCubit()),
        BlocProvider(create: (context) => AuthChangeCubit()),

        // ], child: MaterialApp(
      ], child: MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: STheme.lightTheme,
      key: AppRouter.navigatorKey,
      routerDelegate: AppRouter.router.routerDelegate,
      routeInformationParser: AppRouter.router.routeInformationParser,
      routeInformationProvider: AppRouter.router.routeInformationProvider,
      // navigatorKey: AppRouter.navigatorKey,
      // routerConfig: AppRouter.router,
      // routerDelegate: AppRouter.router.routerDelegate,
      // routeInformationParser: AppRouter.router.routeInformationParser,
    ),
    );
  }
}
