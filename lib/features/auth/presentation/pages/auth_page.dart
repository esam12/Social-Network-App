import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_network_app/core/utils/constants/sizes.dart';

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
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      'Social Network',
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'By ISAM Dev',
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.7),
                          ),
                    ),

                    SizedBox(height: SSizes.sm),

                    Expanded(
                      child: Center(
                        child: Image.asset('assets/images/intro.png'),
                      ),
                    ),

                    SizedBox(height: SSizes.lg),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Find Events. Meet People. Stay Connected!',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontSize: 32, fontWeight: FontWeight.w900),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: SSizes.sm),

                    Text(
                      'Join our community and experience the power of social networking like never before.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    Spacer(),

                    SizedBox(
                      width: double.maxFinite,
                      height: 50,
                      child: ElevatedButton.icon(
                        label: Text('Sign in with Google'),
                        icon: SizedBox(
                          width: 24,
                          height: 24,
                          child: SvgPicture.asset('assets/images/google.svg'),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.surface,
                          foregroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              SSizes.borderRadiusLg,
                            ),
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
