import 'package:fojb_election/presentation/utils/utils.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imgUrl;
  final double borderRadius;
  final double? width;
  final double? height;
  final BoxFit fit;

  const CustomNetworkImage({
    Key? key,
    required this.imgUrl,
    this.borderRadius: 0,
    this.width,
    this.height,
    this.fit: BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imgUrl,
        fit: fit,
        width: width,
        height: height,
        fadeInCurve: Curves.easeInCubic,
        fadeInDuration: Duration(milliseconds: 500),
        fadeOutCurve: Curves.easeOutCubic,
        fadeOutDuration: Duration(milliseconds: 500),
        placeholder: (context, url) => Shimmer.fromColors(
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.green,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
        ),
        errorWidget: (context, url, error) => Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.grey,
          child: Icon(
            Icons.error,
            color: AppTheme.black,
          ),
        ),
      ),
    );
  }
}
