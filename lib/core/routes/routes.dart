import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ship_apps/features/authentication/domain/auth_data_model.dart';
import 'package:ship_apps/features/authentication/presentation/screen/login_screen.dart';
import 'package:ship_apps/features/authentication/presentation/screen/register_screen.dart';
import 'package:ship_apps/features/authentication/presentation/screen/splash_screen.dart';
import 'package:ship_apps/features/home/presentation/screen/daftar_resi_screen.dart';
import 'package:ship_apps/features/home/presentation/screen/profile_screen.dart';
import 'package:ship_apps/features/home/presentation/screen/cek_resi_screen.dart';

import '../../features/home/presentation/screen/edit_profile_screen.dart';
import '../../features/home/presentation/screen/packet_capacity_screen.dart';
import '../../features/home/presentation/screen/pickup_history_screen.dart';
import '../errors/routes_error.dart';
import 'constants.dart';
import 'home_side_bar.dart';


class AppRouter {

  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  static final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

  static final GoRouter _router = GoRouter(
    initialLocation: Routes.splashScreenNamedPageRoot,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      //Splash Screen
      GoRoute(
          path: Routes.splashScreenNamedPageRoot,
          pageBuilder: (BuildContext context, GoRouterState state){
            return MaterialPage(
              child: SplashScreen()
            );
        }
      ),
      //Sign In
      GoRoute(
          path: Routes.signInNamedPage,
          pageBuilder: (BuildContext context, GoRouterState state){
          return NoTransitionPage(
          child: LoginScreen()
          );
        }
      ),
      //Sign Up
      GoRoute(
          path: Routes.signUpNamedPage,
          pageBuilder: (BuildContext context, GoRouterState state){
            return NoTransitionPage(
                child: RegisterScreen()
            );
          }
      ),
      //EditProfileScreen
      GoRoute(
        path: Routes.editProfileNamedPage, // Route for EditProfileScreen
        builder: (BuildContext context, GoRouterState state) {
          final user = state.extra! as UserModel;
          return EditProfileScreen(
            userCache: user,
          );
        },
      ),


      //Home ShellRoute Screen Sidebar
      ShellRoute(
          navigatorKey: _shellNavigatorKey,
          pageBuilder: (BuildContext context, GoRouterState state, child){
            return NoTransitionPage(
                child: HomeNavigationDrawer(child: child) // I have EditProfileScreen inside this where I place that
            );
          },
          routes: <RouteBase>[
            GoRoute(
                path: Routes.profileNamedPage,
                parentNavigatorKey: _shellNavigatorKey,
                pageBuilder: (BuildContext context, GoRouterState state){
                  return NoTransitionPage(
                      child: ProfileScreen()
                  );
                },
            ),
            GoRoute(
                path: Routes.daftarResiNamedPage,
                parentNavigatorKey: _shellNavigatorKey,
                pageBuilder: (BuildContext context, GoRouterState state){
                  return NoTransitionPage(
                      child: DaftarResiScreen());
                }
            ),
            GoRoute(
                path: Routes.checkResiNamedPage,
                parentNavigatorKey: _shellNavigatorKey,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return  NoTransitionPage(
                      child: CheckResiScreen()
                  );
                }
            ),
            GoRoute(
                path: Routes.packetCapacityNamedPage,
                parentNavigatorKey: _shellNavigatorKey,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return  NoTransitionPage(
                      child: PacketCapacityScreen()
                  );
                }
            ),

            GoRoute(
                path: Routes.historyNamedPage,
                parentNavigatorKey: _shellNavigatorKey,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return  NoTransitionPage(
                      child: PickupHistoryScreen()
                  );
                }
            ),
          ]
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );

  static GoRouter get router => _router;
}

