import 'package:social_network_app/features/auth/presentation/pages/auth_page.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static var router = GoRouter(
    initialLocation: AuthPage.routeName,
    routes: [
      GoRoute(
        path: AuthPage.routeName,
        builder: (context, state) => const AuthPage(),
      ),
    ],
  );
}
