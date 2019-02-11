import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devfest_flutter_app/src/resources/team_repository.dart';
import 'package:devfest_flutter_app/src/ui/screens/team/team_page.dart';
import 'package:devfest_flutter_app/src/ui/widgets/info/venue_widget.dart';
import 'package:devfest_flutter_app/src/ui/widgets/info/members_widget.dart';
import 'package:devfest_flutter_app/src/utils/colors.dart';
import 'package:devfest_flutter_app/src/utils/widgets.dart';
import 'package:flutter/material.dart';

class InfoTabWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: <Widget>[
          TabBar(
            isScrollable: false,
            tabs: [
              Tab(child: TabTextTheme("Team")),
              Tab(child: TabTextTheme("Partners")),
              Tab(child: TabTextTheme("About")),
            ],
          ),
          Expanded(child: TabBarView(children: <Widget>[TeamPage(repository: FirestoreTeamRepository(Firestore.instance)), LoadingWidget(), MapsDemo()])),
        ],
      ),
    );
  }
}

class TabTextTheme extends StatelessWidget {
  final String text;

  const TabTextTheme(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: ColorUtils.hexToColor("#676767")),
    );
  }
}