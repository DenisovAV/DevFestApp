import 'package:equatable/equatable.dart';

class Session extends Equatable {
  static const String COMPLEXITY = 'complexity';
  static const String TITLE = 'title';
  static const String DESCRIPTION = 'description';
  static const String LANGUAGE = 'language';
  static const String ICON = 'icon';
  static const String IMAGE = 'image';
  static const String TAGS = 'tags';
  static const String SPEAKERS = 'speakers';

  Session({
    this.id,
    this.complexity,
    this.title,
    this.description,
    this.language,
    this.icon,
    this.image,
    this.tags,
    this.speakers,
  })  : assert(id != null),
        assert(title != null),
        super([
          id,
          complexity,
          title,
          description,
          language,
          icon,
          image,
        ]);

  final String id;
  final String complexity;
  final String title;
  final String description;
  final String language;
  final String icon;
  final String image;
  final List<String> tags;
  final List<String> speakers;

  String get tag => title;

  @override
  String toString() => 'Session {id: $id, name: $title}';

  Session.fromMap(Map<String, dynamic> data, String documentId)
      : this(
          id: documentId,
          complexity: data[COMPLEXITY],
          title: data[TITLE],
          description: data[DESCRIPTION],
          language: data[LANGUAGE],
          icon: data[ICON]??"",
          image: data[IMAGE]??"",
          speakers: List<String>.from(data[SPEAKERS] ?? []),
          tags: List<String>.from(data[TAGS] ?? []),
        );

  Map<String, Object> toJson() => {
        COMPLEXITY: complexity,
        TITLE: title,
        DESCRIPTION: description,
        LANGUAGE: language,
        ICON: icon,
        IMAGE: image,
        SPEAKERS: speakers,
        TAGS: tags,
      };
}
