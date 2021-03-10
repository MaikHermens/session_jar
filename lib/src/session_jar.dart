import 'dart:collection';
import 'dart:io';
import 'random_string.dart';
import '../session_jar.dart';

///collection of [Session].
class SessionJar<T> {
  final int tokenLength;
  final String cookieName;
  final bool httpOnly;
  final Duration? defaultExpirationTime;
  var _sessions = HashMap<String, Session<T>>();

  ///the amount of sessions currently in the sessionJar.
  int get size => _sessions.length;
  SessionJar(
      {this.tokenLength = 32,
      this.cookieName = 'sessionJarId',
      this.httpOnly = true,
      this.defaultExpirationTime});

  ///Creates a new session and adds it to this jar.
  Session create({T? body, Duration? expiresIn, String? token}) {
    token ??= _findUnusedToken();

    var session = Session(
        token: token, body: body, expiresIn: expiresIn, sessionJar: this);
    _sessions[token] = session;
    return session;
  }

  ///Gets a [Session] from the jar with the same token as a cookie.
  Session<T>? fromCookie(Cookie cookie) => _sessions[cookie.value];

  ///Gets a [Session] from the jar with a certain token.
  Session<T>? fromId(String token) => _sessions[token];

  ///returns if a [Session] with a certain token exists.
  bool exists(String token) => _sessions.containsKey(token);

  ///removes a Session with a certain token from the jar.
  void deleteSession(String? token) {
    _sessions.remove(token);
  }

  ///removes all current sessions.
  void deleteAllSessions() => _sessions = HashMap<String, Session<T>>();

  String _findUnusedToken() {
    String token;
    bool exists;
    do {
      token = randomString(tokenLength);
      exists = _sessions.containsKey(token);
    } while (exists);
    return token;
  }
}
