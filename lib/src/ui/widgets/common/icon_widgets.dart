import 'package:devfest_flutter_app/src/bloc/events/event.dart';
import 'package:devfest_flutter_app/src/models/social.dart';
import 'package:devfest_flutter_app/src/providers/bloc_provider.dart';
import 'package:devfest_flutter_app/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BadgeIcon extends StatelessWidget {
  final Badge badge;
  final double _badgeWidth = 24.0;
  final double _badgeHeight = 24.0;

  BadgeIcon(this.badge, {Key key})
      : assert(badge != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: 4.0),
        child: FloatingActionButton(
            backgroundColor: Utils.getCommunityColor(badge.name),
            child: SizedBox(
                width: _badgeWidth,
                height: _badgeHeight,
                child: SvgPicture.asset('assets/icons/${badge.name}.svg',
                    color: Colors.white)),
            heroTag: badge,
            shape:
                CircleBorder(side: BorderSide(color: Colors.white, width: 3.0)),
            mini: true,
            onPressed: () {
              BlocProvider.of(context).data.events.add(BadgeTappedEvent(badge));
            }));
  }
}

class SocialIcon extends StatelessWidget {
  final Social social;
  final Color color;
  final EdgeInsetsGeometry _padding;
  final double _size;

  SocialIcon(this.social,
      {Key key, double size, this.color, EdgeInsetsGeometry padding})
      : _padding = padding,
        _size = size,
        assert(social != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: IconButton(
          iconSize: _size,
          padding: _padding != null ? _padding : EdgeInsets.zero,
          icon:
              SvgPicture.asset('assets/icons/${social.name}.svg', color: color),
          onPressed: () {
            BlocProvider.of(context).data.events.add(SocialTappedEvent(social));
          }),
      width: _size,
      height: _size,
    );
  }
}
