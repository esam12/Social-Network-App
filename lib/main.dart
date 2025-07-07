import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_network_app/core/get_it/get_it.dart';
import 'package:social_network_app/core/theme/app_theme.dart';
import 'package:social_network_app/features/auth/presentation/manager/user_bloc/user_bloc.dart';
import 'package:social_network_app/features/auth/presentation/manager/user_bloc/user_event.dart';
import 'package:social_network_app/features/auth/presentation/manager/user_bloc/user_state.dart';
import 'package:social_network_app/features/auth/presentation/pages/auth_page.dart';
import 'package:social_network_app/firebase_options.dart';
import 'package:social_network_app/routes/app_routes.dart';

Future<void> main() async {
  // Ensure widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize GetIt
  setupGetIt();

  // Run the app
  runApp(
    BlocProvider(
      create: (context) => getIt<UserBloc>()..add(GetUserEvent()),
      child: MaterialApp.router(
        theme: AppTheme.getTheme(),
        routerConfig: AppRoutes.router,
        builder: (context, widget) {
          return BlocListener<UserBloc, UserState>(
            listener: (context, state) {
              if (state.userStatus == UserStatus.error ||
                  state.userStatus == UserStatus.logout) {
                context.go(AuthPage.routeName);
              } 
            },
            child: Center(child: widget),
          );
        },
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
