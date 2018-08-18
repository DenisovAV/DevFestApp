import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class DevFestIcons {
  double badgeWidth = 24.0;
  double badgeHeight = 24.0;

  double socialWidth = 32.0;
  double socialHeight = 32.0;


  Widget getBadgeIcon(String name, String url) => Padding(padding: EdgeInsets.only(right: 4.0),child: FloatingActionButton(
      child: SizedBox(
          width: badgeWidth,
          height: badgeHeight,
          child: SvgPicture.asset('assets/icons/${name}.svg', color: Colors.white,)),
          heroTag: name,
          shape: CircleBorder(side: BorderSide(color: Colors.white, width: 3.0)),
          mini: true,
          onPressed: () {_launchURL(url);}))
      ;

  Widget getSocialIcon(String name, String url) => IconButton(
      icon: SizedBox(
          width: socialWidth,
          height: socialHeight,
          child: SvgPicture.asset('assets/icons/${name}.svg')),
      onPressed: () {_launchURL(url);})
  ;

  Widget getTitleLogo(double width, double height) => SizedBox(
          width: width,
          height: height,
          child: SvgPicture.asset('assets/images/logo-monochrome.svg', color: Colors.white));

  Future _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
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
