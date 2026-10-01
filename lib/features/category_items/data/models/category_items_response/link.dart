class Link {
  Link({this.url, this.label, this.active});

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json['url'] as dynamic,
    label: json['label'] as String?,
    active: json['active'] as bool?,
  );
  dynamic url;
  String? label;
  bool? active;

  Map<String, dynamic> toJson() => {
    'url': url,
    'label': label,
    'active': active,
  };
}
