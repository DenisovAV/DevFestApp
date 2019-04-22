import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: CircularProgressIndicator()));
  }
}

class CircleImage extends StatelessWidget {
  final ImageProvider image;
  CircleImage(this.image);

  Widget build(BuildContext context) {
    return Container(
        width: 92.0,
        height: 92.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(fit: BoxFit.fill, image: image)));
  }
}

class CachedImage extends StatelessWidget {
  final String url;
  final BoxFit fit;

  CachedImage(this.url, {this.fit});

  Widget build(BuildContext context) {
    if(url == null) {
      return Image.asset('assets/images/logo_blue.png');
    }
    return url.contains('.svg')
        ? SvgPicture.network(url,
            fit: fit ?? BoxFit.contain,
            headers: {'Cache-Control': 'only-if-cached'})
        : CachedNetworkImage(
            imageUrl: url,
            fit: fit ?? BoxFit.contain,
            placeholder: (context, url) => LoadingWidget(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ) ?? Container();
  }
}
