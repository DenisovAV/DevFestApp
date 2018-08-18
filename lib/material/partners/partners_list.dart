// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devfest_flutter_app/material/partners/partner.dart';
import 'package:flutter/material.dart';

// Each TabBarView contains a _Page and for each _Page there is a list
// of Partner objects. Each Partner object is displayed by a _CardItem.

class PartnerDataItem extends StatelessWidget {
  const PartnerDataItem({this.partner});

  static const double height = 116.0;
  final Partner partner;

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new SizedBox(
              width: 144.0,
              height: 72.0,
              child: new Image.network(
                partner.logoUrl,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PartnersList extends StatelessWidget {
  PartnersList({this.listName, this.list});

  final String listName;
  final Future<QuerySnapshot> list;

  @override
  Widget build(BuildContext context) {
    return
      new Container(
          height: 130.0,
          child: new Scaffold(
              body: new SafeArea(
                top: false,
                bottom: false,
                child: new FutureBuilder(
                    future: list,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) return new Text('Loading...');
                      List<Partner> _list = snapshot.data.documents.map((
                          par) => Partner.fromMap(par.data)).toList();
                      return new Builder(
                        builder: (BuildContext context) {
                          return new CustomScrollView(
                            key: new ValueKey(this.listName),
                            slivers: <Widget>[
                              new SliverPadding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2.0,
                                  horizontal: 16.0,
                                ),
                                sliver: new SliverFixedExtentList(
                                  itemExtent: PartnerDataItem.height,
                                  delegate: new SliverChildBuilderDelegate(
                                        (BuildContext context, int index) {
                                      final Partner partner = _list[index];
                                      return new Padding(
                                        padding: const EdgeInsets.symmetric(),
                                        child: new PartnerDataItem(
                                          partner: partner,
                                        ),
                                      );
                                    },
                                    childCount: _list.length,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }),
              )));
  }
}

