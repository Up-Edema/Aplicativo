import 'dart:math';

class Utils {
  static String generateVerificationCode() {
    final int code = Random.secure().nextInt(10000);
    return code.toString().padLeft(4, '0');
  }
}
