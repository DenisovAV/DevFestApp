import 'package:equatable/equatable.dart';

class Logo extends Equatable {

  static const String LOGO_URL = 'logoUrl';
  static const String NAME = 'name';
  static const String LINK_URL = 'linkUrl';

  Logo({
    this.logoUrl,
    this.name,
    this.linkUrl,
  }) : super([logoUrl, name, linkUrl]);

  final String logoUrl;
  final String name;
  final String linkUrl;

  Logo.fromMap(Map<String, dynamic> data)
      : this(
            logoUrl: data[LOGO_URL], name: data[NAME], linkUrl: data[LINK_URL]);

  @override
  String toString() => 'Logo {name: $name}';

  Map<String, Object> toJson() => {
    LOGO_URL: logoUrl,
    NAME: name,
    LINK_URL: linkUrl
  };
}

class Partner extends Equatable {

  static const String TITLE = 'title';

  Partner({
    this.id,
    this.title,
  }): super([id, title]);
  final String id;
  final String title;
  List<Logo> logos;

  bool get isValid => logos != null;

  @override
  String toString() => 'Partner {id: $id, title: $title, logos: $logos}';

  Partner.fromMap(Map<dynamic, dynamic> data, String documentId): this(
    id: documentId,
    title: data[TITLE],
  );

  Map<String, Object> toJson() => {
    TITLE: title
  };
}
