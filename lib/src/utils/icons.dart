import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

typedef void IconCallback(Equatable event);

class IconHelper {
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
  static Widget gdg({Color color}) => SvgPicture.asset('assets/icons/gdg.svg', color: color ?? Colors.black);
  static Widget wtm = SvgPicture.asset('assets/icons/wtm.svg');
}
