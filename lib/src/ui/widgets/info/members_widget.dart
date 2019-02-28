import 'package:devfest_flutter_app/src/models/team.dart';
import 'package:devfest_flutter_app/src/utils/colors.dart';
import 'package:devfest_flutter_app/src/utils/icons.dart';
import 'package:devfest_flutter_app/src/utils/widgets.dart';
import 'package:flutter/material.dart';

class TeamsWidget extends StatelessWidget {
  final List<Team> teams;
  TeamsWidget(this.teams);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
      Expanded(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/fon1.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: CustomScrollView(
            scrollDirection: Axis.vertical,
            shrinkWrap: false,
            slivers: <Widget>[
              SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 2.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _TeamMembersList(teams[index]),
                    childCount: teams.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    ]));
  }
}

class _TeamMembersList extends StatelessWidget {
  final Team team;

  _TeamMembersList(this.team);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 180.0 * ((team.members.length + 1) / 2).truncate() + 35.0,
        margin: EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 24.0,
        ),
        decoration: BoxDecoration(
          color: Colors.black45,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(children: <Widget>[
          _TeamTitleText(team.title),
          Column(
              children: _separate(team.members)
                  .map((list) => Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: list
                          .map(
                              (member) => Expanded(child: _MemberPanel(member)))
                          .toList()))
                  .toList())
        ]));
  }

  List<List<Member>> _separate(List<Member> members) {
    List<List<Member>> ret = List<List<Member>>();
    for (int i = 0; i < members.length; i += 2) {
      List<Member> tmp = List<Member>();
      tmp.add(members[i]);
      if (i + 1 != members.length) {
        tmp.add(members[i + 1]);
      }
      ret.add(tmp);
    }
    return ret;
  }
}

class _MemberPanel extends StatelessWidget {
  final Member member;
  _MemberPanel(this.member);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 180.0,
        child: Column(
          children: <Widget>[
            _MemberAvatar(member.photoUrl),
            _MemberCard(member),
          ],
        ));
  }
}

class _MemberAvatar extends StatelessWidget {
  final String photoUrl;
  _MemberAvatar(this.photoUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: FractionalOffset.topCenter,
        child: CircleImage(NetworkImage(photoUrl)));
  }
}

class _MemberCard extends StatelessWidget {
  final Member member;
  _MemberCard(this.member);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _MemberCardContent(member),
      height: 80.0,
    );
  }
}

class _MemberCardContent extends StatelessWidget {
  final Member member;
  _MemberCardContent(this.member);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: FractionalOffset.topCenter,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(height: 4.0),
              Text(member.name, style: Utils.subHeaderTextStyle()),
              Container(height: 8.0),
              Text(member.title, style: Utils.regularTextStyle()),
              Container(height: 8.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: member.socials
                          ?.map(
                            (social) => IconHelper().getSocialIcon(
                                social.icon, social.link, 26.0,
                                color: Colors.white,
                                padding: EdgeInsets.symmetric(horizontal: 4.0)),
                          )
                          ?.toList() ??
                      [Container()]),
            ],
          ),
        ));
  }
}

class _TeamTitleText extends StatelessWidget {
  _TeamTitleText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      alignment: Alignment.center,
      child: Text(text, style: Utils.headerTextStyle(Colors.white)),
    );
  }
}
