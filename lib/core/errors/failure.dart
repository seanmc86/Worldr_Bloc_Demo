import 'package:flutter/foundation.dart';

class NetworkError extends Error {}

class Failure extends Error {
  final String message;

  Failure({@required this.message});
}
