// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devfest_flutter_app/material/partners/partners_list.dart';
import 'package:flutter/material.dart';

class PartnersGroupList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
        stream: Firestore.instance.collection('partners').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return new Text('Loading...');
          return new Scaffold(
              body: new ListView(children: snapshot.data.documents
                  .map((doc) =>
              new ExpansionTile(
                  title: new Text(doc['title']),
                  backgroundColor:
                  Theme
                      .of(context)
                      .accentColor
                      .withOpacity(0.025),
                  initiallyExpanded: true,
                  children: <Widget>[ new PartnersList(
                    listName: doc['title'],
                    list:
                    doc.reference.collection('items').getDocuments(),
                  )
                  ])).toList())
          );
        });
  }
}
