import 'dart:math';

class StringGenerate {
  static String uuid([int length = 9]) {
    Random r = Random();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(length, (index) => _chars[r.nextInt(_chars.length)]).join();
  }
}
