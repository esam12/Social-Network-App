import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_network_app/core/utils/constants/sizes.dart';
import 'package:social_network_app/features/auth/presentation/manager/user_bloc/user_bloc.dart';
import 'package:social_network_app/features/auth/presentation/manager/user_bloc/user_state.dart';
import 'package:social_network_app/features/auth/presentation/pages/widgets/auth_bottom_section.dart';
import 'package:social_network_app/features/auth/presentation/pages/widgets/auth_top_section.dart';
import 'package:social_network_app/features/profile/presentation/page/profile_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state.userStatus == UserStatus.success) {
          context.go(ProfilePage.routeName);
        }
        if (state.userStatus == UserStatus.error) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage ?? '')));
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(SSizes.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [AuthTopSection(), AuthBottomSection()],
            ),
          ),
        ),
      ),
    );
  }
}
