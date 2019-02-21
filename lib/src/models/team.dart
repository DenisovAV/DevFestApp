import 'dart:async';

import 'package:devfest_flutter_app/src/models/social.dart';
import 'package:equatable/equatable.dart';

class Member extends Equatable {

  static const String PHOTO_URL = 'photoUrl';
  static const String NAME = 'name';
  static const String TITLE = 'title';
  static const String SOCIALS = 'socials';

  Member({
    this.photoUrl,
    this.name,
    this.title,
    this.socials,
  }) : super([photoUrl, name, title, socials]);

  final String photoUrl;
  final String name;
  final String title;
  final List<Social> socials;

  @override
  String toString() => 'Member {name: $name, title: $title}';

  Member.fromMap(Map<dynamic, dynamic> data): this(
      photoUrl: data[PHOTO_URL],
      name: data[NAME],
      title: data[TITLE],
      socials: Social.fromList(data[SOCIALS]),
    );

  Map<String, Object> toJson() => {
    TITLE: title,
    NAME: name,
    PHOTO_URL: photoUrl,
    SOCIALS: Social.toList(socials)
  };
}

class Team extends Equatable{
  static const String TITLE = 'title';

  Team({
    this.id,
    this.title,
  }): super([id, title]);
  final String id;
  final String title;
  List<Member> members;

  bool get isValid => members != null;

  @override
  String toString() => 'Team {id: $id, title: $title, members: $members}';

  Team.fromMap(Map<dynamic, dynamic> data, String documentId): this(
    id: documentId,
    title: data[TITLE],
  );

  Map<String, Object> toJson() => {
    TITLE: title
  };
}
