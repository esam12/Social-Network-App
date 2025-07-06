import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_network_app/core/theme/app_theme.dart';
import 'package:social_network_app/firebase_options.dart';
import 'package:social_network_app/routes/app_routes.dart';

Future<void> main() async {
  // Ensure widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Run the app
  runApp(
    MaterialApp.router(
      theme: AppTheme.getTheme(),
      routerConfig: AppRoutes.router,
      debugShowCheckedModeBanner: false,
    ),
  );
}
