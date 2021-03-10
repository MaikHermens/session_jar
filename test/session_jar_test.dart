import 'package:test/test.dart';
import 'package:session_jar/session_jar.dart';

void main() {
  group('SessionJar class', () {
    test('sessionExists', () {
      var sessionJar = SessionJar();
      expect(sessionJar.exists('test'), false);
      var session = sessionJar.create('myusername');
      var id = session.token;
      expect(sessionJar.exists(id), true);
    });
    test('add session test', () {
      var sessionJar = SessionJar();
      var session = sessionJar.create('myusername');
      var id = session.token;
      expect(sessionJar.exists(id), true);
    });
    test('delete session test', () {
      var sessionJar = SessionJar();
      var session = sessionJar.create('myusername');
      var id = session.token;

      expect(sessionJar.exists(id), true);

      sessionJar.deleteSession(id);

      expect(sessionJar.exists(id), false);
    });
  });

  test('Session gets removed from the jar after timeout', () async {
    var duration = Duration(microseconds: 1);
    var jar = SessionJar();
    var session = jar.create('myusername', expiresIn: duration);
    expect(jar.exists(session.token), true);

    await Future.delayed(duration);
    expect(jar.exists(session.token), false);
  });

  test('exirationdate of cookie is correct with 1 second precision', () {
    var duration = Duration(hours: 1);
    var jar = SessionJar(defaultExpirationTime: duration);
    var session = jar.create('myusername');
    var cookie = session.cookie;
    expect(roundToSeconds(cookie.expires),
        roundToSeconds(DateTime.now().add(duration)));
  });
  test('default session expirationdate gets removed after timeout', () async {
    var duration = Duration(microseconds: 1);

    //add a default expirationtime
    var jar = SessionJar(defaultExpirationTime: duration);
    var session = jar.create('username');
    //test if session is deleted after default expirationtime
    expect(jar.exists(session.token), true);
    await Future.delayed(duration);
    expect(jar.exists(session.token), false);
  });
}

//used to test if cookie expiringdate is correct
int? roundToSeconds(DateTime? dateTime) {
  if (dateTime == null) {
    return null;
  }
  return (dateTime.millisecondsSinceEpoch / 1000).round();
}
