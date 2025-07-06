import 'package:flutter/material.dart';
import 'package:social_network_app/core/theme/app_images.dart';
import 'package:social_network_app/core/utils/constants/sizes.dart';

class AuthTopSection extends StatelessWidget {
  const AuthTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            'Social Network',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'By ISAM Dev',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),

          SizedBox(height: SSizes.sm),

          Expanded(child: Center(child: Image.asset(SImages.intro))),

          SizedBox(height: SSizes.lg),
        ],
      ),
    );
  }
}
