import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_app/core/get_it/get_it.dart';
import 'package:social_network_app/core/theme/app_theme.dart';
import 'package:social_network_app/features/auth/presentation/manager/user_bloc/user_bloc.dart';
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
      create: (context) => getIt<UserBloc>(),
      child: MaterialApp.router(
        theme: AppTheme.getTheme(),
        routerConfig: AppRoutes.router,
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
