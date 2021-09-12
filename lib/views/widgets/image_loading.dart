import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImgLoading extends StatelessWidget {
  const ImgLoading({Key? key, required this.imgUrl, required this.radius})
      : super(key: key);
  final String imgUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgUrl,
      imageBuilder: (context, imageProvider) => CircleAvatar(
        radius: radius,
        backgroundImage: CachedNetworkImageProvider(imgUrl),
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => CircleAvatar(
        radius: radius,
        child: Icon(
          Icons.error_outline,
          size: 40,
          color: Colors.red,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
