import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'loading.dart';

class CacheImageWidget extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final double radius;

  const CacheImageWidget({
    Key? key,
    required this.imageUrl,
    required this.width,
    required this.height,
    this.radius = 8.0,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
          fadeInDuration: const Duration(milliseconds: 20),
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          width: width,
          height: height,
          placeholder: (context, url) => const Loading()),
    );
  }
}
