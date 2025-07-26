import 'package:flutter/material.dart';

class InputControllers {
  static final TextEditingController email = TextEditingController();
  static final TextEditingController password = TextEditingController();
  static final TextEditingController username = TextEditingController();
  static final TextEditingController phone = TextEditingController();

  static void clearAll() {
    email.clear();
    password.clear();
    username.clear();
    phone.clear();
  }

  static void disposeAll() {
    email.dispose();
    password.dispose();
    username.dispose();
    phone.dispose();
  }
}
