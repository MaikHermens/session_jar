import 'package:test/test.dart';
import 'package:session_jar/session_jar.dart';

void main() {
  group('Session class', () {
    var sessionJar = SessionJar();

    test('session id equals cookie id', () {
      var sessionid = '123456';

      var session = Session<String>(
          token: sessionid, body: 'username', sessionJar: sessionJar);

      expect(session.cookie.value, sessionid);
    });
  });
}
