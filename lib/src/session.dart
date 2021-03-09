import 'dart:async';
import 'dart:io';

import '../session_jar.dart';

///containes all the data of one session
class Session<T> {
  final String token;
  final T body;
  final SessionJar sessionJar;

  DateTime? expiresOn;
  Timer? expirationTimer;

  ///returns the session as a [Cookie]. based on the settings of its [CookieJar].
  Cookie get cookie {
    var cookie = Cookie(sessionJar.cookieName, token);
    cookie.expires = expiresOn;
    cookie.httpOnly = sessionJar.httpOnly;
    return cookie;
  }

  Session(
      {required this.token,
      required this.body,
      required this.sessionJar,
      Duration? expiresIn}) {
    if (expiresIn != null) {
      expiresOn = DateTime.now().add(expiresIn);
      expirationTimer = Timer(expiresIn, () => sessionJar.deleteSession(token));
    }
  }
}
