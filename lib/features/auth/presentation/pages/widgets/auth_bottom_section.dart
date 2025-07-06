import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_network_app/core/theme/app_images.dart';
import 'package:social_network_app/core/utils/constants/sizes.dart';
import 'package:social_network_app/features/auth/presentation/manager/user_bloc/user_bloc.dart';
import 'package:social_network_app/features/auth/presentation/manager/user_bloc/user_event.dart';

class AuthBottomSection extends StatelessWidget {
  const AuthBottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            'Find Events. Meet People. Stay Connected!',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontSize: 32,
              fontWeight: FontWeight.w900,
            ),
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
                child: SvgPicture.asset(SImages.google),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.surface,
                foregroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiusLg),
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              onPressed: () {
                context.read<UserBloc>().add(SignInWithGoogleEvent());
              },
            ),
          ),
        ],
      ),
    );
  }
}
