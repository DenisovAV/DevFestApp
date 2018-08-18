// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devfest_flutter_app/material/speakers/speaker.dart';
import 'package:devfest_flutter_app/utils/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class _SocialViewer extends StatelessWidget {
  _SocialViewer({Key key, this.icons, this.tooltip}) : super(key: key);

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
            icons: speaker.socials
                ?.map((social) =>
                    DevFestIcons().getSocialIcon(social.icon, social.link))
                ?.toList(),
            tooltip: 'Social networks',
          )
        ],
      ),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  HomeViewState createState() => new HomeViewState();
}

class HomeViewState extends State<HomeView> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
  new GlobalKey<ScaffoldState>();
  final double _appBarHeight = 256.0;

  @override
  Widget build(BuildContext context) {
    return new Theme(
      data: new ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.indigo,
        platform: Theme
            .of(context)
            .platform,
      ),
      child: new Scaffold(
        key: _scaffoldKey,
        body: new CustomScrollView(
          slivers: <Widget>[
            new SliverAppBar(
                expandedHeight: _appBarHeight,
                pinned: true,
                flexibleSpace: new FlexibleSpaceBar(
                    background:
                    new Stack(fit: StackFit.expand, children: <Widget>[
                      Image.asset(
                        'assets/images/home.jpg',
                        fit: BoxFit.cover,
                        height: _appBarHeight,
                      ),
                      // This gradient ensures that the toolbar icons are distinct
                      // against the background image.
                      DecoratedBox(
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
                      Center(
                          child: Padding(
                              padding: EdgeInsets.only(top: 50.0),
                              child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                        width: 216.0,
                                        height: 72.0,
                                        child: Image.asset(
                                          'assets/images/logo.png',
                                          fit: BoxFit.contain,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(top: 2.0), child: Center(child: Text('Nizhny Novgorod. October 27, 2018', style: TextStyle(color: Colors.white, fontSize: 16.0)))),
                                    Padding(
                                        padding: EdgeInsets.only(top: 4.0, bottom: 16.0), child: Center(child: Text('Be a hero. Be a GDG!', style: TextStyle(color: Colors.white, fontSize: 16.0)))),
                                    new OutlineButton(
                                      child: Text('VIEW HIGHLIGHTS',
                                          style: TextStyle(
                                              color: Colors.white)),
                                      onPressed: () {
                                        // Perform some action
                                      },
                                    )
                                  ])))
                    ]))),
            SliverList(
                delegate: new SliverChildListDelegate(<Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 16.0), child: Center(child: Text('What you need to know, before you ask.', style: TextStyle(fontSize: 20.0)))),
                  Padding(
                      padding: EdgeInsets.only(top: 16.0, left: 10.0, right: 10.0), child: Center(child: Text('What is DevFest? Google Developer Group DevFests are the largest Google related events in the world! Each DevFest is carefully crafted for you by your local GDG community to bring in awesome speakers from all over the world, great topics, and lots fun!', style: TextStyle(fontSize: 16.0)))),
                  Container(height: 500.0, child:TicketsList())
                ])),
          ],
        ),
      ),
    );
  }
}

class TicketsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
        stream: Firestore.instance.collection('tickets').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return new Text('Loading...');
          return new Scaffold(
              body: new ListView(children: snapshot.data.documents
                  .map((doc) =>
              new ListTile(
                  title: new Text(doc['name']),
                  )).toList())
          );
        });
  }
}

