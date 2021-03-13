import 'dart:async';
import 'dart:io';
import '../session_jar.dart';

///containes all the data of one session
class Session<T> {
  final String token;
  T? body;
  final SessionJar<T> sessionJar;

  DateTime? _expiresOn;

  DateTime? get expiresOn => _expiresOn;

  //this field is used, the timer starts ticking on creation of this class
  // ignore: unused_field
  Timer? _expirationTimer;

  ///returns the session as a [Cookie]. based on the settings of its [CookieJar].
  Cookie get cookie {
    var cookie = Cookie(sessionJar.cookieName, token);
    cookie.expires = expiresOn;
    cookie.path = sessionJar.path;
    cookie.httpOnly = sessionJar.httpOnly;
    return cookie;
  }

  Session(
      {required this.token,
      this.body,
      required this.sessionJar,
      Duration? expiresIn}) {
    //sets the expirationtime to the default value if needed
    if (expiresIn == null && sessionJar.defaultExpirationTime != null) {
      expiresIn = sessionJar.defaultExpirationTime;
    }
    //starts the expirationtimer
    if (expiresIn != null) {
      _expiresOn = DateTime.now().add(expiresIn);
      _expirationTimer =
          Timer(expiresIn, () => sessionJar.deleteSession(token));
    }
  }
}
