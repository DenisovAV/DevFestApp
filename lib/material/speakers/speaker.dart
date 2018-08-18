
class Speaker {
  Speaker({
    this.photoUrl,
    this.name,
    this.company,
    this.companyLogoUrl,
    this.bio,
    this.title,
    this.country,
    this.socials,
    this.badges,
    this.isFavorite: false
  });

  final String photoUrl;
  final String name;
  final String company;
  final String companyLogoUrl;
  final String title;
  final String country;
  final String bio;
  final List<Social> socials;
  final List<Badge> badges;

  bool isFavorite;
  String get tag => name;

  bool get isValid =>
      photoUrl != null && name != null && company != null && isFavorite != null;

  Speaker.fromMap(Map<dynamic, dynamic> data)
      : this(photoUrl: data['photoUrl'], name: data['name'], company: data['company'], companyLogoUrl: data['companyLogoUrl'], title: data['title'],
      country: data['country'], bio: data['bio'], socials: Social.fromList(data['socials']), badges: Badge.fromList(data['badges']));
}

class Social {
  Social({
    this.icon,
    this.name,
    this.link,
  });

  final String icon;
  final String name;
  final String link;

  Social.fromMap(Map<dynamic, dynamic> data)
      : this(icon: data['icon'], name: data['name'], link: data['link']);

  static List<Social> fromList(List<dynamic> list) => list?.map((item)=> Social.fromMap(item))?.toList();

}

class Badge {
  Badge({
    this.description,
    this.name,
    this.link,
  });

  final String description;
  final String name;
  final String link;

  Badge.fromMap(Map<dynamic, dynamic> data)
      : this(description: data['description'], name: data['name'], link: data['link']);

  static List<Badge> fromList(List<dynamic> list) => list?.map((item)=> Badge.fromMap(item))?.toList();
}
