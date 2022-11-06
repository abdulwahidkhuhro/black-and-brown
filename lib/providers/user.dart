import 'package:flutter/material.dart';

class User with ChangeNotifier {
  late String userId;
  late String userName;
  late String email;
  late String phone;

  void setUser(String userId, String userName, String email, String phone) {
    this.userId = userId;
    this.userName = userName;
    this.email = email;
    this.phone = phone;
  }

  User get getCurrentUser {
    return this;
  }
}
