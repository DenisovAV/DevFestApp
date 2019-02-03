import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devfest_flutter_app/src/ui/widgets/info/partners_list.dart';
import 'package:devfest_flutter_app/src/utils/widgets.dart';
import 'package:flutter/material.dart';

class PartnersGroupList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance.collection('partners').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return LoadingWidget();
          return Scaffold(
              body: ListView(children: snapshot.data.documents
                  .map((doc) =>
              new ExpansionTile(
                  title: Text(doc['title']),
                  backgroundColor:
                  Theme
                      .of(context)
                      .accentColor
                      .withOpacity(0.025),
                  initiallyExpanded: true,
                  children: <Widget>[ PartnersList(
                    doc['title'],
                    doc.reference.collection('items').getDocuments(),
                  )
                  ])).toList())
          );
        });
  }
}
