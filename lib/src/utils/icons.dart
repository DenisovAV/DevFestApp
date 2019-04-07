import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class IconHelper {
  double badgeWidth = 24.0;
  double badgeHeight = 24.0;

  Widget getBadgeIcon(String name, String url) => Padding(
      padding: EdgeInsets.only(right: 4.0),
      child: FloatingActionButton(
          backgroundColor: getCommunityColor(name),
          child: SizedBox(
              width: badgeWidth,
              height: badgeHeight,
              child: SvgPicture.asset('assets/icons/${name}.svg',
                  color: Colors.white)),
          heroTag: url,
          shape:
              CircleBorder(side: BorderSide(color: Colors.white, width: 3.0)),
          mini: true,
          onPressed: () {
            _launchURL(url);
          }));

  Widget getSocialIcon(String name, String url, double size, {Color color, EdgeInsetsGeometry padding}) =>
      SizedBox(
        child: IconButton(
            iconSize: size,
            padding: padding!=null ? padding: EdgeInsets.zero,
            icon: SvgPicture.asset('assets/icons/${name}.svg', color: color),
            onPressed: () {
              _launchURL(url);
            }),
        width: size,
        height: size,
      );

  Widget getTitleLogo(double width, double height) => SizedBox(
      width: width,
      height: height,
      child: SvgPicture.asset('assets/images/logo-monochrome.svg',
          color: Colors.white));

  Future _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  static String getSessionImageAsset(String tag) {
    if (tag == 'Machine Learning') return 'assets/tags/machine_learning.jpg';
    if (tag == 'Kotlin') return 'assets/tags/kotlin.png';
    if (tag == 'Android') return 'assets/tags/android.jpg';
    return 'assets/images/logo.png';
  }

  Color getCommunityColor(String type) {
    if (type == "gdg") {
      return Colors.blue;
    } else if (type == "gde") {
      return Colors.indigo;
    } else {
      return Colors.greenAccent;
    }
  }

  static Widget telegram = SvgPicture.asset('assets/icons/telegram.svg');
  static Widget twitter = SvgPicture.asset('assets/icons/twitter.svg');
  static Widget youtube = SvgPicture.asset('assets/icons/youtube.svg');
  static Widget vkontakte = SvgPicture.asset('assets/icons/vkontakte.svg');
  static Widget website = SvgPicture.asset('assets/icons/website.svg');
  static Widget facebook = SvgPicture.asset('assets/icons/facebook.svg');
  static Widget gplus = SvgPicture.asset('assets/icons/gplus.svg');
  static Widget github = SvgPicture.asset('assets/icons/github.svg');
  static Widget instagram = SvgPicture.asset('assets/icons/instagram.svg');
  static Widget linkedin = SvgPicture.asset('assets/icons/linkedin.svg');
  static Widget gde = SvgPicture.asset('assets/icons/gde.svg');
  static Widget gdg = SvgPicture.asset('assets/icons/gdg.svg');
  static Widget wtm = SvgPicture.asset('assets/icons/wtm.svg');
}

class CoverImageWidget extends StatelessWidget {
  final String imageUrl;

  CoverImageWidget(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null) {
      return FadeInImage.assetNetwork(
          fit: BoxFit.fitWidth,
          placeholder: 'assets/images/logo_blue.png',
          image: imageUrl);
    } else {
      return Image(
        fit: BoxFit.fitWidth,
        image: AssetImage('assets/images/logo_blue.png'),
      );
    }
  }
}
