import 'package:devfest_flutter_app/src/models/team.dart';
import 'package:devfest_flutter_app/src/utils/icons.dart';
import 'package:devfest_flutter_app/src/utils/widgets.dart';
import 'package:flutter/material.dart';

class TeamMembersWidget extends StatelessWidget {
  final List<Team> teams;
  TeamMembersWidget(this.teams);

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
                    (context, index) => _MemberPanel(teams[0].members[index]),
                    childCount: teams[0].members.length,
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

class _MemberPanel extends StatelessWidget {
  final Member member;
  _MemberPanel(this.member);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120.0,
        margin: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 24.0,
        ),
        child: new Stack(
          children: <Widget>[
            _MemberCard(member),
            _MemberAvatar(member.photoUrl),
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
        margin: EdgeInsets.symmetric(vertical: 16.0),
        alignment: FractionalOffset.centerLeft,
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
      height: 124.0,
      margin: EdgeInsets.only(left: 32.0),
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
    );
  }
}

class _MemberCardContent extends StatelessWidget {
  final Member member;
  _MemberCardContent(this.member);

  @override
  Widget build(BuildContext context) {
    final baseTextStyle = const TextStyle(
      fontFamily: 'GoogleSans',
    );
    final regularTextStyle = baseTextStyle.copyWith(
        color: Colors.white, fontSize: 9.0, fontWeight: FontWeight.w400);

    final subHeaderTextStyle = regularTextStyle.copyWith(fontSize: 14.0);
    final headerTextStyle = baseTextStyle.copyWith(
        color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.w600);

    return Container(
      margin: EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
      constraints: BoxConstraints.expand(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(height: 4.0),
          Text(member.name, style: headerTextStyle),
          Container(height: 8.0),
          Text(member.title, style: subHeaderTextStyle),
          Container(height: 14.0),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: member.socials
                      ?.map(
                        (social) => Padding(
                            child: IconHelper().getSocialIcon(
                                social.icon, social.link, 18.0,
                                color: Colors.white),
                            padding: EdgeInsets.only(left: 10.0)),
                      )
                      ?.toList() ??
                  [Container()]),
        ],
      ),
    );
  }
}
