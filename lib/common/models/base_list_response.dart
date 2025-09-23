/// 通用的列表响应模型
class BaseListResponse<T> {
  final int? code; // 状态码
  final String? msg; // 消息
  final List<T>? data; // 数据列表

  /// 是否成功（根据业务逻辑自定义）
  bool get isSuccess => code == 200 || code == 0;

  /// 安全获取数据列表（防止空值）
  List<T> get safeData => data ?? [];

  BaseListResponse({this.code, this.msg, this.data});

  /// 从 JSON 创建实例（无需额外依赖）
  factory BaseListResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> json) itemConverter,
  ) {
    // 处理嵌套列表数据
    List<T>? parseData(dynamic data) {
      if (data == null) return null;
      if (data is List) {
        return data.map<T>((item) {
          return itemConverter(item);
        }).toList();
      }
      return null;
    }

    return BaseListResponse<T>(
      code: json['code'] ?? json['status'] ?? json['errno'] as int?,
      msg: json['msg'] ?? json['message'] ?? json['errmsg'] as String?,
      data: parseData(json['data']),
    );
  }

  /// 转换为 JSON（支持自定义序列化）
  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) itemSerializer) {
    return {
      'code': code,
      'msg': msg,
      'data': data?.map((e) => itemSerializer(e)).toList(),
    };
  }

  @override
  String toString() {
    return 'BaseListResponse{code: $code, msg: $msg, data: ${safeData.length} items}';
  }
}
