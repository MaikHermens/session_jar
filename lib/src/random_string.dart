import 'dart:math';

String randomString(int length) {
  var random = Random.secure();
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(length, (index) => _chars[random.nextInt(_chars.length)])
      .join();
}
