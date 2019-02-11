import 'package:equatable/equatable.dart';

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
