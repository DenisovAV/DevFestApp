import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devfest_flutter_app/src/models/partner.dart';
import 'package:devfest_flutter_app/src/utils/widgets.dart';
import 'package:flutter/material.dart';

class PartnerDataItem extends StatelessWidget {
  const PartnerDataItem(this.partner);

  static const double height = 116.0;
  final Partner partner;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 144.0,
              height: 72.0,
              child: Image.network(
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
  PartnersList(this.listName, this.list);

  final String listName;
  final Future<QuerySnapshot> list;

  @override
  Widget build(BuildContext context) {
    return
      Container(
          height: 130.0,
          child: Scaffold(
              body: SafeArea(
                top: false,
                bottom: false,
                child: FutureBuilder(
                    future: list,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) return LoadingWidget();
                      List<Partner> _list = snapshot.data.documents.map((
                          par) => Partner.fromMap(par.data)).toList();
                      return Builder(
                        builder: (BuildContext context) {
                          return CustomScrollView(
                            key: ValueKey(this.listName),
                            slivers: <Widget>[
                              SliverPadding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 2.0,
                                  horizontal: 16.0,
                                ),
                                sliver: SliverFixedExtentList(
                                  itemExtent: PartnerDataItem.height,
                                  delegate: SliverChildBuilderDelegate(
                                        (BuildContext context, int index) {
                                      final Partner partner = _list[index];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(),
                                        child: PartnerDataItem(
                                          partner,
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

