// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:devfest_flutter_app/material/speakers/speaker.dart';
import 'package:devfest_flutter_app/material/speakers/speaker_details.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

typedef void BannerTapCallback(Speaker speaker);

const double _kMinFlingVelocity = 800.0;

class SpeakerViewer extends StatefulWidget {
  const SpeakerViewer({Key key, this.speaker}) : super(key: key);

  final Speaker speaker;

  @override
  SpeakerViewerState createState() => new SpeakerViewerState();
}

class SpeakerTitleText extends StatelessWidget {
  const SpeakerTitleText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return new FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: new Text(text),
    );
  }
}

class SpeakerViewerState extends State<SpeakerViewer>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _flingAnimation;
  Offset _offset = Offset.zero;
  double _scale = 1.0;
  Offset _normalizedOffset;
  double _previousScale;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(vsync: this)
      ..addListener(_handleFlingAnimation);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // The maximum offset value is 0,0. If the size of this renderer's box is w,h
  // then the minimum offset value is w - _scale * w, h - _scale * h.
  Offset _clampOffset(Offset offset) {
    final Size size = context.size;
    final Offset minOffset =
        new Offset(size.width, size.height) * (1.0 - _scale);
    return new Offset(
        offset.dx.clamp(minOffset.dx, 0.0), offset.dy.clamp(minOffset.dy, 0.0));
  }

  void _handleFlingAnimation() {
    setState(() {
      _offset = _flingAnimation.value;
    });
  }

  void _handleOnScaleStart(ScaleStartDetails details) {
    setState(() {
      _previousScale = _scale;
      _normalizedOffset = (details.focalPoint - _offset) / _scale;
      // The fling animation stops if an input gesture starts.
      _controller.stop();
    });
  }

  void _handleOnScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _scale = (_previousScale * details.scale).clamp(1.0, 4.0);
      // Ensure that image location under the focal point stays in the same place despite scaling.
      _offset = _clampOffset(details.focalPoint - _normalizedOffset * _scale);
    });
  }

  void _handleOnScaleEnd(ScaleEndDetails details) {
    final double magnitude = details.velocity.pixelsPerSecond.distance;
    if (magnitude < _kMinFlingVelocity) return;
    final Offset direction = details.velocity.pixelsPerSecond / magnitude;
    final double distance = (Offset.zero & context.size).shortestSide;
    _flingAnimation = new Tween<Offset>(
            begin: _offset, end: _clampOffset(_offset + direction * distance))
        .animate(_controller);
    _controller
      ..value = 0.0
      ..fling(velocity: magnitude / 1000.0);
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onScaleStart: _handleOnScaleStart,
      onScaleUpdate: _handleOnScaleUpdate,
      onScaleEnd: _handleOnScaleEnd,
      child: new ClipRect(
        child: new Transform(
          transform: new Matrix4.identity()
            ..translate(_offset.dx, _offset.dy)
            ..scale(_scale),
          child: SpeakerDetails(speaker: widget.speaker),
        ),
      ),
    );
  }
}

class SpeakerItem extends StatelessWidget {
  SpeakerItem({Key key, @required this.speaker, @required this.onBannerTap})
      : assert(speaker != null && speaker.isValid),
        assert(onBannerTap != null),
        super(key: key);


  final Speaker speaker;
  final BannerTapCallback onBannerTap;

  void showPhoto(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute<void>(builder: (BuildContext context) {
      return
        new Scaffold(
        body: new SizedBox.expand(
          child: new Hero(
            tag: speaker.tag,
            child: new SpeakerViewer(speaker: speaker),
          ),
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    final Widget image = new GestureDetector(
        onTap: () {
          showPhoto(context);
        },
        child: new Hero(
            key: new Key(speaker.photoUrl),
            tag: speaker.tag,
            child: new Image.network(
              speaker.photoUrl,
              fit: BoxFit.cover,
            )));

    final IconData icon = speaker.isFavorite ? Icons.star : Icons.star_border;

    return new GridTile(
      footer: new GestureDetector(
        onTap: () {
          onBannerTap(speaker);
        },
        child: new GridTileBar(
          backgroundColor: Colors.black45,
          title: new SpeakerTitleText(speaker.name),
          subtitle: new SpeakerTitleText(speaker.company),
          trailing: new Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
      child: image,
    );
  }
}

class SpeakersGrid extends StatefulWidget {
  const SpeakersGrid({Key key}) : super(key: key);

  @override
  SpeakersGridState createState() => new SpeakersGridState();
}

class SpeakersGridState extends State<SpeakersGrid> {

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery
        .of(context)
        .orientation;
    return new StreamBuilder(
        stream: Firestore.instance.collection('speakers').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return new Text('Loading...');
          return new Scaffold(
            body: new Column(
              children: <Widget>[
                new Expanded(
                  child: new SafeArea(
                    top: false,
                    bottom: false,
                    child: new GridView.count(
                      crossAxisCount:
                      (orientation == Orientation.portrait) ? 2 : 3,
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                      padding: const EdgeInsets.all(4.0),
                      childAspectRatio:
                      (orientation == Orientation.portrait) ? 1.0 : 1.3,
                      children: snapshot.data.documents
                          .map((doc) =>
                      new SpeakerItem(
                          speaker: Speaker.fromMap(doc.data),
                          onBannerTap: (Speaker speaker) {
                            setState(() {
                              speaker.isFavorite = !speaker.isFavorite;
                            });
                          }))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
