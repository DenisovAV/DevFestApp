import 'dart:async';

import 'package:devfest_flutter_app/src/models/speaker.dart';

class Member {
  Member({
    this.photoUrl,
    this.name,
    this.title,
    this.socials,
  });

  final String photoUrl;
  final String name;
  final String title;
  final List<Social> socials;

  Member.fromMap(Map<dynamic, dynamic> data): this(
      photoUrl: data['photoUrl'],
      name: data['name'],
      title: data['title'],
      socials: Social.fromList(data['socials']),
    );
}

class Team {
  Team({
    this.title,
  });
  final String title;
  Stream<List<Member>> members;
}
