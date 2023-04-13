import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

class EncryptionHelper {
  static String encrypt(String input, String key) {
    final keyBytes = utf8.encode(key);
    final inputBytes = utf8.encode(input);

    final hmac = Hmac(sha256, keyBytes);
    final digest = hmac.convert(inputBytes);

    return hex.encode(digest.bytes);
  }

  static String decrypt(String input, String key) {
    // この例では暗号化されたデータの復号化は行っていません。
    // 実装が必要であれば、適切な暗号化アルゴリズムを選択し実装してください。
  }
}
