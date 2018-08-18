// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:devfest_flutter_app/material/speakers/speaker.dart';
import 'package:devfest_flutter_app/utils/icons.dart';
import 'package:flutter/material.dart';

class _SocialViewer extends StatelessWidget {
  _SocialViewer({Key key, this.icons, this.tooltip})
      : super(key: key);

  final List<Widget> icons;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return new MergeSemantics(
      child: new Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: new Row(
              mainAxisAlignment: MainAxisAlignment.center, children: icons)),
    );
  }
}

class SpeakerDetailsViewer extends StatelessWidget {
  SpeakerDetailsViewer({this.speaker});

  static const double height = 116.0;
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
              child: Image.network(
                speaker.companyLogoUrl,
                fit: BoxFit.contain,
              ),
            ),
          Padding(
              padding: EdgeInsets.only(top: 16.0), child: Center(child: Text(speaker.name, style: TextStyle(fontSize: 32.0)))),
            Padding(
                padding: EdgeInsets.only(top: 4.0), child: Center(child: Text(speaker.country, style: TextStyle(fontSize: 24.0)))),
            Padding(
                padding: EdgeInsets.only(top: 16.0), child: Center(child: Text(speaker.bio, style: TextStyle(fontSize: 16.0)))),
            _SocialViewer(
              icons: speaker.socials
                  ?.map((social) => DevFestIcons().getSocialIcon(social.icon, social.link))
                  ?.toList(),
              tooltip: 'Social networks',
            )
          ],
        ),
      );
  }
}

class SpeakerDetails extends StatefulWidget {
  const SpeakerDetails({Key key, this.speaker}) : super(key: key);

  final Speaker speaker;

  @override
  SpeakerDetailsState createState() => new SpeakerDetailsState();
}

class SpeakerDetailsState extends State<SpeakerDetails> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>();
  final double _appBarHeight = 256.0;

  @override
  Widget build(BuildContext context) {
    print(widget.speaker.companyLogoUrl);
    return new Theme(
      data: new ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.indigo,
        platform: Theme.of(context).platform,
      ),
      child: new Scaffold(
        key: _scaffoldKey,
        body: new CustomScrollView(
          slivers: <Widget>[
            new SliverAppBar(
              expandedHeight: _appBarHeight,
              pinned: true,
              actions: widget.speaker.badges
                  ?.map((badge) => DevFestIcons().getBadgeIcon(badge.name, badge.link))
                  ?.toList(),
              flexibleSpace: new FlexibleSpaceBar(
                background: new Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    new Image.network(
                      widget.speaker.photoUrl,
                      fit: BoxFit.cover,
                      height: _appBarHeight,
                    ),
                    // This gradient ensures that the toolbar icons are distinct
                    // against the background image.
                    const DecoratedBox(
                      decoration: const BoxDecoration(
                        gradient: const LinearGradient(
                          begin: const Alignment(0.0, -1.0),
                          end: const Alignment(0.0, -0.4),
                          colors: const <Color>[
                            const Color(0x60000000),
                            const Color(0x00000000)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            new SliverList(
              delegate: new SliverChildListDelegate(<Widget>[
                new SpeakerDetailsViewer(speaker:widget.speaker),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
