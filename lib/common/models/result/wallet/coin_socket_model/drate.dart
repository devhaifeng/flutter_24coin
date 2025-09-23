class ItemEntity {
  String? S;
  double? t;
  double? a;
  double? c;
  double? v;
  double? u;
  String? availableSupply;
  String? logoUrl;
  bool? isAllKline;

  ItemEntity({
    this.S,
    this.t,
    this.a,
    this.c,
    this.v,
    this.u,
    this.availableSupply,
    this.logoUrl,
    this.isAllKline,
  });

  factory ItemEntity.fromJson(Map<String, dynamic> json) {
    return ItemEntity(
      S: json['S'] as String?,
      t: (json['t'] as num?)?.toDouble(),
      a: (json['a'] as num?)?.toDouble(),
      c: (json['c'] as num?)?.toDouble(),
      v: (json['v'] as num?)?.toDouble(),
      u: (json['u'] as num?)?.toDouble(),
      availableSupply: json['availableSupply'] as String?,
      logoUrl: json['logoUrl'] as String?,
      isAllKline: json['isAllKline'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
    'S': S,
    't': t,
    'a': a,
    'c': c,
    'v': v,
    'u': u,
    'availableSupply': availableSupply,
    'logoUrl': logoUrl,
    'isAllKline': isAllKline,
  };
}
