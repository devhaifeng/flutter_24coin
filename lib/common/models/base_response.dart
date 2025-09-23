class BaseResponse<T> {
  int? code;
  String? msg;
  T? data;

  BaseResponse({this.code, this.msg, this.data});

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    return BaseResponse<T>(
      code: json['code'],
      msg: json['message'],
      // 这里使用传入的fromJsonT函数来解析data字段
      data: json['data'] != null ? fromJsonT(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson(Object Function(T) toJsonT) {
    return {
      'code': code,
      'message': msg,
      'data': data != null ? toJsonT(data as T) : null,
    };
  }
}
