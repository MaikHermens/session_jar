# Session Jar

A simple lightweight package for creating and maintaining sessions in dart.

## Usage

A simple usage example:

```dart
import 'package:session_jar/session_jar.dart';

void main() {
  //create a session jar
  var sessionJar = SessionJar<String>();

//add a session to your sessionjar
  var newSession =
      sessionJar.create('username', expiresIn: Duration(hours: 12));

//send your session back to the client as a cookie
  var cookie = newSession.cookie;
  print(newSession.cookie);

//get a session from a cookie
  var sessionFromRequest = sessionJar.fromCookie(cookie);

  //do something with your session data
  print(sessionFromRequest?.body ?? 'session not found!');
}

```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/MaikHermens/session_jar/issues
