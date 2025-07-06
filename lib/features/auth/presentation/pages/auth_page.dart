import 'package:flutter/material.dart';
import 'package:social_network_app/core/utils/constants/sizes.dart';
import 'package:social_network_app/features/auth/presentation/pages/widgets/auth_bottom_section.dart';
import 'package:social_network_app/features/auth/presentation/pages/widgets/auth_top_section.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(SSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [AuthTopSection(), AuthBottomSection()],
          ),
        ),
      ),
    );
  }
}
