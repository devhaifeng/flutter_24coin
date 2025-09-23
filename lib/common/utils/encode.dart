import 'dart:convert';

import 'package:crypto/crypto.dart';

class RequestEncode {
  static String generateSignature(String timestamp) {
    final appKey = "B5DYBZPKP5Bj9Q02sCwXeNpWfbpSt4nG9PjJ";
    final dataToSign = "$appKey\n$timestamp";

    final signature = signWithHmacSha1(appKey, dataToSign);
    return signature.toString();
  }

  static String? signWithHmacSha1(String secretKey, String data) {
    try {
      final keyBytes = utf8.encode(secretKey);
      final dataBytes = utf8.encode(data);

      final hmac = Hmac(sha1, keyBytes);
      final digest = hmac.convert(dataBytes);

      return base64Encode(digest.bytes);
    } catch (e) {
      print('签名错误: $e');
      return null;
    }
  }
}
