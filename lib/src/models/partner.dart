import 'package:equatable/equatable.dart';

class Partner extends Equatable {

  static const String LOGO_URL = 'logoUrl';
  static const String NAME = 'name';
  static const String LINK_URL = 'linkUrl';

  Partner({
    this.logoUrl,
    this.name,
    this.linkUrl,
  }) : super([logoUrl, name, linkUrl]);

  final String logoUrl;
  final String name;
  final String linkUrl;

  Partner.fromMap(Map<String, dynamic> data)
      : this(
            logoUrl: data[LOGO_URL], name: data[NAME], linkUrl: data[LINK_URL]);

  @override
  String toString() => 'Partner {name: $name}';

  Map<String, Object> toJson() => {
    LOGO_URL: logoUrl,
    NAME: name,
    LINK_URL: linkUrl
  };
}
