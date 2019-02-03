import 'package:equatable/equatable.dart';

class Speaker extends Equatable {
  static const String PHOTO_URL = 'photoUrl';
  static const String NAME = 'name';
  static const String COMPANY = 'company';
  static const String COMPANY_LOGO_URL = 'companyLogoUrl';
  static const String TITLE = 'title';
  static const String COUNTRY = 'country';
  static const String BIO = 'bio';
  static const String SOCIALS = 'socials';
  static const String BADGES = 'badges';

  Speaker(
      {this.id,
      this.photoUrl,
      this.name,
      this.company,
      this.companyLogoUrl,
      this.bio,
      this.title,
      this.country,
      this.socials,
      this.badges})
      : assert(id != null),
        assert(name != null),
        super([
          id,
          photoUrl,
          name,
          company,
          companyLogoUrl,
          bio,
          title,
          country,
          socials,
          badges
        ]);

  final String id;
  final String photoUrl;
  final String name;
  final String company;
  final String companyLogoUrl;
  final String title;
  final String country;
  final String bio;
  final List<Social> socials;
  final List<Badge> badges;

  String get tag => name;

  bool get isValid => photoUrl != null && name != null && company != null;

  @override
  String toString() => 'Speaker {id: $id, name: $name}';

  Speaker.fromMap(Map<String, dynamic> data, String documentId)
      : this(
            id: documentId,
            photoUrl: data[PHOTO_URL],
            name: data[NAME],
            company: data[COMPANY],
            companyLogoUrl: data[COMPANY_LOGO_URL],
            title: data[TITLE],
            country: data[COUNTRY],
            bio: data[BIO],
            socials: Social.fromList(data[SOCIALS]),
            badges: Badge.fromList(data[BADGES]));

  Map<String, Object> toJson() => {
        PHOTO_URL: photoUrl,
        NAME: name,
        COMPANY: company,
        COMPANY_LOGO_URL: companyLogoUrl,
        TITLE: title,
        COUNTRY: country,
        BIO: bio,
        SOCIALS: Social.toList(socials),
        BADGES: Badge.toList(badges),
      };
}

class Social extends Equatable {
  static const String ICON = 'icon';
  static const String NAME = 'name';
  static const String LINK = 'link';

  Social({
    this.icon,
    this.name,
    this.link,
  })  : assert(name != null),
        super([
          icon,
          name,
          link,
        ]);

  final String icon;
  final String name;
  final String link;

  @override
  String toString() => 'Social {name: $name}';

  Social.fromMap(Map<dynamic, dynamic> data)
      : this(icon: data[ICON], name: data[NAME], link: data[LINK]);

  Map<String, Object> toJson() => {
        ICON: icon,
        NAME: name,
        LINK: link,
      };

  static List<dynamic> toList(List<Social> list) =>
      list?.map((item) => item.toJson())?.toList();

  static List<Social> fromList(List<dynamic> list) =>
      list?.map((item) => Social.fromMap(item))?.toList();
}

class Badge extends Equatable {
  static String DESCRIPTION = 'description';
  static String NAME = 'name';
  static String LINK = 'link';

  Badge({
    this.description,
    this.name,
    this.link,
  })  : assert(name != null),
        super([
          description,
          name,
          link,
        ]);

  final String description;
  final String name;
  final String link;

  @override
  String toString() => 'Bagde {name: $name}';

  Badge.fromMap(Map<dynamic, dynamic> data)
      : this(
            description: data[DESCRIPTION], name: data[NAME], link: data[LINK]);

  Map<String, Object> toJson() => {
        DESCRIPTION: description,
        NAME: name,
        LINK: link,
      };

  static List<dynamic> toList(List<Badge> list) =>
      list?.map((item) => item.toJson())?.toList();

  static List<Badge> fromList(List<dynamic> list) =>
      list?.map((item) => Badge.fromMap(item))?.toList();
}
