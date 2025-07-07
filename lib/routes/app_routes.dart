import 'package:social_network_app/features/auth/presentation/pages/auth_page.dart';
import 'package:go_router/go_router.dart';
import 'package:social_network_app/features/home/presentation/pages/home_page.dart';
import 'package:social_network_app/splash_page.dart';

class AppRoutes {
  static var router = GoRouter(
    initialLocation: SplashPage.routeName,
    routes: [
      GoRoute(
        path: SplashPage.routeName,
        builder: (context, state) => const SplashPage(),
      ),

      GoRoute(
        path: AuthPage.routeName,
        builder: (context, state) => const AuthPage(),
      ),

      GoRoute(
        path: HomePage.routeName,
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}
