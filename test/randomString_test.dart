import 'package:session_jar/src/random_string.dart' as testedfile;
import 'package:test/test.dart';

void main() {
  group('random string method', () {
    test('checkRandomStringLength', () {
      final length = 32;

      var randomString = testedfile.randomString(length);

      expect(randomString.length, length);
    });
  });
}
