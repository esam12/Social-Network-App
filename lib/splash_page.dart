import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_network_app/features/auth/presentation/manager/user_bloc/user_bloc.dart';
import 'package:social_network_app/features/auth/presentation/manager/user_bloc/user_state.dart';
import 'package:social_network_app/features/profile/presentation/page/profile_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static const routeName = '/splash';

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state.userStatus == UserStatus.success) {
          context.go(ProfilePage.routeName);
        } 
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Center(
          child: Text(
            'Hello!',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: Theme.of(context).colorScheme.surface,
              fontSize: 52,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
