class CountryCodeModel {
  String? nameCn;
  String? nameEn;
  String? nameVn;
  String? code;

  CountryCodeModel({this.nameCn, this.nameEn, this.nameVn, this.code});

  factory CountryCodeModel.fromJson(Map<String, dynamic> json) {
    return CountryCodeModel(
      nameCn: json['nameCn'] as String?,
      nameEn: json['nameEn'] as String?,
      nameVn: json['nameVn'] as String?,
      code: json['code'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'nameCn': nameCn,
    'nameEn': nameEn,
    'nameVn': nameVn,
    'code': code,
  };
}
