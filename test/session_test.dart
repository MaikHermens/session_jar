import 'package:test/test.dart';
import 'package:session_jar/session_jar.dart';

void main() {
  group('Session class', () {
    test('session id equals cookie id', () {
      var sessionJar = SessionJar<String>();
      var sessionid = '123456';

      var session = Session<String>(
          token: sessionid, body: 'username', sessionJar: sessionJar);

      expect(session.cookie.value, sessionid);
    });
  });
  test('session is modifiable', () {
    var sessionJar = SessionJar<String>();
    var sessionid = '123456';

    var session = Session<String>(token: sessionid, sessionJar: sessionJar);

    expect(session.body, null);
    session.body = 'username';
    expect(session.body, 'username');
  });

  test("session path defaults to '/' ", () {
    var sessionJar = SessionJar<String>();
    var sessionid = '123456';
    var session = Session<String>(token: sessionid, sessionJar: sessionJar);

    expect(session.cookie.path, '/');
  });
  test('session path is modifieable', () {
    var sessionJar = SessionJar<String>(path: '/api');
    var sessionid = '123456';
    var session = Session<String>(token: sessionid, sessionJar: sessionJar);

    expect(session.cookie.path, '/api');
  });
}
