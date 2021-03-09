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
    var jar = SessionJar();
    var session =
        jar.create('myusername', expiresIn: Duration(milliseconds: 100));
    expect(jar.exists(session.token), true);

    await Future.delayed(Duration(milliseconds: 100));
    expect(jar.exists(session.token), false);
  });
}
