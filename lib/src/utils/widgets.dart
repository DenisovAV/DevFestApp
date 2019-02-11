import 'package:flutter/material.dart';

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
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.fill,
                image: image
            )
        ));
  }
}