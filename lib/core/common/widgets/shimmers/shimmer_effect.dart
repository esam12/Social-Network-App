
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_network_app/core/theme/app_colors.dart';
import 'package:social_network_app/core/utils/helpers/helper_functions.dart';

class SShimmerEffect extends StatelessWidget {
  const SShimmerEffect(
      {super.key,
      required this.width,
      required this.height,
      this.raduis = 15.0,
      this.color});

  final double width, height, raduis;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return Shimmer.fromColors(
      baseColor: dark ? Colors.grey[850]! : Colors.grey[300]!,
      highlightColor: dark ? Colors.grey[700]! : Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? (dark ? AppColors.darkerGrey : AppColors.white),
          borderRadius: BorderRadius.circular(raduis),
        ),
      ),
    );
  }
}