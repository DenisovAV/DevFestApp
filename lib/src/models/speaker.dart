import 'package:devfest_flutter_app/src/models/social.dart';
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