import 'package:devfest_flutter_app/src/bloc/main/main_bloc.dart';
import 'package:devfest_flutter_app/src/ui/screens/team/team_page.dart';
import 'package:devfest_flutter_app/src/ui/widgets/info/venue_widget.dart';
import 'package:devfest_flutter_app/src/utils/colors.dart';
import 'package:devfest_flutter_app/src/utils/widgets.dart';
import 'package:flutter/material.dart';

class InfoTabWidget extends StatelessWidget {

  final MainBloc bloc;

  InfoTabWidget(this.bloc);

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
          Expanded(child: TabBarView(children: <Widget>[TeamPage(bloc), LoadingWidget(), MapsDemo()])),
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
      style: TextStyle(color: Utils.hexToColor("#676767")),
    );
  }
}