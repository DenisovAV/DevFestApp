import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Center( child: CircularProgressIndicator()));
  }

}

class CircleImage extends StatelessWidget {

  ImageProvider image;

  CircleImage(this.image);

  Widget build(BuildContext context) {
    return Container(
        width: 92.0,
        height: 92.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.fill,
                image: image
            )
        ));
  }
}

class LogoImage extends StatelessWidget {

  String url;

  LogoImage(this.url);

  Widget build(BuildContext context) {
    return url.contains('.svg') ? SvgPicture.network(url) : Image(
        image: NetworkImage(url));
  }

}