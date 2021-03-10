# Session Jar

A simple server side package for creating and maintaining sessions in dart.

## Usage

```dart
import 'package:session_jar/session_jar.dart';

void main() {
  //create a session jar
  var sessionJar = SessionJar();

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

## To do:

- [ ] Every session has its own expiration timer. this is not efficient in large projects. So I will improve the automatic session deletion in the future.

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/MaikHermens/session_jar/issues
