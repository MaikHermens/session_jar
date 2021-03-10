import 'package:test/test.dart';
import 'package:session_jar/session_jar.dart';

void main() {
  group('Session class', () {
    test('session id equals cookie id', () {
      var sessionJar = SessionJar();
      var sessionid = '123456';

      var session = Session<String>(
          token: sessionid, body: 'username', sessionJar: sessionJar);

      expect(session.cookie.value, sessionid);
    });
  });
  test('session is modifiable', () {
    var sessionJar = SessionJar();
    var sessionid = '123456';

    var session = Session<String>(token: sessionid, sessionJar: sessionJar);

    expect(session.body, null);
    session.body = 'username';
    expect(session.body, 'username');
  });
}
