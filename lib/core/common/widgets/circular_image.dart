import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:social_network_app/core/common/widgets/shimmers/shimmer_effect.dart';
import 'package:social_network_app/core/theme/app_colors.dart';
import 'package:social_network_app/core/utils/constants/sizes.dart';
import 'package:social_network_app/core/utils/helpers/helper_functions.dart';

class SCircularImage extends StatelessWidget {
  const SCircularImage({
    super.key,
    this.boxFit = BoxFit.cover,
    required this.image,
    this.isNetworkImage = false,
    this.isFileImage = false,
    this.overlayColor,
    this.backgroundColor,
    this.width = 56,
    this.height = 56,
    this.padding = SSizes.sm,
  });

  final BoxFit? boxFit;
  final String image;
  final bool isNetworkImage;
  final bool isFileImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height, padding;

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;

    if (isNetworkImage) {
      imageProvider = CachedNetworkImageProvider(image);
    } else if (isFileImage) {
      imageProvider = FileImage(File(image));
    } else {
      imageProvider = AssetImage(image);
    }
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        // if image background color is null then switch it to light and dark mode color design
        color:
            backgroundColor ??
            (SHelperFunctions.isDarkMode(context)
                ? AppColors.surface
                : AppColors.white),
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Center(
          child: isNetworkImage
              ? CachedNetworkImage(
                  imageUrl: image,
                  fit: boxFit,
                  color: overlayColor,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      const SShimmerEffect(width: 55, height: 55, raduis: 55),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              : Image(image: imageProvider, fit: boxFit, color: overlayColor),
        ),
      ),
    );
  }
}
