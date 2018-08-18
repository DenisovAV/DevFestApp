class Partner {
  const Partner({
    this.logoUrl,
    this.name,
    this.linkUrl,
  });

  final String logoUrl;
  final String name;
  final String linkUrl;

  Partner.fromMap(Map<dynamic, dynamic> data)
      : this(logoUrl: data['logoUrl'], name: data['name'], linkUrl: data['linkUrl']);
}