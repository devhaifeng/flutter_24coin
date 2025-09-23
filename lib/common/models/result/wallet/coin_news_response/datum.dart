class Datum {
  List<dynamic>? images;
  bool? importance;
  String? source;
  String? title;
  String? content;
  String? url;
  int? timestamp;

  Datum({
    this.images,
    this.importance,
    this.source,
    this.title,
    this.content,
    this.url,
    this.timestamp,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    images: json['images'] as List<dynamic>?,
    importance: json['importance'] as bool?,
    source: json['source'] as String?,
    title: json['title'] as String?,
    content: json['content'] as String?,
    url: json['url'] as String?,
    timestamp: json['timestamp'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'images': images,
    'importance': importance,
    'source': source,
    'title': title,
    'content': content,
    'url': url,
    'timestamp': timestamp,
  };
}
