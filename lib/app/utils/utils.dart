import 'dart:math';

class Utils {
  static String generateVerificationCode() {
    final int code = Random.secure().nextInt(10000);
    return code.toString().padLeft(4, '0');
  }

  static String removeDiacritics(String text) {
    final normalized = text.trim().toLowerCase();
    final withoutDiacritics = normalized.replaceAllMapped(
      RegExp(r'[\u0300-\u036f]'),
      (match) => '',
    );

    final semEmojis = withoutDiacritics.replaceAll(
      RegExp(
        r'[\u{1F600}-\u{1F64F}]|'
        r'[\u{1F300}-\u{1F5FF}]|'
        r'[\u{1F680}-\u{1F6FF}]|'
        r'[\u{2600}-\u{26FF}]|'
        r'[\u{2700}-\u{27BF}]',
        unicode: true,
      ),
      '',
    );

    final cleanup = semEmojis.replaceAll(RegExp(r'[^a-z0-9\s]'), '');
    return cleanup.replaceAll(RegExp(r'\s+'), ' ').trim();
  }
}
