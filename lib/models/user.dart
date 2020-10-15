import 'package:flutter/foundation.dart';

class User {
  String username;
  String realName;
  String profileUrl;

  User({
    @required this.username,
    this.realName,
    this.profileUrl,
  });
}