import 'package:devfest_flutter_app/src/models/speaker.dart';
import 'package:devfest_flutter_app/src/utils/icons.dart';
import 'package:devfest_flutter_app/src/utils/widgets.dart';
import 'package:flutter/material.dart';

class _SocialViewer extends StatelessWidget {
  _SocialViewer(this.icons, this.tooltip);

  final List<Widget> icons;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center, children: icons)),
    );
  }
}

class SpeakerDetailsViewer extends StatelessWidget {
  SpeakerDetailsViewer(this.speaker);

  static const double HEIGHT = 116.0;
  static const String SOCIAL_NETWORKS='Social networks';
  final Speaker speaker;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 48.0,
            height: 24.0,
            child: CachedImage(speaker.companyLogoUrl)
          ),
          Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Center(
                  child: Text(speaker.name, style: TextStyle(fontSize: 32.0)))),
          Padding(
              padding: EdgeInsets.only(top: 4.0),
              child: Center(
                  child:
                      Text(speaker.country, style: TextStyle(fontSize: 24.0)))),
          Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Center(
                  child: Text(speaker.bio, style: TextStyle(fontSize: 16.0)))),
          _SocialViewer(
            speaker.socials
                ?.map((social) =>
                    IconHelper().getSocialIcon(social.icon, social.link, 32.0))
                ?.toList(),
            SOCIAL_NETWORKS,
          )
        ],
      ),
    );
  }
}

class SpeakerDetails extends StatelessWidget {
  SpeakerDetails(this.speaker);

  static final GlobalKey<ScaffoldState> _scaffoldKey =
  GlobalKey<ScaffoldState>();
  final Speaker speaker;

  final double _appBarHeight = 256.0;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.indigo,
        platform: Theme
            .of(context)
            .platform,
      ),
      child: Scaffold(
        key: _scaffoldKey,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: _appBarHeight,
              pinned: true,
              actions: speaker.badges
                  ?.map((badge) =>
                  IconHelper().getBadgeIcon(badge.name, badge.link))
                  ?.toList(),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    CachedImage(speaker.photoUrl, fit: BoxFit.fitWidth),
                    // This gradient ensures that the toolbar icons are distinct
                    // against the background image.
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(<Widget>[
                SpeakerDetailsViewer(speaker),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

